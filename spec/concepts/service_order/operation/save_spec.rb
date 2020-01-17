# frozen_string_literal: true

# spring rspec spec/concepts/service_order/operation/save_spec.rb
RSpec.describe ServiceOrder::Save do
  describe ".call(params, options)" do
    subject(:call) { described_class.call(params, options) }

    let(:options) { {} }

    context "when params are OK for saving a service order with a new client" do
      let(:params) { {} }
      it " " do
        expect(0).to eq(1)
      end
    end
  end
end
