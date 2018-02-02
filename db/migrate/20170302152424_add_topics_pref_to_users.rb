class AddTopicsPrefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :politics, :boolean, default: false, null: false
    add_column :users, :business, :boolean, default: false, null: false
    add_column :users, :tech, :boolean, default: false, null: false
    add_column :users, :science, :boolean, default: false, null: false
    add_column :users, :sports, :boolean, default: false, null: false
    add_column :users, :arts, :boolean, default: false, null: false
    add_column :users, :food, :boolean, default: false, null: false
    add_column :users, :travel, :boolean, default: false, null: false
    add_column :users, :environment, :boolean, default: false, null: false
    add_column :users, :race, :boolean, default: false, null: false
    add_column :users, :entertainment, :boolean, default: false, null: false
    add_column :users, :health, :boolean, default: false, null: false
    add_column :users, :education, :boolean, default: false, null: false
    add_column :users, :gaming, :boolean, default: false, null: false
  end
end
