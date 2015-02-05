class AddUnsubscribeHashToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :unsubscribe_hash, :string
  end
end
