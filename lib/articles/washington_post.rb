require_relative '../news_helpers/rss_helper'

class WashingtonPost
  def initialize( date, word_count_min )
    @rss_url = [
      'http://feeds.washingtonpost.com/rss/politics',
      'http://feeds.washingtonpost.com/rss/rss_election-2012',
      'http://feeds.washingtonpost.com/rss/rss_powerpost',
      'http://feeds.washingtonpost.com/rss/rss_fact-checker',
      'http://feeds.washingtonpost.com/rss/rss_the-fix',
      'http://feeds.washingtonpost.com/rss/rss_monkey-cage',
      'http://feeds.washingtonpost.com/rss/rss_plum-line',
      'http://feeds.washingtonpost.com/rss/sports',
      'http://feeds.washingtonpost.com/rss/rss_recruiting-insider',
      'http://feeds.washingtonpost.com/rss/rss_dc-sports-bog',
      'http://feeds.washingtonpost.com/rss/rss_early-lead',
      'http://feeds.washingtonpost.com/rss/rss_fancy-stats',
      'http://feeds.washingtonpost.com/rss/rss_football-insider',
      'http://feeds.washingtonpost.com/rss/rss_terrapins-insider',
      'http://feeds.washingtonpost.com/rss/rss_soccer-insider',
      'http://feeds.washingtonpost.com/rss/national',
      'http://feeds.washingtonpost.com/rss/rss_achenblog',
      'http://feeds.washingtonpost.com/rss/rss_checkpoint',
      'http://feeds.washingtonpost.com/rss/rss_innovations',
      'http://feeds.washingtonpost.com/rss/rss_morning-mix',
      'http://feeds.washingtonpost.com/rss/rss_post-nation',
      'http://feeds.washingtonpost.com/rss/rss_speaking-of-science',
      'http://feeds.washingtonpost.com/rss/rss_to-your-health',
      'http://feeds.washingtonpost.com/rss/world',
      'http://feeds.washingtonpost.com/rss/rss_blogpost',
      'http://feeds.washingtonpost.com/rss/business',
      'http://feeds.washingtonpost.com/rss/rss_digger',
      'http://feeds.washingtonpost.com/rss/national/energy-environment',
      'http://feeds.washingtonpost.com/rss/rss_on-leadership',
      'http://feeds.washingtonpost.com/rss/blogs/rss_the-switch',
      'http://feeds.washingtonpost.com/rss/rss_wonkblog',
      'http://feeds.washingtonpost.com/rss/lifestyle',
      'http://feeds.washingtonpost.com/rss/rss_arts-post',
      'http://feeds.washingtonpost.com/rss/rss_soloish',
      'http://feeds.washingtonpost.com/rss/rss_reliable-source',
      'http://feeds.washingtonpost.com/rss/entertainment',
      'http://feeds.washingtonpost.com/rss/rss_comic-riffs',
      'http://feeds.washingtonpost.com/rss/rss_going-out-gurus',
      'http://feeds.washingtonpost.com/rss/rss_the-intersect',
      'http://feeds.washingtonpost.com/rss/rss_where-we-live'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Washington Post RSS Feed

    # CSS Tags to find image url
    css_tags = ['.inline-photo', 'img']

    # Stop words to verify title with
    stop_words = ['open houses']

    @rss_url.each do |url|
      feed = RssHelper.read_feed( url )

      if feed
        feed.items.each do |item|
          if item.pubDate
            date_published = item.pubDate
          else
            date_published = Time.parse(get_date( item.link ))
          end

          if date_published >= Time.parse(@date)
            word_count = RssHelper.get_word_count( item.link, "article[itemprop='articleBody']" )
            title = RssHelper.html_to_text(item.title)

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              @results.push({
                'web_url': item.link,
                'title': title,
                'image_url': RssHelper.get_image(item.link, css_tags),
                'snippet': RssHelper.html_to_text(item.description),
                'word_count': word_count
              })
            end
          end
        end
      end
    end
  end

  def get_date( url )
    page = RssHelper.get_html_content(url)

    if page
      if page.at_css('.pb-timestamp')
        date = page.at_css('.pb-timestamp').text

        if date.include? ','
          return date
        else
          split_date = date.split(' ')

          day = get_day( split_date )
          month = get_month( split_date )
          year = get_year()

          return year + month + day
        end
      end
    end

    return '20000101'
  end

  def get_day( date )
    if date[1].length == 1
      day = '0' + date[1]
    end

    return date[1]
  end

  def get_month( date ) 
    if date[0] == 'January'
      month = '01'
    elsif date[0] == 'February'
      month = '02'
    elsif date[0] == 'March'
      month = '03'
    elsif date[0] == 'April'
      month = '04'
    elsif date[0] == 'May'
      month = '05'
    elsif date[0] == 'June'
      month = '06'
    elsif date[0] == 'July'
      month = '07'
    elsif date[0] == 'August'
      month = '08'
    elsif date[0] == 'September'
      month = '09'
    elsif date[0] == 'October'
      month = '10'
    elsif date[0] == 'November'
      month = '11'
    elsif date[0] == 'December'
      month = '12'
    end

    return month
  end

  def get_year
    return Time.now.year.to_s
  end

  def get_results
    return @results
  end
end