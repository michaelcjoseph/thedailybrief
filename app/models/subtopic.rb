class Subtopic < ActiveRecord::Base
  validates :subtopic, presence: true

  def self.get_subtopics
    return Subtopic.all
  end
end
