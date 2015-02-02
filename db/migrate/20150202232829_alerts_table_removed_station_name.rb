class AlertsTableRemovedStationName < ActiveRecord::Migration
  def change
  	remove_column :alerts, :station_name
  end
end
