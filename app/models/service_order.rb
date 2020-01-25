class ServiceOrder < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_one :repair_task, dependent: :destroy
end
