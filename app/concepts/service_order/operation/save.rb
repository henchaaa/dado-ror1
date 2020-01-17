# frozen_string_literal: true

class ServiceOrder::Save < Trailblazer::Operation
  # This operation is for Creating and Editing the composite
  # ServiceOrder and Client records

  # #new and #create only need params
  # #edit and #update have to pass the existing record in the options
  # example:
  #  ServiceOrder::Save.call(
  #    params["resource"],
  #    "model" => ServiceOrder.find_by(id: params[:id]) || ServiceOrder.new
  #  )

  class Present < Trailblazer::Operation
    step :setup_model!
    step :setup_contract!

    private

      def setup_model!(options, **)
        options["model"] ||= ServiceOrder.new
      end

      def setup_contract!(options, **)
        options["contract.resource"] ||= ServiceOrder::Contract::Form.new(
          service_order: options["model"],
          client: options["model"].client.presence || Client.new
        )
      end
  end

  step Nested(ServiceOrder::Save::Present)
  step :validate!
  step :persist!

  private

    def validate!(options, **)
      # TODO, collect validation errors and return false if any present
    end

    def persist!(options, **)
      options["contract.resource"].save do |hash|
      end
    end
end
