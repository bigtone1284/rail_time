class AddEmailRemoveUsersFromAlerts < ActiveRecord::Migration
  def change
  	enable_extension("citext") 
  	
  	add_column :alerts, :email_address, :citext
  	remove_column :alerts, :user_id, :integer
  end
end
