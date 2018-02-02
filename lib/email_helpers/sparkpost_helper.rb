include ActionView::Helpers::TextHelper
require_relative '../news_helpers/rss_helper'

module SparkpostHelper
  def SparkpostHelper.get_return_path
    return 'michael@thedailybrief.co'
  end

  ### Welcome Email info ###
  def SparkpostHelper.get_welcome_from_name
    return 'Michael from The Daily Brief'
  end

  def SparkpostHelper.get_welcome_from_email
    return SparkpostHelper.get_return_path()
  end

  def SparkpostHelper.get_welcome_reply_to
    return (
      SparkpostHelper.get_welcome_from_name() + 
      ' <' + SparkpostHelper.get_welcome_from_email() + '>'
    )
  end

  ### Newsletter Email Info ###
  def SparkpostHelper.get_newsletter_from_name
    return 'The Daily Brief'
  end

  def SparkpostHelper.get_newsletter_from_email
    return SparkpostHelper.get_return_path()
  end

  def SparkpostHelper.get_newsletter_reply_to
    return (
      SparkpostHelper.get_newsletter_from_name() + 
      ' <' + SparkpostHelper.get_newsletter_from_email() + '>'
    )
  end

  ### Get Subject line for emails ###
  def SparkpostHelper.get_email_subject( timerange )
    articles = Article.get_newsletter_articles( timerange )

    if timerange == 'daily'
      subject = 'Today\'s Brief: '
    elsif timerange == 'weekly'
      subject = 'This Week\'s Brief: '
    end

    return subject + articles[0].title
  end

  ### Get user lists for emails ###
  def SparkpostHelper.get_newsletter_recipients( timerange )
    user_emails = User.get_newsletter_user_emails( timerange )
    recipients = []

    for i in 0..(user_emails.length-1)
      recipients.push({
        address: { email: user_emails[i].email }
      })
    end

    return recipients
  end

  ### Stories for Emails ###
  def SparkpostHelper.get_stories( timerange, user_email )
    stories = {}

    topics = User.get_user_topics( user_email )
    max_articles = topics.length > 0 ? 2 : 4

    stories['general'] = {
      'articles': SparkpostHelper.format_articles( Article.get_newsletter_articles(timerange), max_articles ),
      'podcasts': SparkpostHelper.format_podcasts( Podcast.get_newsletter_podcasts(timerange))
    }

    topics_dict = Topic.get_topics_id_name_mapping()

    for topic in topics
      topic_name = topics_dict[topic] == 'Race & Culture' ? 'Race' : topics_dict[topic]
      stories[topic_name] = {
        'articles': SparkpostHelper.format_articles( Article.get_newsletter_articles(timerange, topic), max_articles ),
        'podcasts': SparkpostHelper.format_podcasts( Podcast.get_newsletter_podcasts(timerange, topic) )
      }
    end

    return stories
  end

  ### Format Articles for Emails ###
  def SparkpostHelper.format_articles( articles, max_articles )
    formatted_articles = {}

    if articles.length > 0
      num_articles = [max_articles, articles.length].min

      for i in 0..(num_articles - 1)
        formatted_articles[i] = {
          source: articles[i].source,
          web_url: ('http://www.thedailybrief.co/api/articles/' + articles[i].id.to_s),
          title: articles[i].title,
          image_url: articles[i].image_url,
          snippet: SparkpostHelper.truncate_snippet( articles[i].snippet ),
          time: ( articles[i].word_count / 250 ).round
        }
      end
    end

    return formatted_articles
  end

  ### Format Podcasts for Emails ###
  def SparkpostHelper.format_podcasts( podcasts )
    formatted_podcasts = {}

    if podcasts.length > 0
      num_podcasts = [1, podcasts.length].min

      for i in 0..(num_podcasts - 1)
        formatted_podcasts[i] = {
          source: podcasts[i].source,
          web_url: ('http://www.thedailybrief.co/api/podcasts/' + podcasts[i].id.to_s),
          title: podcasts[i].title,
          image_url: podcasts[i].image_url,
          snippet: SparkpostHelper.truncate_snippet( podcasts[i].snippet ),
          time: ( podcasts[i].duration / 60 ).round
        }
      end
    end

    return formatted_podcasts
  end

  ### Helper functions for Formatting ###
  def SparkpostHelper.truncate_snippet( snippet )
    return RssHelper.html_to_text(truncate(snippet, :length => 140, :separator => ' '))
  end

  ### Get Substitution Data for Emails ###
  def SparkpostHelper.get_substitution_data( stories )
    substitution_data = {}

    stories.each do |topic, values|
      values.each do |type, items|
        for i in 0..(items.length - 1)
          substitution_data[(topic.to_s + "_" + type.to_s + "_link" + i.to_s)] = items[i][:web_url]
          substitution_data[(topic.to_s + "_" + type.to_s + "_title" + i.to_s)] = items[i][:title]
          substitution_data[(topic.to_s + "_" + type.to_s + "_image" + i.to_s)] = items[i][:image_url]
          substitution_data[(topic.to_s + "_" + type.to_s + "_snippet" + i.to_s)] = items[i][:snippet]
          substitution_data[(topic.to_s + "_" + type.to_s + "_source" + i.to_s)] = items[i][:source]
          substitution_data[(topic.to_s + "_" + type.to_s + "_time" + i.to_s)] = items[i][:time]
        end
      end
    end

    return substitution_data
  end
end