require_relative '../news_helpers/rss_helper'

class Priceonomics
  def initialize( date, word_count_min )
    @rss_url = [
      'https://priceonomics.com/latest.rss',
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Priceonomics Articles RSS Feed
    
    # CSS Tags to find image url
    css_tags = ['.blog-content', 'img']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate >= Time.parse(@date)
            word_count = RssHelper.get_word_count( item.link, '.blog-content' )
            if word_count >  500 # @word_count_min
              @results.push({
                'web_url': item.link,
                'title': RssHelper.html_to_text(item.title),
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