require_relative '../news_helpers/rss_helper'

class TheDevelopmentSet
  def initialize( date, word_count_min )
    @rss_url = 'https://thedevelopmentset.com/feed'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The Development Set RSS Feed
    # Medium Publication
    @results = RssHelper.parse_medium_feed( @rss_url, @date, @word_count_min )
  end

  def get_results
    return @results
  end
end