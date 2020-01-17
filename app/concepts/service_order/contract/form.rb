# frozen_string_literal: true

module ServiceOrder::Contract
  class Form < Reform::Form
    model(ServiceOrder)

    property :date
    property :location

    property :device_name
    property :device_password
    property :device_warranty
    property :device_extras
    property :device_saveable_info
    property :device_defect
    property :device_additional_info

    property :client do
      property :first_name
      property :last_name
      property :phone_prefix
      property :phone_number
      property :email
    end

    # def prepopulate!(_options={})
    #   if person_phone_numbers.none?
    #     person_phone_number = PersonPhoneNumber.new

    #     person_phone_numbers << Client::Contract::PersonPhoneNumberForm.new(
    #       person_phone_number
    #     )
    #   end

    #   nil
    # end

    private
  end
end
