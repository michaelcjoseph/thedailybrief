require_relative '../news_helpers/rss_helper'

class IGN
  def initialize( date, word_count_min )
    @rss_url = 'http://feeds.ign.com/ign/articles'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse IGN RSS Feed

    # Stop words to verify title with
    stop_words = ['Deals:']

    # CSS Tags to find image url
    css_tags = ['.img-div', 'img']

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate
          if item.pubDate >= Time.parse(@date)
            article_url = item.feedburner_origLink
            title = RssHelper.html_to_text(item.title)
            word_count = RssHelper.get_word_count( article_url, "div[itemprop='articleBody']" )
            
            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              @results.push({
                'web_url': article_url,
                'title': title,
                'image_url': RssHelper.get_image(article_url, css_tags),
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