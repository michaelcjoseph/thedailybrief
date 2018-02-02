require_relative '../news_helpers/rss_helper'

class FiscalTimes
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.thefiscaltimes.com/feeds/columns/rss.xml',
      'http://www.thefiscaltimes.com/feeds/articles/138677/rss.xml',
      'http://www.thefiscaltimes.com/feeds/articles/138678/rss.xml',
      'http://www.thefiscaltimes.com/feeds/articles/138679/rss.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Fiscal Times RSS Feed
    
    # CSS Tags to find image url
    css_tags = ['.hero-img', 'img']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate >= Time.parse(@date)
            word_count = RssHelper.word_count( RssHelper.html_to_text(item.description) )
            if word_count > @word_count_min
              @results.push({
                'web_url': item.link,
                'title': RssHelper.html_to_text(item.title),
                'image_url': RssHelper.get_image(item.link, css_tags),
                'snippet': '',
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