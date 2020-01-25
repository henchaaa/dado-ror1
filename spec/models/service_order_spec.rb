# spring rspec spec/models/service_order_spec.rb
RSpec.describe ServiceOrder do
  describe "associations" do
    subject(:service_order) { described_class.new }

    it do
      is_expected.to belong_to(:user)
      is_expected.to belong_to(:client)
      is_expected.to have_one(:repair_task)
    end
  end
end
