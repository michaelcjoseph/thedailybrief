class AddTopicToSubtopic < ActiveRecord::Migration
  def change
    add_reference :subtopics, :topic, index: true, foreign_key: true
  end
end
