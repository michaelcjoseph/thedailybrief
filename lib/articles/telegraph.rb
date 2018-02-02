require_relative '../news_helpers/rss_helper'

class Telegraph
  # Currently not being used in news reader because quality of articles is
  # debatable
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.telegraph.co.uk/news/rss.xml',
      'http://www.telegraph.co.uk/sport/rss.xml',
      'http://www.telegraph.co.uk/business/rss.xml',
      'http://www.telegraph.co.uk/money/rss.xml',
      'http://www.telegraph.co.uk/travel/rss.xml',
      'http://www.telegraph.co.uk/science-technology/rss.xml',
      'http://www.telegraph.co.uk/culture/rss.xml',
      'http://www.telegraph.co.uk/films/rss.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Telegraph RSS Feed

    # CSS Tags to find image url
    css_tags = ['.articleBodyImage', 'img']
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            word_count = RssHelper.get_word_count( article_url, "article[itemprop='articleBody']" )

            if word_count > @word_count_min
              title = RssHelper.html_to_text(item.at('title').text)
              image_url_shortpath = RssHelper.get_image(article_url, css_tags)

              if image_url_shortpath == ''
                image_url = ''
              else
                image_url = 'http://www.telegraph.co.uk' + image_url_shortpath
              end

              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(title),
                'image_url': image_url,
                'snippet': '',
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