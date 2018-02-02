require_relative '../news_helpers/rss_helper'

class EdScoop
  def initialize( date, word_count_min )
    @rss_url = 'http://edscoop.com/rss'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse EdScoop RSS Feed

    # CSS Tags to find image url
    css_tags = ['.article_image', 'img']

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          article_url = item.link
          title = RssHelper.html_to_text(item.title)
          word_count = RssHelper.get_word_count( article_url, "#article_body" )
          
          if word_count > @word_count_min
            @results.push({
              'web_url': article_url,
              'title': title,
              'image_url': RssHelper.get_image(article_url, css_tags),
              'snippet': get_snippet( article_url ),
              'word_count': word_count
            })
          end
        end
      end
    end
  end

  def get_snippet( url )
    page = RssHelper.get_html_content( url )

    if page
      snippet = page.at_css('.tagline').text
      if snippet
        return RssHelper.html_to_text(snippet)
      end
    end

    return ''
  end

  def get_results
    return @results
  end
end