class RepairTask < ApplicationRecord
  enum status: {
    pending: 0,
    diagnostics: 1, # in_progress1,
    fixing: 2, # in_progress2,
    done: 3,
    returned: 4,
  }

  belongs_to :service_order

  belongs_to(
    :repairer,
    class_name: "User", foreign_key: :repairer_id, inverse_of: :repair_tasks
  )
end
