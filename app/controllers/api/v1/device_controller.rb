require 'services/device_service'

class Api::V1::DeviceController < ApplicationController
    before_action :authorize_request

    def index
        @devices = DeviceService.fetch_devices
        render json: @devices, status: :ok
    end

    def show
      
    end

    def create
        device = DeviceService.new(get_device_params)
        
        unless device.blank?
          render json: device, status: :created
        else
          render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        device = DeviceService.update_device(get_device_params)

        if device
          render json: { updated: true }, status: :ok
        else
          render json: { errors: device.errors.full_messages }, 
                        status: :unprocessable_entity
        end        
    end

    def void_device
        # Assuming you want to void a Device by setting voided to true
      result = Device.where(id: params[:id]).update_all(voided: true)

      if result > 0
        render json: { deleted: true }, status: :ok
      else
        render json: { deleted: false }, status: :unprocessable_entity
      end

    end

    private
    def get_device_params
      params.permit(%i[ id custodian_id serial_number 
            ip_address name device_type mac_address ])
    end
end
