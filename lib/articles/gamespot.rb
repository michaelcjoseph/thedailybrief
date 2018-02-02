require_relative '../news_helpers/rss_helper'

class Gamespot
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.gamespot.com/feeds/mashup/',
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Gamespot RSS Feed

    # CSS Tags to find image url
    css_tags = ['.fluid-height', 'img']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            word_count = RssHelper.get_word_count( article_url, "section[itemprop='articleBody']" )

            if word_count > @word_count_min
              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(item.at('title').text),
                'image_url': RssHelper.get_image(article_url, css_tags),
                'snippet': RssHelper.html_to_text(item.at('description').text),
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