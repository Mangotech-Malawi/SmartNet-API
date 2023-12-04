# bin/scan_network.rb

require 'active_record'
require 'yaml'
require 'socket'

# Load the Rails application
rails_env = ENV['RAILS_ENV'] || 'development'
db_config = YAML.load_file('config/database.yml')[rails_env]
ActiveRecord::Base.establish_connection(db_config)

# Define the Device model
class Device < ActiveRecord::Base
end

class NetworkEvent < ActiveRecord::Base
end

class Event < ActiveRecord::Base
end

# Method to check if a device is reachable using the ping command
def ping_device(ip_address)
  result = `ping -c 4 #{ip_address}`
  return result.include?('4 packets transmitted, 4 received')
end

# Fetch devices from the database
devices = Device.all

# Scan and print results
devices.each do |device|
  ip_address = device.ip_address
  reachable = ping_device(ip_address)
  puts "Device #{ip_address} is #{reachable ? 'reachable' : 'unreachable'}"
  
  if reachable == false
    event_id = Event.where("events.name = ?", "Ping Failure").pick(:id)

    NetworkEvent.create!(
      device_id: device.id,
      dest_ip: device.ip_address,
      source_ip: Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address,
      protocol: 'ICMP', # ICMP protocol used in ping
      port: 'N/A', # Placeholder for port in ping
      event_id: event_id
    )
  end
end

ActiveRecord::Base.connection.close
