class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.string :direction
    	t.time 	 :time
    	t.string :frequency
    	t.reference :station
    	t.reference :user

    	t.timestamps
    end
  end
end
