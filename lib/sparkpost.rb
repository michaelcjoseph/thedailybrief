require 'simple_spark'
require_relative './emails/welcome_email'
require_relative './emails/newsletter'
require_relative './email_helpers/sparkpost_helper'


module Sparkpost
  def Sparkpost.get_client
    return SimpleSpark::Client.new(api_key: ENV["SPARKPOST_KEY"])
  end

  # Welcome Email
  def Sparkpost.send_welcome_email( user_email, user_name )
    simple_spark = Sparkpost.get_client()

    properties = {
      options: { 
        open_tracking: true, 
        click_tracking: true,
        transactional: true
      },
      campaign_id: 'welcome_email',
      return_path: SparkpostHelper.get_return_path(),
      substitution_data: { sender: 'Michael' },
      recipients:  [{
        address: { email: user_email },
        substitution_data: { name: user_name }
      }],
      content: { 
        from: { 
          name: SparkpostHelper.get_welcome_from_name(), 
          email: SparkpostHelper.get_welcome_from_email() 
        },
        subject: 'Welcome!',
        reply_to: SparkpostHelper.get_welcome_reply_to(),
        html: WelcomeEmail.get_html_content()
      }
    }

    simple_spark.transmissions.create(properties)
  end

  def Sparkpost.send_newsletter( timerange )
    simple_spark = Sparkpost.get_client()

    users = SparkpostHelper.get_newsletter_recipients( timerange )

    for user in users
      stories = SparkpostHelper.get_stories( timerange, user[:address][:email] )

      properties = {
        options: { 
          open_tracking: true, 
          click_tracking: true,
          transactional: false
        },
        campaign_id: ( timerange + '_email'),
        return_path: SparkpostHelper.get_return_path(),
        substitution_data: SparkpostHelper.get_substitution_data(stories),
        recipients: [user],
        content: { 
          from: { 
            name: SparkpostHelper.get_newsletter_from_name(), 
            email: SparkpostHelper.get_newsletter_from_email() 
          },
          subject: SparkpostHelper.get_email_subject( timerange ),
          reply_to: SparkpostHelper.get_newsletter_reply_to(),
          html: Newsletter.get_html_content( stories )
        }
      }

      simple_spark.transmissions.create(properties)
    end
  end
end