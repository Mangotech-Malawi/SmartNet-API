module NetworkEventsService
  def self.fetch_network_events
    NetworkEvent.joins(:device, :event).select(
      'network_events.created_at',
      'network_events.updated_at',
      'network_events.source_ip',
      'network_events.dest_ip',
      'network_events.protocol',
      'network_events.port',
      'devices.name AS device_name',
      'events.name AS event_name',
      'events.severity'
    ).map do |network_event|
      {
        created_at: network_event.created_at,
        updated_at: network_event.updated_at,
        source_ip: network_event.source_ip,
        dest_ip: network_event.dest_ip,
        protocol: network_event.protocol,
        port: network_event.port,
        device_name: network_event.device_name,
        event_name: network_event.event_name,
        severity: network_event.severity
      }
    end
  end
  
end
    