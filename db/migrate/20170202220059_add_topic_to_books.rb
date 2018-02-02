class AddTopicToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :topic, index: true, foreign_key: true
  end
end
