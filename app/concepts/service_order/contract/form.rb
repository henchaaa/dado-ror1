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
    validate :validate_date_format
    validate :validate_email_format
    validate :validate_phone_prefix, :validate_phone_number
    validate :validate_first_name
    validate :validate_last_name

    def service_order
      model[:service_order]
    end

    def client
      model[:client]
    end

    private

      def validate_date_format
        can_be_turned_into_a_date =
          begin
            date.to_date.present?
          rescue ArgumentError
            false
          end

        return if can_be_turned_into_a_date

        errors.add(:date, "Invalid")
      end

      def validate_email_format
        return if client.email.to_s.match?(EMAIL_REGEX)

        client.errors.add(:email, "Invalid")
      end

      def validate_phone_prefix
        return if client.phone_prefix.match?(%r'\A00\d+\z')

        client.errors.add(:phone_prefix, "Must only contain numbers")
      end

      def validate_phone_number
        return if client.phone_number.match?(%r'\A\d{6,}\z')

        client.errors.add(:phone_number, "Must only contain numbers")
      end

      def validate_first_name
        return if client.first_name.match?(%r'\A[ [:alpha:]]+\z')

        client.errors.add(:first_name, "Contains invalid characters")
      end

      def validate_last_name
        return if client.last_name.match?(%r'\A[ [:alpha:]\-]+\z')

        client.errors.add(:last_name, "Contains invalid characters")
      end
  end
end
