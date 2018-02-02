require_relative '../news_helpers/rss_helper'

class TheWeeklyStandard
  def initialize( date, word_count_min )
    @rss_url = 'http://www.weeklystandard.com/rss/all'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Weekly Standard RSS Feed

    # CSS Tags to find image url
    css_tags = ['.lead-photo', 'img']

    # Stop words to verify snippet with
    stop_words = ['MATT LABASH']

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          article_url = item.link
          snippet = RssHelper.html_to_text(item.description)
          word_count = RssHelper.get_word_count( article_url, '.body-text' )
          
          if word_count > @word_count_min && RssHelper.verify_title(snippet, stop_words)
            @results.push({
              'web_url': article_url,
              'title': RssHelper.html_to_text(item.title),
              'image_url': RssHelper.get_image(article_url, css_tags),
              'snippet': snippet,
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