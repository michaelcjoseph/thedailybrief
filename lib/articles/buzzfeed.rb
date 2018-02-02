require_relative '../news_helpers/rss_helper'

class Buzzfeed
  def initialize( date, word_count_min )
    @rss_url = [
      'https://www.buzzfeed.com/longform.xml',
      'https://www.buzzfeed.com/reader.xml',
      'https://www.buzzfeed.com/tech.xml',
      'https://www.buzzfeed.com/world.xml',
      'https://www.buzzfeed.com/sports.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Buzzfeed RSS Feeds

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          title = RssHelper.html_to_text(item.at('title').text)
          article_url = item.at('link').text

          if (title.include? 'This Week') == false
            if item.at('pubDate').text >= Time.parse(@date)
              word_count = RssHelper.get_word_count( article_url, '.buzz_superlist_item_text' )
              if word_count > @word_count_min
                @results.push({
                  'web_url': article_url,
                  'title': RssHelper.html_to_text(title),
                  'image_url': get_image_url(url, article_url),
                  'snippet': item.xpath("media:group/*[name()='media:description']").text,
                  'word_count': word_count
                })
              end
            end
          end
        end
      end
    end
  end

  def get_image_url( feed_url, article_url )
    if feed_url == 'https://www.buzzfeed.com/longform.xml'
      css_tags = ['.longform_custom_header_media', '.bf_dom']
      return RssHelper.get_image(article_url, css_tags, 'rel:bf_image_src')
    else
      css_tags = ['.buzz_superlist_item_text', '.bf_dom']
      return RssHelper.get_image(article_url, css_tags, 'rel:bf_image_src')
    end

    return ''
  end

  def get_results
    return @results
  end
end