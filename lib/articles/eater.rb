require_relative '../news_helpers/rss_helper'

class Eater
  def initialize( date, word_count_min )
    @rss_url = [
      'http://atlanta.eater.com/rss/index.xml',
      'http://austin.eater.com/rss/index.xml',
      'http://boston.eater.com/rss/index.xml',
      'http://charleston.eater.com/rss/index.xml',
      'http://chicago.eater.com/rss/index.xml',
      'http://dallas.eater.com/rss/index.xml',
      'http://denver.eater.com/rss/index.xml',
      'http://detroit.eater.com/rss/index.xml',
      'http://houston.eater.com/rss/index.xml',
      'http://vegas.eater.com/rss/index.xml',
      'http://la.eater.com/rss/index.xml',
      'http://miami.eater.com/rss/index.xml',
      'http://minneapolis.eater.com/rss/index.xml',
      'http://montreal.eater.com/rss/index.xml',
      'http://nashville.eater.com/rss/index.xml',
      'http://nola.eater.com/rss/index.xml',
      'http://ny.eater.com/rss/index.xml',
      'http://philly.eater.com/rss/index.xml',
      'http://pdx.eater.com/rss/index.xml',
      'http://sandiego.eater.com/rss/index.xml',
      'http://sf.eater.com/rss/index.xml',
      'http://seattle.eater.com/rss/index.xml',
      'http://dc.eater.com/rss/index.xml',
      'http://www.eater.com/rss/index.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Eater RSS Feed

    # CSS Tags to find image url
    css_tags = ['.c-picture', 'img']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.published >= Time.parse(@date)
            word_count = RssHelper.word_count( RssHelper.html_to_text(item.content) )
            
            if word_count > @word_count_min
              image_urls = RssHelper.get_image(item.id, css_tags, 'srcset')
              image_url = parse_img_srcset( image_urls )

              @results.push({
                'web_url': item.link,
                'title': RssHelper.html_to_text(item.title),
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

  def parse_img_srcset( srcset )
    images = srcset.split(',')
    images.each do |image|
      link = image.split(' ')
      if link[1] == '1020w' || link[1] == '900w'
        return link[0]
      end
    end

    return ''
  end

  def get_results
    return @results
  end
end