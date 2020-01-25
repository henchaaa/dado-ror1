# spring rspec spec/models/repair_task_spec.rb
RSpec.describe RepairTask do
  describe "associations" do
    subject(:repair_task) { described_class.new }

    it do
      is_expected.to belong_to(:service_order)
      is_expected.to belong_to(:repairer)
    end
  end
end
