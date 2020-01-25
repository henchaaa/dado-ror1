# frozen_string_literal: true

module ServiceOrder::Contract
  class Form < Reform::Form
    include Reform::Form::Composition

    # model :service_order

    delegate(
      :id, :persisted?, to: :service_order, prefix: false
    )

    property :date, on: :service_order
    property :location, on: :service_order

    property :device_name, on: :service_order
    property :device_password, on: :service_order
    property :device_warranty, on: :service_order
    property :device_extras, on: :service_order
    property :device_saveable_info, on: :service_order
    property :device_defect, on: :service_order
    property :device_additional_info, on: :service_order

    property(:client, virtual: true) do
      property :first_name, on: :client
      property :last_name, on: :client
      property :phone_prefix, on: :client
      property :phone_number, on: :client
      property :email, on: :client

      validates :first_name, :last_name, :phone_prefix, :phone_number, presence: true
    end

    validates :date, :location, :device_name, :device_defect, presence: true
    # validate :validate_email_format

    def service_order
      model[:service_order]
    end

    def client
      model[:client]
    end

    private


  end
end
