class ApplicationController < ActionController::Base
  before_action :authenticate!
  helper_method :current_user

  private

    def authenticate!
      current_user.present? || redirect_to(root_path)
    end

    def current_user
      return @current_user if defined?(@current_user)

      @current_user = User.find_by(id: session[:user_id])
    end
end
