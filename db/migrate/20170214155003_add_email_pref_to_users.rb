class AddEmailPrefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_status, :string, :default => 'daily', null: false
  end
end
