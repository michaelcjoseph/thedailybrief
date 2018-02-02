require_relative '../news_helpers/rss_helper'

class FiveThirtyEight
	def initialize( date, word_count_min )
		@rss_url = 'https://fivethirtyeight.com/all/feed'
		@date = date
		@word_count_min = word_count_min
		@results = []
		parse_feed() 
	end

	def parse_feed
		# Parse FiveThirtyEight RSS Feed

		feed = RssHelper.read_feed( @rss_url )

		# Stop words to verify title with
    stop_words = ['Significant Digits']

		if feed
			# Iterate through each of the items in the RSS Feed
			feed.items.each do |item|
				if item.pubDate >= Time.parse(@date)
					title = RssHelper.html_to_text(item.title)

					if RssHelper.verify_title(title, stop_words) 
						word_count = RssHelper.word_count( RssHelper.html_to_text(item.content_encoded) )

						if word_count > @word_count_min
							@results.push({
								'web_url': item.link,
								'title': title,
								'image_url': item.media_content_url,
								'snippet': RssHelper.html_to_text(item.description),
								'word_count': word_count
							})
						end
					end
				end
			end
		end
	end

	def get_results
		return @results
	end
end