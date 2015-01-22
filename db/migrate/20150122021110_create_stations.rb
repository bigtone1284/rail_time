class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
    	t.string	:stop_id
    	t.string	:stop_name
    	t.string	:stop_lat
    	t.string	:stop_lon
    	t.string	:stop_url
    	t.string	:line_name
    end
  end
end
