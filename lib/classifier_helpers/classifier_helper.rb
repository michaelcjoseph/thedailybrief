module ClassifierHelper
  def ClassifierHelper.get_relative_data_path
    return "../classifier_data/topics_data.json"
  end

  def ClassifierHelper.get_relative_model_path( topic=nil )
    if topic
      if topic == "Race & Culture"
        return "../classifier_data/race_and_culture_model.yml"
      else
        return "../classifier_data/" + topic.downcase + "_model.yml"
      end
    else
      return "../classifier_data/topics_model.yml"
    end
  end

  def ClassifierHelper.get_topics
    topics = Topic.all
    topics_list = []

    topics.each do |topic|
      topics_list.push(topic.topic)
    end

    return topics_list
  end

  def ClassifierHelper.format_text( text )
    # Function takes a string, strips it of unnecessary words/characters
    # Makes the entire string lowercase, tokenizes it, and then stems
    # each words. Returns an array of all the words in the string that have
    # been properly parsed

    lowercase_text = text.downcase.strip()
    
    if lowercase_text.include? "read more"
      lowercase_text = lowercase_text.gsub("read more", "")
    end

    if lowercase_text.include? "Continue reading..."
      lowercase_text = lowercase_text.gsub("Continue reading...", "")
    end

    formatted_text = lowercase_text.gsub("-", " ").gsub("_", " ").gsub(/[^a-z0-9\s]/i, '').split(/\s+/)
    return formatted_text.map {|word| word.stem}
  end

  def ClassifierHelper.map_topic_to_topic_id( classifier_topic )
    if classifier_topic == "General"
      return nil
    else
      topic = Topic.where(topic: classifier_topic).first
      return topic.id
    end
  end

  def ClassifierHelper.map_topic_id_to_topic( topic_id )
    if topic_id
      return Topic.find(topic_id).topic
    else
      return "General"
    end
  end

  def ClassifierHelper.map_subtopic_to_subtopic_id( classifier_topic, classifier_subtopic )
    if classifier_topic == "General" || classifier_subtopic == "General"
      return nil
    else
      topic = Topic.where(topic: classifier_topic).first
      subtopic = Subtopic.where(subtopic: classifier_subtopic, topic_id: topic.id).first
      return subtopic.id
    end
  end

  def ClassifierHelper.map_subtopic_id_to_subtopic( subtopic_id )
    if subtopic_id
      return Subtopic.find(subtopic_id).subtopic
    else
      return "General"
    end
  end

  def ClassifierHelper.update_training_set( training_set, stories )
    new_training_set = training_set

    stories.each do |story|
      new_training_set.push({
        "topic": ClassifierHelper.map_topic_id_to_topic(story.topic_id),
        "subtopic": ClassifierHelper.map_subtopic_id_to_subtopic(story.subtopic_id),
        "text": (story.title + " " + story.snippet)
      })
    end

    return new_training_set
  end
end