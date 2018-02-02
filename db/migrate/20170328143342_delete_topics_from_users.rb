class DeleteTopicsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :politics, :boolean
    remove_column :users, :business, :boolean
    remove_column :users, :tech, :boolean
    remove_column :users, :science, :boolean
    remove_column :users, :sports, :boolean
    remove_column :users, :arts, :boolean
    remove_column :users, :food, :boolean
    remove_column :users, :travel, :boolean
    remove_column :users, :environment, :boolean
    remove_column :users, :race, :boolean
    remove_column :users, :entertainment, :boolean
    remove_column :users, :health, :boolean
    remove_column :users, :education, :boolean
    remove_column :users, :gaming, :boolean
  end
end
