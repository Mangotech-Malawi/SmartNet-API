require 'services/intrusion_service'

class Api::V1::IntrusionController < ApplicationController
    before_action :authorize_request

    def index
        @intrusions = IntrusionService.fetch_intrusions
        render json: @intrusions, status: :ok
    end

    def create
        intrusion = IntrusionService.new(get_device_params)
        
        unless intrusion.blank?
          render json: intrusion, status: :created
        else
          render json: { errors: intrusion.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private 
    def get_device_params
        params.permit(%i[ id network_event_id description])
    end
end
