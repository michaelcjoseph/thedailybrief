require_relative '../news_helpers/rss_helper'

class ArsTechnica
  def initialize( date, word_count_min )
    @rss_url = [
      'http://feeds.arstechnica.com/arstechnica/technology-lab',
      'http://feeds.arstechnica.com/arstechnica/gadgets',
      'http://feeds.arstechnica.com/arstechnica/business',
      'http://feeds.arstechnica.com/arstechnica/security',
      'http://feeds.arstechnica.com/arstechnica/tech-policy',
      'http://feeds.arstechnica.com/arstechnica/apple',
      'http://feeds.arstechnica.com/arstechnica/science',
      'http://feeds.arstechnica.com/arstechnica/multiverse',
      'http://feeds.arstechnica.com/arstechnica/cars',
      'http://feeds.arstechnica.com/arstechnica/staff-blogs'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Ars Technica RSS Feed

    # CSS Tags to find image url
    css_tags = ['.intro-image', 'img']

    # Stop words to verify title with
    stop_words = ['Review:', 'review:']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            title = RssHelper.html_to_text(item.at('title').text)
            snippet = RssHelper.html_to_text(item.at('description').text)
            word_count = RssHelper.get_word_count( article_url, "div[itemprop='articleBody']" )

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words) 
              @results.push({
                'web_url': article_url,
                'title': title,
                'image_url': RssHelper.get_image(article_url, css_tags),
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