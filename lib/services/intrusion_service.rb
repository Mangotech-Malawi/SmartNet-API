module IntrusionService
    
    def self.fetch_intrusions
        Intrusion.joins(network_event: [:device, :event])
                 .select(
                   'network_events.id as network_event_id',
                   'network_events.created_at',
                   'network_events.updated_at',
                   'network_events.source_ip',
                   'network_events.dest_ip',
                   'network_events.protocol',
                   'network_events.port',
                   'devices.name AS device_name',
                   'events.name AS event_name',
                   'events.severity',
                   'intrusions.description AS intrusion_description',
                   'intrusions.id AS intrusion_id'
                 )
                 .map do |intrusion|
          {
            created_at: intrusion.network_event.created_at,
            updated_at: intrusion.network_event.updated_at,
            source_ip: intrusion.network_event.source_ip,
            dest_ip: intrusion.network_event.dest_ip,
            protocol: intrusion.network_event.protocol,
            port: intrusion.network_event.port,
            device_name: intrusion.device_name, # Use the correct attribute for the device name
            event_name: intrusion.event_name,   # Use the correct attribute for the event name
            severity: intrusion.severity,
            intrusion_description: intrusion.intrusion_description, # Adjust the key and value based on the actual column name
            intrusion_id: intrusion.intrusion_id
          }
        end
    end
      

    def self.new(params)
        Intrusion.create!(
            network_event_id: params[:network_event_id],
            description: params[:description]
        )
    end
end