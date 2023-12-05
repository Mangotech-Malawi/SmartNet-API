module IntrusionService
    
    def self.fetch_intrusions
        
    end

    def self.new(params)
        Intrusion.create!(
            network_event_id: params[:network_event_id],
            description: params[:description]
        )
    end
end