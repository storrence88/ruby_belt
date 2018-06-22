class UsersController < ApplicationController
    skip_before_action :require_login, only: [:create]
    def create
        if params[:user][:password] == params[:user][:password_confirmation]
            new_user = User.create(user_params)
            
        else
            flash[:errors] = ["Passwords do not match"]
              redirect_to :back
        end
            
        if new_user
            if new_user.valid?
              session[:user_id] = new_user.id
              redirect_to "/shoes"
            else
              flash[:errors] = new_user.errors.full_messages
              redirect_to :back
            end
        end
    end

    def show
        @products_bought = Purchase.all.where(user_id: current_user.id)
        @products = @products_bought.product
        p @products

        @user_products = User.find(current_user.id).products
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
