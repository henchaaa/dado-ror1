class RepairTask < ApplicationRecord
  belongs_to :service_order

  belongs_to(
    :repairer,
    class_name: "User", foreign_key: :repairer_id, inverse_of: :repair_tasks
  )
end
