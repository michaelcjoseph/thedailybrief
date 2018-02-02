require_relative '../news_helpers/rss_helper'

class AmericanConservative
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.theamericanconservative.com/articles/feed/'
      #'http://www.theamericanconservative.com/dreher/feed/',
      #'http://www.theamericanconservative.com/larison/feed/',
      #'http://www.theamericanconservative.com/mccarthy/feed/',
      #'http://www.theamericanconservative.com/millman/feed/'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The American Conservative RSS Feed

    # CSS Tags to find image url
    css_tags = ['.main-image', 'img']
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            word_count = RssHelper.word_count( RssHelper.html_to_text(item.xpath('content:encoded').text) )

            if word_count > @word_count_min
              article_url = item.at('link').text
              title = RssHelper.html_to_text(RssHelper.html_to_text(item.at('title').text))
              snippet = RssHelper.html_to_text(item.at('description').text)
              image_url = RssHelper.get_image(article_url, css_tags)

              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(title),
                'image_url': image_url,
                'snippet': snippet,
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