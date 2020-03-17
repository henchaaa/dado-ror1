class SearchesController < ApplicationController
    # This service takes in params hash and does filtering for index
  
    include Service
  
    attr_reader :params
  
    def initialize(params:)
      @params = params
    end
  
    # @return [Ar::Collection]
    def call
      return @call if defined?(@call)
  
      collection = ServiceOrder.all
  
      collection = filter_by_number!(collection)
      collection = filter_by_status!(collection)
      collection = filter_by_repairer!(collection)
      collection = filter_by_client_phone!(collection)
      collection = filter_by_client_last_name!(collection)
  
      @call = collection.order(id: :desc).limit(10)
    end
  
    private
  
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
  