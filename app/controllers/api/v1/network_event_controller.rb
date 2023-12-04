require 'services/network_events_service'

class Api::V1::NetworkEventController < ApplicationController
    before_action :authorize_request

    def index
        @network_events = NetworkEventsService.fetch_network_events
        render json: @network_events, status: :ok
    end
end
