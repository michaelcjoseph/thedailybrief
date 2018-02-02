class CreateSubtopics < ActiveRecord::Migration
  def change
    create_table :subtopics do |t|
      t.string :subtopic

      t.timestamps null: false
    end
  end
end
