# frozen_string_literal: true

# spring rspec spec/concepts/repair_task/operation/save_spec.rb
RSpec.describe RepairTask::Save do
  describe ".call(params, options)" do
    subject(:call) { described_class.call(params, options) }

    let(:options) { {current_user: user} }
    let(:user) { User.create!(email: "test@test.com", password: "abc") }

    let(:params) do
      {
        TODO: true
      }
    end

    context "when params are OK for saving new repair task" do
      xit "creates a repair task" do
        expect{ call }.to(
          change{ RepairTask.count }.by(1)
        )

        is_expected.to be_success
      end
    end

    context "when params are OK for updating a repair task" do
      xit "updates repair task" do
        expect{ call }.to(
          change{ RepairTask.count }.by(0)
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
