class Device < ApplicationRecord
    validates  :serial_number, presence: true
    validates  :ip_address, presence: true
    validates  :name, presence: true
    validates  :device_type, presence:true
    validates  :mac_address, presence: true
    validates  :person_id, presence: true
    belongs_to :custodian
end
