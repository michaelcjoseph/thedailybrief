class AddBooksPrefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :books, :boolean, default: true, null: false
  end
end
