json.extract! device, :id, :person_id, :serial_number, :ip_address, :name, :device_type, :mac_address, :voided, :created_at, :updated_at
json.url device_url(device, format: :json)
