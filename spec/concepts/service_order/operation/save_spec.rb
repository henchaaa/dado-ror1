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

        expect(call["model"].date).to eq("2020-01-10".to_date)
        expect(call["model"].number).to eq("2020-01-10-0000")

        expect(call["model"].user_id).to eq(user.id)
        expect(call["model"].client_id).to be_present

        expect(call["model"].client).to be_present
      end

      context "when two submits come in one after the other" do
        let(:params2) { params.merge(device_name: "iPhone") }

        it "creates two service orders woith consecutive numbers" do
          expect do
            described_class.call(params, options)
            described_class.call(params2, options)
          end.to(
            change{ ServiceOrder.count }.by(2).
            and change{ Client.count }.by(1)
          )

          expect(ServiceOrder.pluck(:number).sort).to eq(
            ["2020-01-10-0000", "2020-01-10-0001"]
          )
        end
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

        expect(call["model"].client).to eq(client)
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
