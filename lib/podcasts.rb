require_relative './news_helpers/news_date'
require_relative './news_helpers/rss_helper'
require_relative './classifier_helpers/classifier_helper'
require_relative './podcasts/code_switch'
require_relative './podcasts/ted_talks'
require_relative './podcasts/newyorker_podcast'
require_relative './podcasts/planet_money'
require_relative './podcasts/a16z_podcasts'
require_relative './podcasts/from_scratch'
require_relative './podcasts/only_a_game'
require_relative './podcasts/embedded'
require_relative './podcasts/hidden_brain'
require_relative './podcasts/bill_simmons'
require_relative './podcasts/the_read'
require_relative './podcasts/inside_intercom'

class PodcastSources
  def initialize
    @date = NewsDate.date_today()
    @podcasts = []

    sources = {
      'Code Switch': CodeSwitch,
      'Ted Talks': TedTalks,
      'New Yorker': NewYorkerPodcast,
      'Planet Money': PlanetMoney,
      'a16z': A16Z,
      'From Scratch': FromScratch,
      'Only A Game': OnlyAGame,
      'Embedded': Embedded,
      'Hidden Brain': HiddenBrain,
      'Bill Simmons': BillSimmons,
      'The Read': TheRead,
      'Inside Intercom': InsideIntercom
    }

    pull_podcasts( sources )
  end

  def pull_podcasts( sources )
    sources.each do |source_title, source_object|
      begin
        add_podcast(source_title, source_object.new(@date).get_results() )
        Rails.logger.info("#{ source_title } Feed Read")
        puts "#{ source_title } Feed Read"
      rescue Exception => e
        Rails.logger.info("Couldn't read \"#{ source_title }\": #{ e }")
        puts "Couldn't read \"#{ source_title }\": #{ e }"
      end
    end

    # Dedupe array based on titles of each element
    @podcasts.uniq! {|e| ClassifierHelper.format_text(e[:title])}
  end

  def add_podcast( source, feed )
    feed.each do |i|
      topics = RssHelper.get_topic( i[:title], i[:snippet] )
      
      @podcasts.push({
        'source': source,
        'date': @date,
        'web_url': i[:web_url],
        'title': i[:title],
        'image_url': i[:image_url],
        'snippet': i[:snippet],
        'duration': i[:duration],
        'topic_id': topics[:topic],
        'subtopic_id': topics[:subtopic]
      })
    end
  end

  def get_podcasts
    return @podcasts
  end
end