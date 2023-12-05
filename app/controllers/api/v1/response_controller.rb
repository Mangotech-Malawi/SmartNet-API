require 'services/response_service'

class Api::V1::ResponseController < ApplicationController
    before_action :authorize_request

    def index 
        @responses = ResponseService.fetch_responses
        render json: @responses, status: :ok
    end

    def create
        response = ResponseService.new(get_response_params)
        
        unless response.blank?
          render json:  response, status: :created
        else
          render json: { errors: response.errors.full_messages }, status: :unprocessable_entity
        end
    end


    private
    def get_response_params
        params.permit(%i[ id intrusion_id action_type description ])
    end

end
