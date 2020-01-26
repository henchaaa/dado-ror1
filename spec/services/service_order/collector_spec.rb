# spring rspec spec/services/service_order/collector_spec.rb
RSpec.describe ServiceOrder::Collector do
  let(:service) do
    described_class.new(params: params)
  end

  let(:repairer) { User.create!(email: "test@test.com", password: "123") }

  describe "call" do
    subject(:call) { service.call }

    let!(:match) do
      s = ServiceOrder::Save.call(service_order_params1, current_user: repairer)["model"]

      RepairTask.create!(
        repairer_id: repairer.id,
        service_order_id: s.id,
        status: 1,
        currency: "EUR"
      )

      s
    end

    let!(:counter) do
      ServiceOrder::Save.call(service_order_params2, current_user: repairer)["model"]
    end

    let(:service_order_params1) do
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

    let(:service_order_params2) do
      p2 = service_order_params1.dup
      p2[:client].merge!(last_name: "Defoe", phone_number: "1234567")
      p2
    end

    it "filters by service order number, status, repairer, client phone number, and client last_name" do
      # no params passed, finds all (two) records
      params = {}
      expect(described_class.call(params: params).size).to eq(2)

      # filter by number
      params = {number: match.number}
      expect(described_class.call(params: params)).to contain_exactly(match)

      # filter by status, pt1
      params = {status: RepairTask.statuses.key(0).to_s}
      expect(described_class.call(params: params)).to contain_exactly(counter)
      # filter by status, pt2
      params = {status: match.repair_task.status}
      expect(described_class.call(params: params)).to contain_exactly(match)

      # filter by repairer
      params = {repairer_id: match.repair_task.repairer_id}
      expect(described_class.call(params: params)).to contain_exactly(match)

      # filter by client phone number
      params = {phone_number: match.client_phone_number}
      expect(described_class.call(params: params)).to contain_exactly(match)

      # filter by client last_name
      params = {last_name: match.client_last_name}
      expect(described_class.call(params: params)).to contain_exactly(match)
    end
  end
end
