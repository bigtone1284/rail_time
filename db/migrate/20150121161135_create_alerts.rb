class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.string :station_name
    	t.string :direction
    	t.time 	 :time
    	t.string :frequency

    	t.timestamps
    end
  end
end
