# frozen_string_literal: true

class ServiceOrder::Save < Trailblazer::Operation
  # This operation is for Creating and Editing the composite
  # ServiceOrder and Client records

  # #new and #create only need params
  # #edit and #update have to pass the existing record in the options
  # example:
  #  ServiceOrder::Save.call(
  #    params["resource"],
  #    "model" => ServiceOrder.find_by(id: params[:id]) || ServiceOrder.new
  #  )

  include Sanitization

  SANITIZATION_RULES = {
    "date" => [:without_whitespace],
    "location" => [:squish],
    "device_name" => [:squish],
    "device_password" => [:squish],
    "device_extras" => [:squish],
    "device_saveable_info" => [:squish],
    "device_defect" => [:squish],
    "device_additional_info" => [:squish],
    "client" => {
      "first_name" => [:squish],
      "last_name" => [:squish],
      "phone_prefix" => [:without_whitespace],
      "phone_number" => [:without_whitespace],
      "email" => [:without_whitespace]
    }.freeze
  }.freeze

  class Present < Trailblazer::Operation
    step :setup_model!
    step :setup_contract!

    private

      def setup_model!(options, **)
        options["model"] ||= ServiceOrder.new
      end

      def setup_contract!(options, **)
        options["contract.resource"] ||= ServiceOrder::Contract::Form.new(
          service_order: options["model"],
          client: Client::Contract::Form.new(
            options["model"].client.presence || Client.new
          )
        )
      end
  end

  step Nested(ServiceOrder::Save::Present)
  step :sanitize!
  step Contract::Validate(name: "resource")
  step :persist!

  private

    def sanitize!(options, **)
      options["params"] = sanitized_params(
        options["params"], SANITIZATION_RULES
      )

      true
    end

    def persist!(options, **)
      options["contract.resource"].save do |params|
        params = params[:service_order]

        client = nil

        options["contract.resource"].client.save do |client_params|
          client = Client.where(
            **client_params.except(:email).symbolize_keys
          ).first_or_initialize

          if client_params[:email].present? || client.new_record?
            client.update!(email: client_params[:email])
          end
        end

        service_order = nil

        if options["model"].persisted?
          # TODO
        else
          service_order = ServiceOrder.new(params)

          service_order_date = params["date"].to_date

          last_service_order_on_the_date = ServiceOrder.
            where(date: service_order_date).order(id: :desc).limit(1).first

          number =
            if last_service_order_on_the_date.blank?
              "#{ service_order_date }-0000"
            else
              plus_one =
                last_service_order_on_the_date.number.split("-").last.to_i.next.
                # pad with leading zeroes if necessary
                to_s.rjust(4, "0")

              "#{ service_order_date }-#{ plus_one }"
            end

          service_order.update!(
            number: number,
            user_id: options[:current_user]&.id,
            client_id: client.id
          )
        end

        options["model"] = service_order
      end
    end
end
