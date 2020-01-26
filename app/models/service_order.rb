class ServiceOrder < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_one :repair_task, dependent: :destroy

  delegate(
    :first_name, :last_name, :phone_prefix, :phone_number, :email,
    to: :client, prefix: "client"
  )
end
