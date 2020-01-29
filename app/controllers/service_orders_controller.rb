class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: [:show, :destroy]

  # GET /service_orders
  def index
    @service_orders = ServiceOrder::Collector.call(params: params.permit!.to_h)
    respond_to do |format|
      format.html
      format.json
      format.pdf {render template: "service_orders/file", pdf:"file"}
    end
  end

  # GET /service_orders/new
  def new
    @service_order ||= begin
      op = ServiceOrder::Save::Present.call
      op["contract.resource"]
    end
  end

  # POST /service_orders
  def create
    outcome = ServiceOrder::Save.call(
      service_order_params, current_user: current_user
    )

    respond_to do |format|
      if outcome.success?
        format.html do
          redirect_to(
            service_order_path(id: outcome["model"].id),
            notice: "Service order created."
          )
        end
      else
        format.html do
          @service_order = outcome["contract.resource"]
          flash.now[:alert] = "There are service order validation errors."
          render :new
        end
      end
    end
  end

  # GET /service_orders/1
  def show
    @service_order = ServiceOrder.find(params[:id])
  end

  # GET /service_orders/1/edit
  def edit
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
      p = params[:service_order_contract].permit!.to_h

      p["client"] = p.delete("client_attributes")

      p
    end
end
