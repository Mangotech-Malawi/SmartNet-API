class AddDeviceNetworkEventMapping < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :network_events, :devices,
    column: :device_id, primary_key: :id    
  end
end
