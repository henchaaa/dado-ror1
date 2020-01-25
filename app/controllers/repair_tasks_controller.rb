class RepairTasksController < ApplicationController
  # GET /repair_tasks
  def index
    @repair_tasks = RepairTask.all.order(id: :desc).limit(10)
  end

  # GET /repair_tasks/new
  def new
    @repair_task ||= begin
      op = RepairTask::Save::Present.call
      op["contract.resource"]
    end
  end

  # POST /repair_tasks
  def create
    outcome = RepairTask::Save.call(
      repair_task_params, current_user: current_user
    )

    respond_to do |format|
      if outcome.success?
        format.html do
          redirect_to(
            service_order_path(id: outcome["model"].id),
            notice: "Repair task created."
          )
        end
      else
        format.html do
          @repair_task = outcome["contract.resource"]
          flash.now[:alert] = "There are repair task validation errors."
          render :new
        end
      end
    end
  end

  # GET /service_orders/1
  def show
    @repair_task = RepairTask.find(params[:id])
  end

  # GET /service_orders/1/edit
  def edit
  end

  # PATCH/PUT /service_orders/1
  def update
    respond_to do |format|
      if @repair_task.update(service_order_params)
        format.html do
          redirect_to repair_task_path(@repair_task), notice: "Repair task updated."
        end
      else
        format.html { render :edit }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_order_params
      p = params[:service_order_contract].permit!.to_h

      p["client"] = p.delete("client_attributes")

      p
    end
end
