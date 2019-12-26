class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: [:show, :edit, :update, :destroy]

  # GET /service_orders
  def index
    @service_orders = ServiceOrder.all.order(id: :desc).limit(10)
  end

  # GET /service_orders/1
  def show
  end

  # GET /service_orders/new
  def new
    @service_order = ServiceOrder.new
  end

  # GET /service_orders/1/edit
  def edit
  end

  # POST /service_orders
  def create
    @service_order = ServiceOrder.new(service_order_params)

    respond_to do |format|
      if @service_order.save
        format.html { redirect_to @service_order, notice: 'Service order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /service_orders/1
  def update
    respond_to do |format|
      if @service_order.update(service_order_params)
        format.html { redirect_to @service_order, notice: 'Service order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /service_orders/1
  def destroy
    @service_order.destroy!

    respond_to do |format|
      format.html { redirect_to service_orders_url, notice: 'Service order was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_order
      @service_order ||= ServiceOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_order_params
      params.fetch(:service_order, {})
    end
end
