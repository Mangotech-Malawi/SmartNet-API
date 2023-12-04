class NetworkEvent < ApplicationRecord
    validates  :device_id, presence: true
    validates  :source_ip, presence: true
    validates  :dest_ip, presence: true
    validates  :protocol, presence: true
    validates  :port, presence:true
    belongs_to :device
    belongs_to   :event
end

