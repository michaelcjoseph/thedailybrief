require_relative '../news_helpers/rss_helper'

class Bright
  def initialize( date, word_count_min )
    @rss_url = 'https://brightreads.com/feed'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Bright RSS Feed
    # Medium Publication
    @results = RssHelper.parse_medium_feed( @rss_url, @date, @word_count_min )
  end

  def get_results
    return @results
  end
end