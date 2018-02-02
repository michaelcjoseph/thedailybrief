require_relative '../news_helpers/rss_helper'

class CatoInstitute
  def initialize( date, word_count_min )
    @rss_url = 'https://www.cato.org/rss/homepage-headlines'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Cato Institute RSS Feed

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          article_url = item.link
          word_count = RssHelper.get_word_count( article_url, '.body-text' )
          
          if word_count > @word_count_min
            @results.push({
              'web_url': article_url,
              'title': RssHelper.html_to_text(item.title),
              'image_url': '',
              'snippet': RssHelper.html_to_text(item.description),
              'word_count': word_count
            })
          end
        end
      end
    end
  end

  def get_results
    return @results
  end
end