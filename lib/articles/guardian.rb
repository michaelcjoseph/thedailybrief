require_relative '../news_helpers/rss_helper'

class Guardian
  def initialize( date, word_count_min )
    @rss_url = [
      'https://www.theguardian.com/us/rss',
      'https://www.theguardian.com/uk/rss',
      'https://www.theguardian.com/au/rss',
      'https://www.theguardian.com/international/rss',
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Guardian RSS Feed

    # Stop words to verify title with
    stop_words = [
      'live!', 'business live', 'follow it live', 'Politics live', 
      ' - as it happened', 'Friday Briefing:', 'live webchat', 'quiz',
      'Tuesday briefing:', 'Monday briefing:', 'Wednesday briefing:',
      'Thursday briefing:', 'Tuesday Briefing:', 'Monday Briefing:', 
      'Wednesday Briefing:', 'Thursday Briefing:', 'Friday briefing:',
      'live updates'
    ]
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            title = RssHelper.html_to_text(item.at('title').text)
            word_count = RssHelper.get_word_count( article_url, "div[itemprop='articleBody']" )

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              description = RssHelper.html_to_text(item.at('description').text)
              image_url = item.xpath('media:content[@width="460"]/@url').text

              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(title),
                'image_url': image_url,
                'snippet': description,
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