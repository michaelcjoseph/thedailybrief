require_relative '../news_helpers/rss_helper'

class Politico
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.politico.com/rss/congress.xml',
      'http://www.politico.com/rss/healthcare.xml',
      'http://www.politico.com/rss/defense.xml',
      'http://www.politico.com/rss/economy.xml',
      'http://www.politico.com/rss/energy.xml',
      'http://www.politico.com/rss/politics08.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Priceonomics Articles RSS Feed
    
    # CSS Tags to find image url
    css_tags = ['.art', 'img']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate
            if item.pubDate >= Time.parse(@date)
              word_count = RssHelper.get_word_count( item.link, '.story-text' )
              if word_count >  @word_count_min
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
  end

  def get_results
    return @results
  end
end