class AddTopicToPodcasts < ActiveRecord::Migration
  def change
    add_reference :podcasts, :topic, index: true, foreign_key: true
  end
end
