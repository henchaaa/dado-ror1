# spring rspec spec/controllers/service_orders_controller_spec.rb
RSpec.describe RepairTasksController do
  let(:user) do
    User.create(email: "test@test.com", password: "123")
  end

  before { session[:user_id] = user.id }

  describe "POST :create" do
    subject(:make_request) { post :create, params: params }

    let(:params) { {test: "1"} }

    context "when creating succeeds" do
      xit " " do
        expect(0).to eq(1)
      end
    end

    context "when creating fails" do
      xit " " do
        expect(0).to eq(1)
      end
    end
  end
end
