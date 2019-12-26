class SessionController < ApplicationController
  before_action :redirect_to_welcome!, only: [:new]

  # GET /
  def new

  end

  # POST /login
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to(service_orders_path)
    else
      flash[:alert] = "Invalid credentials"
      redirect_to root_path
    end
  end

  # DELETE /logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

    def authenticate!
      # overriding default authenticate to do nothing for this controller
    end

    def redirect_to_welcome!
      return if current_user.blank?

      redirect_to service_orders_path
    end
end
