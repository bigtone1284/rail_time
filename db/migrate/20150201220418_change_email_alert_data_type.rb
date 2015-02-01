class ChangeEmailAlertDataType < ActiveRecord::Migration
  def up
    change_column :alerts, :email_address, :text
  end

  def down
    change_column :alerts, :email_address, :citext
  end
end
