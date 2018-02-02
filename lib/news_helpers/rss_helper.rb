require 'open-uri'
require 'open_uri_redirections'
require_relative '../classifier'

module RssHelper
	def RssHelper.get_html_content( url )
		# Given a URL, open it using Nokogiri and return the html doc
		# Redirections are allowed for http -> https

		begin
			return Nokogiri::HTML(open(url, :allow_redirections => :all))
		rescue Exception => e
			Rails.logger.info("Couldn't read \"#{ url }\": #{ e }")
			puts "Couldn't read \"#{ url }\": #{ e }"
			return nil
		end
	end

	def RssHelper.read_feed( url )
		# Given an RSS feed url, return a SimpleRSS object that parses the url

		begin
			return SimpleRSS.parse open( url )
		rescue Exception => e
			Rails.logger.info("Couldn't read \"#{ url }\": #{ e }")
			puts "Couldn't read \"#{ url }\": #{ e }"
			return nil
		end
	end

	def RssHelper.nokogiri_read_feed( url )
		# Given an RSS feed url, parse the feed using Nokogiri XML reader

		begin
			doc = Nokogiri::XML(open(url))
			return doc.css('item')
		rescue Exception => e
			Rails.logger.info("Couldn't read \"#{ url }\": #{ e }")
			puts "Couldn't read \"#{ url }\": #{ e }"
			return nil
		end
	end

	def RssHelper.get_word_count( url, css_tag )
		# Given a URL and specific tag, count the number of words within that
		# section of the HTML doc

		page = RssHelper.get_html_content(url)
		if page
			if page.at_css(css_tag)
				text = RssHelper.html_to_text(page.at_css(css_tag).to_html)
				return RssHelper.word_count( text )
			end
		end

		Rails.logger.info("Couldn't read \"#{ url }\" because of 0 word count")
		puts "Couldn't read \"#{ url }\" because of 0 word count"
		return 0
	end

	def RssHelper.word_count( word )
		# Given a string, returns an integer of the number of words in the string
		# Words are determined by splitting by spaces

		return word.split(/\s+/).length
	end

	def RssHelper.html_to_text( html )
		# Convert the passed html object to text

		x = Nokogiri::HTML(html).text
		return Nokogiri::HTML(x).text
	end

	def RssHelper.get_image( url, css_tags, src_tag = 'src' )
		# Given an html link, find the image source link within specific css tags

		parse_page = RssHelper.get_html_content(url)

		if parse_page
			image_link = parse_page.at_css(css_tags[0])
			
			for i in (1..(css_tags.length - 1))
				if image_link
					image_link = image_link.at_css(css_tags[i])
				else
					break
				end
			end

			if image_link
				return image_link[src_tag].to_s
			end
		end

		return ''
	end

	def RssHelper.convert_duration_to_secs( duration )
		# Convert duration given in the format hh:mm:ss to seconds

		time = duration.split(':')
    return time[0].to_i * 3600 + time[1].to_i * 60 + time[2].to_i
	end

	def RssHelper.verify_date( date )
		# Check pub date of item in RSS Feed to ensure that is in fact a real date
		begin
			Time.parse( date )
			return true
		rescue Exception => e
			Rails.logger.info("Couldn't read \"#{ date }\": #{ e }")
			puts "Couldn't read \"#{ date }\": #{ e }"
			return false
		end
	end

	def RssHelper.verify_title( title, stop_words )
		# Function receives the title to evaluate along with an array of stop strings
		# that make the title not acceptable to be included in DB

		stop_words.each do |word|
			if title.include? word
				return false
			end
		end

		return true
	end

	def RssHelper.get_topic( title, snippet )
		text = title + " " + snippet
		return Classifier.classify_text( text )
	end

	def RssHelper.parse_medium_feed( url, date, word_count_min )
		# All medium publications have the same rss feed and url format
		# Use the same parser for all of them
		results = []
		feed = RssHelper.read_feed( url )

    # CSS Tags to find image url
    css_tags = ['.graf--figure', 'img']

    if feed
      # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(date)
          article_url = item.link
          title = RssHelper.html_to_text(item.title)
          snippet = RssHelper.html_to_text(item.description)
          word_count = RssHelper.get_word_count( article_url, '.section-content' )

          if word_count > word_count_min
            results.push({
              'web_url': article_url,
              'title': title,
              'image_url': RssHelper.get_image(article_url, css_tags),
              'snippet': snippet,
              'word_count': word_count
            })
          end
        end
      end
    end

    return results
	end
end