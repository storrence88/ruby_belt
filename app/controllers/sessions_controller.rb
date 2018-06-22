class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    def new
    end

    def create
        # Log User In
        # if authenticate true
        user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
        if user
            # save user id to session
            session[:user_id] = user.id
            # redirect to users profile page
            redirect_to "/shoes"
        # if authenticate false
        else
            # add an error message -> flash[:errors] = ["Invalid"]
            flash[:errors] = ["Invalid Combination"]
            # redirect to login page
            redirect_to :back
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to ''
    end

end
