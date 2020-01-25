# frozen_string_literal: true

class RepairTask::Save < Trailblazer::Operation
  # This operation is for Creating and Editing the RepairTask records
  #
  # #new and #create only need params
  # #edit and #update have to pass the existing record in the options
  # example:
  #  RepairTask::Save.call(
  #    params["resource"],
  #    "model" => RepairTask.find_by(id: params[:id]) || RepairTask.new
  #  )

  class Present < Trailblazer::Operation
    step :setup_model!
    step :setup_contract!

    private

      def setup_model!(options, **)
        options["model"] ||= RepairTask.new
      end

      def setup_contract!(options, **)
        options["contract.resource"] ||=
          RepairTask::Contract::Form.new(options["model"])
      end
  end

  step Nested(RepairTask::Save::Present)
  step Contract::Validate(name: "resource")
  step :persist!

  private

    def persist!(options, **)
      options["contract.resource"].save do |params|
        repair_task = nil

        if options["model"].persisted?
          # TODO
        else
          repair_task = RepairTask.create(params[:repair_task])
        end

        options["model"] = repair_task
      end
    end
end
