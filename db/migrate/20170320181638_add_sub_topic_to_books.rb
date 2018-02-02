class AddSubTopicToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :subtopic, index: true, foreign_key: true
  end
end
