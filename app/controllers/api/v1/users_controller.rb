require 'services/user_service'

class Api::V1::UsersController < ApplicationController
    before_action :authorize_request

    # GET /users
    def index
        @users = UserService.users
        render json: @users, status: :ok
    end

    # GET /users/{username}
    def show
        render json: @user, status: :ok
    end

    # POST /users
    def create
        user_params = params.require(%i[national_id username firstname lastname email role])
        national_id, username, firstname, lastname, email, role = user_params

        user = UserService.new_user( national_id: national_id, username: username, firstname: firstname,
        lastname: lastname, email: email, role: role )
        

        if user
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages },
                status: :unprocessable_entity
        end
        
    end

    # PUT /users/{username}
    def update
        user_params = params.require(%i[user_id national_id username firstname lastname email role])
        user_id, national_id, username, firstname, lastname, email, role = user_params

        user = UserService.edit_user( user_id: user_id, national_id: national_id, username: username, 
        firstname: firstname,lastname: lastname, email: email, role: role )
    
        if user
        render json: { updated: true }, status: :ok
        else
        render json: { errors: user.errors.full_messages },
                status: :unprocessable_entity
        end
    end


    # DELETE /delete_user
    def del_user
        user_id = params.require(:user_id)
        deleted = UserService.delete_user(user_id: user_id)

        if deleted
        render json: { deleted: true }, status: :ok
        else
        render json: { deleted: false }, status: :unprocessable_entity
        end
    end

    # DELETE /users/{username}
    def destroy
        @user.destroy
    end

    #Verify password 
    def verify_password
        verification_params = params.require(%i[ email  cur_password ])
        email, cur_password = verification_params

        user = User.find_by(email: email)
        
        # Verify the password
        if user && user.authenticate(cur_password)
        render json: { valid_password: true }, status: :ok
        else
        render json: { valid_password: false }, status: :ok
        end

    end

    def update_profile
        profile_params = params.require(%i[ user_id  new_password])
        user_id, new_password =  profile_params

        profile_updated = UserService.update_profile(user_id: user_id, new_password: new_password)

        if profile_updated
            render json: { updated: true }, status: :ok
        else
            render json: { updated: false }, status: :ok
        end
    end

    private
    def find_user
        @user = User.find_by_id!(params[:user_id])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end

    def user_params
        params.permit(
        :national_id,:username, :firstname, :lastname, :email, :contact, :role
        )
    end
    
  
end
