class ServiceOrdersController < ApplicationController
  before_action :set_service_order, only: [:show, :destroy]

  # GET /service_orders
  def index
    @service_orders = ServiceOrder::Collector.call(params: params.permit!.to_h)
    respond_to do |format|
      format.html
      format.json
      format.pdf {render :pdf => "service_orders/file",
      :template => '/file', formats: :html, encoding: 'utf8'}
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
   
    respond_to do |format|
         format.html
         format.json
         format.pdf do 
           render pdf: "show.pdf.erb", encoding: 'utf8', formats: :pdf
         end
       end
  end

  # GET /service_orders/1/edit
  def edit
  end

  # PATCH/PUT /service_orders/1
  def update
    respond_to do |format|
      if @service_order.update(service_order_contract)
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

  def search
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else 
      

      collection = ServiceOrder.all params[:search].downcase

      def call
        return @call if defined?(@call)
        collection = filter_by_number!(collection)
        collection = filter_by_status!(collection)
        collection = filter_by_repairer!(collection)
        collection = filter_by_client_phone!(collection)
        collection = filter_by_client_last_name!(collection)
    
        @call = collection.order(id: :desc).limit(10)

        
      end
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



    def filter_by_number!(collection)
      return collection if params[:number].blank?

      collection.where("number LIKE :number", number: "#{ params[:number] }%")
    end

    def filter_by_status!(collection)
      return collection if params[:status].blank?

      service_orders_with_repair_tasks_in_status = collection.
        joins(:repair_task).merge(
          RepairTask.where(status: params[:status])
        )

      unless params[:status] == RepairTask.statuses.key(0).to_s
        return service_orders_with_repair_tasks_in_status
      end

      service_orders_without_repair_tasks = collection.where.not(
        id: RepairTask.select(:service_order_id)
      )

      unioned = ServiceOrder.union(
        service_orders_with_repair_tasks_in_status,
        service_orders_without_repair_tasks
      )

      collection.where(
        id: unioned.select("#{ ServiceOrder.table_name }.id")
      )
    end

    def filter_by_repairer!(collection)
      return collection if params[:repairer_id].blank?

      collection.joins(:repair_task).merge(
        RepairTask.where(repairer_id: params[:repairer_id])
      )
    end

    def filter_by_client_phone!(collection)
      return collection if params[:phone_number].blank?

      collection.joins(:client).merge(
        Client.where(phone_number: params[:phone_number])
      )
    end

    def filter_by_client_last_name!(collection)
      return collection if params[:last_name].blank?

      collection.joins(:client).merge(
        Client.where(last_name: params[:last_name])
      )
    end
  end
