class Device < ApplicationRecord
    validates  :serial_number, presence: true
    validates  :ip_address, presence: true
    validates  :name, presence: true
    validates  :device_type, presence:true
    validates  :mac_address, presence: true
    validates  :custodian_id, presence: true
    
end
