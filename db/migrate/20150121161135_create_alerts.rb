class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.string :direction
    	t.time 	 :time
    	t.string :frequency
    	t.references :station
    	t.references :user

    	t.timestamps
    end
  end
end
