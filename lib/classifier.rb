require 'json'
require 'nbayes'
require_relative './classifier_helpers/classifier_helper'

module Classifier
  def Classifier.train_models
    nbayes = NBayes::Base.new

    topics_training = {}
    topics = ClassifierHelper.get_topics
    topics.each do |topic|
      output_path_string = ClassifierHelper.get_relative_model_path(topic)

      topics_training[topic] = {
        nbayes: NBayes::Base.new,
        output_path: File.expand_path( output_path_string, __FILE__ )
      }
    end

    data_path = File.expand_path( ClassifierHelper.get_relative_data_path(), __FILE__ )
    file = File.read(data_path)
    training_set = JSON.parse(file)

    for pattern in training_set
      text = ClassifierHelper.format_text(pattern["text"])
      topic = pattern["topic"]
      subtopic = pattern["subtopic"]

      nbayes.train(text, topic)

      if topic != "General"
        topics_training[topic][:nbayes].train(text, subtopic)
      end
    end

    output_path = File.expand_path( ClassifierHelper.get_relative_model_path(), __FILE__ )
    nbayes.dump(output_path)

    for topic, dict in topics_training
      dict[:nbayes].dump(dict[:output_path])
    end
  end

  def Classifier.update_training_data
    data_path = File.expand_path( ClassifierHelper.get_relative_data_path(), __FILE__ )
    read_file = File.read(data_path)
    training_set = JSON.parse(read_file)

    articles = Article.get_training_data_articles
    podcasts = Podcast.get_training_data_podcasts

    training_set = ClassifierHelper.update_training_set( training_set, articles )
    training_set = ClassifierHelper.update_training_set( training_set, podcasts )

    write_file = File.open(data_path, "w")
    write_file.write(JSON.pretty_generate(training_set))
    write_file.close
  end

  def Classifier.classify_text( text )
    topics_model_path = File.expand_path(ClassifierHelper.get_relative_model_path(), __FILE__)
    nbayes = NBayes::Base.from(topics_model_path)
    topic = nbayes.classify(ClassifierHelper.format_text(text)).max_class
    
    if topic == "General"
      subtopic == "General"
    else
      subtopic_model_path = File.expand_path(ClassifierHelper.get_relative_model_path(topic), __FILE__)
      subtopic_nbayes = NBayes::Base.from(subtopic_model_path)
      subtopic = subtopic_nbayes.classify(ClassifierHelper.format_text(text)).max_class
    end

    return {
      topic: ClassifierHelper.map_topic_to_topic_id(topic),
      subtopic: ClassifierHelper.map_subtopic_to_subtopic_id(topic, subtopic)
    }
  end

  def Classifier.classify_stories_test
    model_path = File.expand_path("../classifier_data/topics_model.yml", __FILE__)
    nbayes = NBayes::Base.from(model_path)

    test_article1 = "Intel’s $15 Billion Mobileye Buyout Puts It in the Autonomous Car Driver’s Seat The acquisition bags the chip maker a pivotal contender in the race to build robotic cars."
    puts "Test Article 1 - Should be Tech"
    result = nbayes.classify(ClassifierHelper.format_text(test_article1))
    puts result.max_class

    test_article2 = "How Donald Trump’s Enemies Fell For A Billion-Dollar Hoax An elaborate hoax based on forged documents escalates the phenomenon of “fake news” and reveals an audience on the left that seems willing to believe virtually any claim about Trump's bad deeds."
    puts "Test Article 2 - Should be Politics"
    result = nbayes.classify(ClassifierHelper.format_text(test_article2))
    puts result.max_class

    test_article3 = "BANG! Beyoncé trolls us, Nicki still lost and Trump stays pissed."
    puts "Test Article 3 - Should be Race & Culture (might end up being Politics because it says Trump in snippet)"
    result = nbayes.classify(ClassifierHelper.format_text(test_article3))
    puts result.max_class
  end
end