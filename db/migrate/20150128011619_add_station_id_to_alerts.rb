class AddStationIdToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :station_id, :integer
    add_column :alerts, :user_id, :integer
  end
end
