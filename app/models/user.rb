class User < ApplicationRecord
  has_secure_password

  has_many(:service_orders, dependent: :restrict_with_exception)

  has_many(
    :repair_tasks,
    inverse_of: :repairer, class_name: "RepairTask", foreign_key: :repairer_id,
    dependent: :restrict_with_exception
  )
end
