class ApplicationController < ActionController::Base
    private
    def current_user
      if session[:user_id].present?
        @current_user ||= User.find_by(id: session[:user_id]) # ifcurrent user is present then use it otherwise find from the table.
      end
    end
    helper_method(:current_user)


    def user_signed_in?
        current_user.present?
    end
      helper_method :user_signed_in?


    def authenticate_user!
        unless current_user.present?
          flash[:danger] = "You must sign in or sign up first!"
          redirect_to new_user_path
        end
    end
end