require_relative '../news_helpers/rss_helper'

class Npr
	def initialize( date, word_count_min )
		@rss_url = [
			'http://www.npr.org/rss/rss.php?id=1003',
			'http://www.npr.org/rss/rss.php?id=1004',
			'http://www.npr.org/rss/rss.php?id=1014',
			'http://www.npr.org/rss/rss.php?id=1006',
			'http://www.npr.org/rss/rss.php?id=1019',
			'http://www.npr.org/rss/rss.php?id=1007',
			'http://www.npr.org/rss/rss.php?id=1128',
			'http://www.npr.org/rss/rss.php?id=173754155',
			'http://www.npr.org/rss/rss.php?id=311911180',
			'http://www.npr.org/rss/rss.php?id=1045',
			'http://www.npr.org/rss/rss.php?id=1048',
			'http://www.npr.org/rss/rss.php?id=1053',
			'http://www.npr.org/rss/rss.php?id=1047',
			'http://www.npr.org/rss/rss.php?id=1046',
			'http://www.npr.org/rss/rss.php?id=1143'
		]
		@date = date
		@word_count_min = word_count_min
		@results = []
		parse_feed() 
	end

	def parse_feed
		# Parse NPR RSS Feed
		
		# CSS Tags to find image url
		css_tags = ['#storytext', '.img']

		# Stop words to verify title with
    stop_words = ['VIDEO:']

		@rss_url.each do |url|
			feed = RssHelper.read_feed( url )

			if feed
				feed.items.each do |item|
					if item.pubDate >= Time.parse(@date)
						word_count = RssHelper.get_word_count( item.link, '#storytext' )
						title = RssHelper.html_to_text(item.title)

						if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
							@results.push({
								'web_url': item.link,
								'title': title,
								'image_url': RssHelper.get_image(item.link, css_tags),
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