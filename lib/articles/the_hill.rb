require_relative '../news_helpers/rss_helper'

class TheHill
  def initialize( date, word_count_min )
    @rss_url = [
      'http://thehill.com/rss/syndicator/19109',
      'http://thehill.com/taxonomy/term/39/feed',
      'http://thehill.com/taxonomy/term/28/feed',
      'http://thehill.com/taxonomy/term/30/feed',
      'http://thehill.com/taxonomy/term/33/feed',
      'http://thehill.com/taxonomy/term/27/feed',
      'http://thehill.com/taxonomy/term/38/feed',
      'http://thehill.com/taxonomy/term/43/feed',
      'http://thehill.com/taxonomy/term/49/feed',
      'http://thehill.com/taxonomy/term/20/feed'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The Hill RSS Feed
    
    # CSS Tags to find image url
    css_tags = ['.content-img', 'img']

    # Stop words to verify title with
    stop_words = ['Overnight']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate >= Time.parse(@date)
            title = RssHelper.html_to_text(item.title)
            word_count = RssHelper.get_word_count( item.link, '.content-wrp' )

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