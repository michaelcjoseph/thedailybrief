require_relative '../news_helpers/rss_helper'

class Vox
  def initialize( date, word_count_min )
    @rss_url = 'http://www.vox.com/rss/index.xml'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The Vox RSS Feed

    # CSS Tags to find image url
    css_tags = ['.c-picture', 'img']

    # Stop words to verify title with
    stop_words = ['Vox Sentences:']

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.published >= Time.parse(@date)
          title = RssHelper.html_to_text(item.title)
          word_count = RssHelper.word_count( RssHelper.html_to_text(item.content) )

          image_urls = RssHelper.get_image(item.id, css_tags, 'srcset')
          image_url = parse_img_srcset( image_urls )
          
          if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
            @results.push({
              'web_url': item.id,
              'title': title,
              'image_url': image_url,
              'snippet': '',
              'word_count': word_count
            })
          end
        end
      end
    end
  end

  def parse_img_srcset( srcset )
    images = srcset.split(',')
    images.each do |image|
      link = image.split(' ')
      if link[1] == '1020w'
        return link[0]
      end
    end

    return ''
  end

  def get_results
    return @results
  end
end