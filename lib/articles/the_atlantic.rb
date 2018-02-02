require_relative '../news_helpers/rss_helper'

class TheAtlantic
	def initialize( date, word_count_min )
		@rss_url = 'http://www.theatlantic.com/feed/all/'
		@date = date
		@word_count_min = word_count_min
		@results = []
		parse_feed() 
	end

	def parse_feed
		# Parse The Atlantic RSS Feed

		feed = RssHelper.read_feed( @rss_url )
		css_tags = ['.lead-img', 'img']

		# Stop words to verify title with
    stop_words = ['The Atlantic Daily:']

		if feed
			# Iterate through each of the items in the RSS Feed
			feed.items.each do |item|
				if item.published >= Time.parse(@date)
					word_count = RssHelper.word_count( item.content )
					title = RssHelper.html_to_text(item.title)

					if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
						@results.push({
							'web_url': item.link,
							'title': title,
							'image_url': RssHelper.get_image(item.link, css_tags),
							'snippet': RssHelper.html_to_text(item.summary),
							'word_count': word_count
						})
					end
				end
			end
		end
	end

	def get_results
		return @results
	end
end