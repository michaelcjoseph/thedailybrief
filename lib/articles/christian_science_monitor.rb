require_relative '../news_helpers/rss_helper'

class ChristianScienceMonitor
  def initialize( date, word_count_min )
    @rss_url = [
      'http://rss.csmonitor.com/feeds/arts',
      'http://rss.csmonitor.com/feeds/environment',
      'http://rss.csmonitor.com/feeds/scitech',
      'http://rss.csmonitor.com/feeds/wam',
      'http://rss.csmonitor.com/feeds/passcode',
      'http://rss.csmonitor.com/feeds/politics',
      'http://rss.csmonitor.com/feeds/science',
      'http://rss.csmonitor.com/feeds/usa',
      'http://rss.csmonitor.com/feeds/world'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Christian Science Monitor RSS Feed

    # CSS Tags to find image url
    css_tags = ['.ezc-image', 'img']

    # Stop words to verify title with
    stop_words = ['Opinion:']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          article_url = item.at('link').text
          pub_date = get_pub_date( article_url )
          if pub_date
            if Time.parse(pub_date) >= Time.parse(@date)
              word_count = RssHelper.get_word_count( article_url, '.eza-body' )
              title = RssHelper.html_to_text(item.at('title').text)

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
  end

  def get_pub_date( url )
    page = RssHelper.get_html_content(url)

    css_tags = ['.pubdata', 'time']

    if page
      if page
        pub_date = page.at_css(css_tags[0])
        
        for i in (1..(css_tags.length - 1))
          if pub_date
            pub_date = pub_date.at_css(css_tags[i])
          else
            break
          end
        end

        if pub_date
          return pub_date['datetime'].to_s
        end
      end

      return nil
    end
  end

  def get_results
    return @results
  end
end