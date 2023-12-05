module ResponseService

    def self.fetch_responses
        response_actions = ResponseAction.joins(intrusion: [network_event: [:device, :event]])
            .select(
            'response_actions.id',
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
            'intrusions.id AS intrusion_id',
            'response_actions.action_type',
            'response_actions.description'
            )
        
        result = response_actions.map do |response_action|
            {
            id: response_action.id,
            created_at: response_action.created_at,
            updated_at: response_action.updated_at,
            source_ip: response_action.source_ip,
            dest_ip: response_action.dest_ip,
            protocol: response_action.protocol,
            port: response_action.port,
            device_name: response_action.device_name,
            event_name: response_action.event_name,
            severity: response_action.severity,
            intrusion_description: response_action.intrusion_description,
            intrusion_id: response_action.intrusion_id,
            action_type: response_action.action_type,
            response_description: response_action.description
            }
        end
    end

    def self.new(params)
        ResponseAction.create!(
            intrusion_id: params[:intrusion_id],
            action_type: params[:action_type],
            description: params[:description]
        )
    end
end