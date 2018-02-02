class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :genre
      t.string :author
      t.string :title
      t.string :image_url
      t.string :snippet
      t.string :review_url
      t.string :amazon_url
      t.integer :review_views
      t.integer :amazon_views

      t.timestamps null: false
    end
  end
end
