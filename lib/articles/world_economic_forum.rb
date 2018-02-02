require_relative '../news_helpers/rss_helper'

class WorldEconomicForum
  def initialize( date, word_count_min )
    @rss_url = 'https://medium.com/feed/world-economic-forum'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse World Economic Forum RSS Feed
    # Medium Publication
    @results = RssHelper.parse_medium_feed( @rss_url, @date, @word_count_min )
  end

  def get_results
    return @results
  end
end