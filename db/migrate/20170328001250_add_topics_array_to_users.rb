class AddTopicsArrayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :topics, :integer, array: true, default: '{}'
  end
end
