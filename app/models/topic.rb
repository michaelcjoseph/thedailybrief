class Topic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  def self.get_topics
    return Topic.all
  end

  def self.get_topics_id_name_mapping
    topics = Topic.all
    topics_mapping = {}

    topics.each do |topic|
      topics_mapping[topic.id] = topic.topic
    end

    return topics_mapping
  end
end
