class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :source
      t.integer :date
      t.string :web_url
      t.string :title
      t.string :image_url
      t.string :snippet
      t.integer :duration
      t.integer :views

      t.timestamps null: false
    end
  end
end
