class CreateNetworkEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :network_events do |t|
      t.bigint  :device_id
      t.string  :source_ip
      t.string  :dest_ip
      t.string  :protocol
      t.integer :port
      t.boolean :voided
      t.timestamps
    end
  end
end
