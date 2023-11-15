class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.bigint :person_id
      t.string :serial_number
      t.string :ip_address
      t.string :name
      t.string :device_type
      t.string :mac_address
      t.boolean :voided

      t.timestamps
    end   
  end
  
end
