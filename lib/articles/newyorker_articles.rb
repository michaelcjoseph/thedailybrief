require_relative '../news_helpers/rss_helper'

class NewYorkerArticles
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.newyorker.com/feed/articles',
      'http://www.newyorker.com/feed/news',
      'http://www.newyorker.com/feed/culture',
      'http://www.newyorker.com/feed/humor',
      'http://www.newyorker.com/feed/tech',
      'http://www.newyorker.com/feed/business'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse New Yorker Articles RSS Feed
    
    # CSS Tags to find image url
    css_tags = ['.image']

    # Stop words to verify title with
    stop_words = ['Your Questions About']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate >= Time.parse(@date)
            word_count = RssHelper.get_word_count( item.link, '#content' )
            title = RssHelper.html_to_text(item.title)
            
            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              @results.push({
                'web_url': item.link,
                'title': title,
                'image_url': RssHelper.get_image(item.link, css_tags, 'href'),
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