require 'services/custodian_service'

class Api::V1::CustodianController < ApplicationController
    before_action :authorize_request

    def index 
        @custodians = CustodianService.fetch_custodians
        render json: @custodians, status: :ok
    end

    def show
      
    end

    def create
       custodian =  CustodianService.new(get_custodian_params)
       
       unless custodian.blank?
         render json: custodian, status: :created
       else
         render json: { errors: client.errors.full_messages }, status: :unprocessable_entity
       end

    end

    def update
        custodian = CustodianService.update_custodian(get_custodian_params)

        if custodian
          render json: { updated: true }, status: :ok
        else
          render json: { erros: client.erros.full_messages}, 
                    status: :unprocessable_entity
        end
    end

    def void_custodian
        custodian = Custodian.where(id: params[:id]).update_all(voided: true)
        if custodian
            render json: { deleted: true}, status: :ok
        else
            render json: { deleted: false}, status: :unprocessable_entity
        end
    end

    private 
    def get_custodian_params
      params.permit(%i[
         id national_id firstname lastname custodian_type
         gender phone_number email  date_of_birth ])
    end

end
