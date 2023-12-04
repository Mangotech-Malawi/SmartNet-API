

class Api::V1::EventController < ApplicationController
    before_action :authorize_request

    def index
        @events = Event.all
        render json: @events, status: :ok
    end
    
end
