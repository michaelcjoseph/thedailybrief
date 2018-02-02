class AddSubTopicToPodcasts < ActiveRecord::Migration
  def change
    add_reference :podcasts, :subtopic, index: true, foreign_key: true
  end
end
