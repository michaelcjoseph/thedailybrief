class AddSubTopicToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :subtopic, index: true, foreign_key: true
  end
end
