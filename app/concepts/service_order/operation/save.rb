# frozen_string_literal: true

class ServiceOrder::Save < Trailblazer::Operation
  # This operation is for Creating and Editing the composite
  # Client (and PersonPhoneNumber) records

  # #new and #create only need params
  # #edit and #update have to pass the existing record in the options
  # example:
  #  Client::Save.call(
  #    params["resource"],
  #    "model" => Client.find_by(id: params[:id]) || Client.new
  #  )

  class Present < Trailblazer::Operation
    step :setup_model!

    step(
      Contract::Build(
        name: "resource", constant: ServiceOrder::Contract::Form
      )
    )

    def setup_model!(options, **)
      options["model"] ||= ServiceOrder.new
    end
  end

  step Nested(ServiceOrder::Save::Present)
  step Contract::Validate(name: "resource")
  step :persist!

  private

    def persist!(options, **)
      # return false if options["validations_failed"]

      options["contract.resource"].save do |hash|
      end
    end
end
