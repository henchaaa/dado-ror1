# spring rspec spec/models/user_spec.rb
RSpec.describe User do
  describe "associations" do
    subject(:user) { described_class.new }

    it do
      is_expected.to have_many(:service_orders)
      is_expected.to have_many(:repair_tasks)
    end
  end
end
