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
  step :validate!
  # step Contract::Validate(name: "resource", key: "resource")
  step Contract::Validate(name: "resource")
  step :persist!

  private

    def validate!(options, **)
      # TODO, collect validation errors and return false if any present
      true
    end

    def persist!(options, **)
      options["contract.resource"].save do |params|
        client = nil

        options["contract.resource"].client.save do |client_params|
          client = Client.where(
            **client_params.except(:email).symbolize_keys
          ).first_or_initialize

          if client_params[:email].present? || client.new_record?
            client.update!(email: client_params[:email])
          end
        end

        if options["model"].persisted?
          # TODO
        else
          service_order = ServiceOrder.new(params[:service_order])

          last_todays_record = ServiceOrder.
            where(date: Date.current).order(id: :desc).limit(1).first

          number =
            if last_todays_record.blank?
              "#{ Date.current }-0000"
            else
              "#{ Date.current }-#{ last_todays_record.number.split("-").last.to_i.next }"
            end

          service_order.update!(
            number: number,
            user_id: options[:current_user]&.id,
            client_id: client.id
          )
        end
      end
    end
end
