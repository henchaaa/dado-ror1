# frozen_string_literal: true

# spring rspec spec/concepts/service_order/operation/save_spec.rb
RSpec.describe ServiceOrder::Save do
  describe ".call(params, options)" do
    subject(:call) { described_class.call(params, options) }

    let(:options) { {current_user: user} }
    let(:user) { User.create!(email: "test@test.com", password: "abc") }

    let(:params) do
      {
        date: "2020-01-10",
        location: "Ausekļa iela 9",
        device_name: "Samsung galaxy",
        device_password: "1234",
        device_warranty: "0",
        device_extras: "big speakers",
        device_saveable_info: "",
        device_defect: "b0rken",
        device_additional_info: "",
        client: {
          first_name: "John",
          last_name: "Doe",
          phone_prefix: "00371",
          phone_number: "29957752",
          email: "j.d@gmail.com"
        }
      }
    end

    context "when params are OK for saving a service order with a new client" do
      it "creates a service order and a client" do
        expect{ call }.to(
          change{ ServiceOrder.count }.by(1).
          and change{ Client.count }.by(1)
        )

        is_expected.to be_success
      end
    end

    context "when params are OK for saving a service order for an existing client" do
      let!(:client) do
        Client.create(
          first_name: "John",
          last_name: "Doe",
          phone_prefix: "00371",
          phone_number: "29957752",
          email: "j.d@gmail.com"
        )
      end

      it "creates a service order for the existing client" do
        expect{ call }.to(
          change{ ServiceOrder.count }.by(1).
          and change{ Client.count }.by(0)
        )

        is_expected.to be_success
      end
    end

    context "when params are bad and no creation can take place" do
      let(:params) { {} }

      it "returns an object with validation errors" do
        is_expected.to_not be_success
      end
    end
  end
end
