class ChangeTimeAlertDataType < ActiveRecord::Migration
  def up
    remove_column :alerts, :time
    add_column :alerts, :time, :datetime
  end

  def down
    remove_column :alerts, :time
    add_column :alerts, :time, :time
  end
end