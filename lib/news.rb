require_relative './news_helpers/news_date'
require_relative './news_helpers/rss_helper'
require_relative './classifier_helpers/classifier_helper'
require_relative './articles/nytimes'
require_relative './articles/the_atlantic'
require_relative './articles/npr'
require_relative './articles/five_thirty_eight'
require_relative './articles/espn'
require_relative './articles/buzzfeed'
require_relative './articles/newyorker_articles'
require_relative './articles/economist'
require_relative './articles/fast_company'
require_relative './articles/techcrunch'
require_relative './articles/vice'
require_relative './articles/american_conservative'
require_relative './articles/guardian'
require_relative './articles/fiscal_times'
require_relative './articles/the_hill'
require_relative './articles/vox'
require_relative './articles/farnam_street'
require_relative './articles/eater'
require_relative './articles/washington_post'
require_relative './articles/mit'
require_relative './articles/reuters'
require_relative './articles/forbes'
require_relative './articles/quartz'
require_relative './articles/ted_ideas'
require_relative './articles/the_ringer'
require_relative './articles/priceonomics'
require_relative './articles/backchannel'
require_relative './articles/bright'
require_relative './articles/synapse'
require_relative './articles/teachers_guild'
require_relative './articles/starts_with_a_bang'
require_relative './articles/bull_market'
require_relative './articles/the_fathom_collection'
require_relative './articles/world_economic_forum'
require_relative './articles/the_development_set'
require_relative './articles/eidolon'
require_relative './articles/afro_asian_visions'
require_relative './articles/ashoka'
require_relative './articles/politico'
require_relative './articles/bbc'
require_relative './articles/niskanen_center'
require_relative './articles/reason'
require_relative './articles/cato_institute'
require_relative './articles/the_weekly_standard'
require_relative './articles/christian_science_monitor'
require_relative './articles/ars_technica'
require_relative './articles/gamespot'
require_relative './articles/ign'
require_relative './articles/edscoop'
require_relative './articles/ux_planet'
require_relative './articles/user_onboard'
require_relative './articles/ux_design'
require_relative './articles/free_code_camp'
require_relative './articles/signal_v_noise'
require_relative './articles/hacker_noon'
require_relative './articles/newco_shift'
require_relative './articles/ideo_stories'

class NewsSources
	def initialize
		@date = NewsDate.date_today()
		@word_count_min = 1000
		@news = []

		sources = {
			'The Fiscal Times': FiscalTimes,
			'The Hill': TheHill,
			'Vox': Vox,
			'Farnam Street': FarnamStreet,
			'Eater': Eater,
			'FiveThirtyEight': FiveThirtyEight,
			'ESPN': ESPN,
			'Buzzfeed': Buzzfeed,
			'New Yorker': NewYorkerArticles,
			'Economist': Economist,
			'Fast Company': FastCompany,
			'TechCrunch': TechCrunch,
			'Vice': Vice,
			'The American Conservative': AmericanConservative,
			'The Guardian': Guardian,
			'Washington Post': WashingtonPost,
			'NY Times': NYTimes,
			'MIT Technology Review': MIT,
			'Reuters': Reuters,
			'Forbes': Forbes,
			'Quartz': Quartz,
			'TED Ideas': TedIdeas,
			'UX Design': UXDesign,
			'The Ringer': TheRinger,
			'Priceonomics': Priceonomics,
			'Backchannel': Backchannel,
			'Bright': Bright,
			'Synapse': Synapse,
			'Teachers Guild': TeachersGuild,
			'User Onboard': UserOnboard,
			'Starts With A Bang': StartsWithABang,
			'Bull Market': BullMarket,
			'The Fathom Collection': TheFathomCollection,
			'World Economic Forum': WorldEconomicForum,
			'The Development Set': TheDevelopmentSet,
			'Eidolon': Eidolon,
			'freeCodeCamp': FreeCodeCamp,
			'Afro Asian Visions': AfroAsianVisions,
			'Ashoka': Ashoka,
			'Politico': Politico,
			'BBC': BBC,
			'Niskanen Center': NiskanenCenter,
			'Hacker Noon': HackerNoon,
			'Cato Institute': CatoInstitute,
			'The Weekly Standard': TheWeeklyStandard,
			'Christian Science Monitor': ChristianScienceMonitor,
			'Ars Technica': ArsTechnica,
			'Gamespot': Gamespot,
			'IGN': IGN,
			'EdScoop': EdScoop,
			'UX Planet': UXPlanet,
			'Signal v. Noise': SignalVNoise,
			'NewCo Shift': NewCoShift,
			'IDEO Stories': IdeoStories,
			'NPR': Npr,
			'The Atlantic': TheAtlantic
		}

		pull_news( sources )
	end

	def pull_news( sources )
		sources.each do |source_title, source_object|
			begin
				add_news( 
					source_title, 
					source_object.new(@date, @word_count_min).get_results()
				)
				Rails.logger.info("#{ source_title } Feed Read")
				puts "#{ source_title } Feed Read"
			rescue Exception => e
				Rails.logger.info("Couldn't read \"#{ source_title }\": #{ e }")
				puts "Couldn't read \"#{ source_title }\": #{ e }"
			end
		end

		# Dedupe array based on titles of each element
		@news.uniq! {|e| ClassifierHelper.format_text(e[:title])}
	end

	def add_news( source, feed )
		feed.each do |i|
			topics = RssHelper.get_topic( i[:title], i[:snippet] )

			@news.push({
				'source': source,
				'date': @date,
				'web_url': i[:web_url],
				'title': i[:title],
				'image_url': i[:image_url],
				'snippet': i[:snippet],
				'word_count': i[:word_count],
				'topic_id': topics[:topic],
        'subtopic_id': topics[:subtopic]
			})
		end
	end

	def get_news
		return @news
	end
end