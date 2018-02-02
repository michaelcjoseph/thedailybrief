require_relative '../news_helpers/rss_helper'

class NiskanenCenter
  def initialize( date, word_count_min )
    @rss_url = [
      'https://niskanencenter.org/feed/',
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Niskanen Center RSS Feed

    # CSS Tags to find image url
    css_tags = ['.hero-img', 'img']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            word_count = RssHelper.word_count( RssHelper.html_to_text(item.xpath('content:encoded').text) )

            if word_count > @word_count_min
              title = RssHelper.html_to_text(item.at('title').text)
              description = RssHelper.html_to_text(item.at('description').text)

              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(title),
                'image_url': RssHelper.get_image(article_url, css_tags),
                'snippet': description,
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