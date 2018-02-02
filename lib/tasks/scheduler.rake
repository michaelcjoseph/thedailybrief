desc "This task is called by the Heroku scheduler add-on"

namespace :scheduler do
  task :failing_task => :environment do
    # Failing task to test error notification system with
    puts "Failing task in environment #{Rails.env}..."
    FAIL!
  end

	task :update_news => :environment do
	  Rails.logger.info("Updating news articles...")
	  Article.add_news
	  Rails.logger.info("Articles updated at #{Time.now}")

    Rails.logger.info("Updating podcasts...")
    Podcast.add_podcasts
    Rails.logger.info("Podcasts updated at #{Time.now}")
	end

  task :delete_news => :environment do
    Rails.logger.info("Deleting news articles...")
    Article.delete_news
    Rails.logger.info("Articles deleted at #{Time.now}")

    Rails.logger.info("Deleting podcasts...")
    Podcast.delete_podcasts
    Rails.logger.info("Podcasts deleted at #{Time.now}")
  end

  task :send_newsletter => :environment do
    Rails.logger.info("Starting newsletter email process...")
    puts "Starting newsletter email process..."

    if Time.now.monday? || Time.now.tuesday? || Time.now.wednesday? || Time.now.friday?
      Rails.logger.info("Today is a weekday. Sending daily email...")
      puts "Today is a weekday. Sending daily email..."

      require 'sparkpost.rb'
      Sparkpost.send_newsletter('daily')

      Rails.logger.info("Daily email sent at #{Time.now}}")
      puts "Daily email sent at #{Time.now}}"
    elsif Time.now.thursday?
      require 'sparkpost.rb'

      Rails.logger.info("Today is a weekday. Sending daily email...")
      puts "Today is a weekday. Sending daily email..."
      Sparkpost.send_newsletter('daily')

      Rails.logger.info("Today is Thursday. Sending weekly email...")
      puts "Today is Thursday. Sending weekly email..."
      Sparkpost.send_newsletter('weekly')

      Rails.logger.info("Daily email sent at #{Time.now}}")
      puts "Daily email sent at #{Time.now}}"

      Rails.logger.info("Weekly email sent at #{Time.now}}")
      puts "Weekly email sent at #{Time.now}}"
    else
      Rails.logger.info("Today is the weekend - No email sent")
      puts "Today is the weekend - No email sent"
    end
  end

  task :train_classifier_models => :environment do
    Rails.logger.info("Starting process to train classifier model...")
    puts "Starting process to train classifier model..."

    if Time.now.friday?
      Rails.logger.info("Today is a Friday. Updating and retraining models...")
      puts "Today is a Friday. Updating and retraining models..."

      require 'classifier.rb'

      Rails.logger.info("First updating training data...")
      puts "First updating training data..."
      Classifier.update_training_data

      Rails.logger.info("Next retraining models...")
      puts "Next retraining models..."
      Classifier.train_models

      Rails.logger.info("Models to classify stories trained at #{Time.now}}")
      puts "Models to classify stories trained at #{Time.now}}"
    else
      Rails.logger.info("Today is not Friday - Models not updated and retrained")
      puts "Today is not Friday - Models not updated and retrained"
    end
  end
end