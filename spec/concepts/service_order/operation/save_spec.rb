# frozen_string_literal: true

# spring rspec spec/concepts/service_order/operation/save_spec.rb
RSpec.describe ServiceOrder::Save do
  describe ".call(params, options)" do
    subject(:call) { described_class.call(params, options) }

    let(:options) { {} }

    context "when params are OK for saving a service order with a new client" do
      let(:params) do

      end

      # <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"Hem+/p/y1izaRiOzQzRJyXeFsKGICzEHqmF29dd2g+XgOdKkHOwviJzcP09+9pwI6fksnLhC5MqHyxMB0kgX0w==", "service_order"=>{"number"=>"", "date"=>"", "location"=>"Ausekļa iela 9", "client_first_name"=>"Andris", "client_last_name"=>"Krauklis", "client_phone_prefix"=>"", "client_phone_number"=>"", "client_email"=>"", "device_name"=>"", "device_password"=>"", "device_warranty"=>"0", "device_extras"=>"", "device_saveable_info"=>"", "device_defect"=>"", "device_additional_info"=>""}, "commit"=>"Create Service order", "controller"=>"service_orders", "action"=>"create"} permitted: false>

      it " " do
        expect(0).to eq(1)
      end
    end
  end
end
