require_relative '../news_helpers/rss_helper'

class MIT
  def initialize( date, word_count_min )
    @rss_url = [
      'https://www.technologyreview.com/stories.rss', # All stories
      # 'https://www.technologyreview.com/c/biomedicine/rss/', # Biomedicine
      # 'https://www.technologyreview.com/c/business/rss/', # Business Tech
      # 'https://www.technologyreview.com/c/computing/rss/', # Computing
      # 'https://www.technologyreview.com/c/energy/rss/', # Energy
      # 'https://www.technologyreview.com/c/mobile/rss/', # Mobile
      # 'https://www.technologyreview.com/c/robotics/rss/', # Robotics
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse MIT Technology Review RSS Feed

    # CSS Tags to find image url
    css_tags = ['.l-article-img', 'img']

    # Stop words to verify title with
    stop_words = ['The Download,']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            title = RssHelper.html_to_text(item.at('title').text)
            word_count = RssHelper.get_word_count( article_url, '.article-body__content' )

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              @results.push({
                'web_url': article_url,
                'title': title,
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