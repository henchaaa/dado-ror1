# frozen_string_literal: true

module RepairTask::Contract
  class Form < Reform::Form
    model RepairTask

    delegate(
      :id, :persisted?, to: :model, prefix: false
    )

    property :repairer_id
    property :status
    property :service_order_id
    property :work_cost_cents
    property :materials_cost_cents

    validates(
      :repairer_id, :service_order_id, :status, :work_cost_cents,
      :materials_cost_cents,
      presence: true
    )
  end
end
