# spring rspec spec/controllers/service_orders_controller_spec.rb
RSpec.describe ServiceOrdersController do
  let(:user) do
    User.create(email: "test@test.com", password: "123")
  end

  before { session[:user_id] = user.id }

  describe "GET :index" do
    subject(:make_request) { get :index, params: params }

    let(:params) { {number: "123"} }

    it "collects filtered records and renders" do
      expect(ServiceOrder::Collector).to(
        receive(:call).with(params: hash_including(number: "123")).once
      )

      make_request
    end
  end

  describe "POST :create" do
    subject(:make_request) { post :create, params: params }

    let(:params) { {service_order_contract: {test: "1"}} }

    context "when creating a ServiceOrder succeeds" do
      let(:mock_record) { instance_double("ServiceOrder", id: 1) }

      let(:mock_outcome) do
        d = instance_double("Trailblazer::Operation::Result", success?: true)

        allow(d).to receive(:[]).with("model").and_return(mock_record)

        d
      end

      it "redirects to created recor's #show" do
        expect(ServiceOrder::Save).to(
          receive(:call).with(
            hash_including(test: "1"), current_user: user
          ).once.and_return(mock_outcome)
        )

        make_request

        expect(response.location).to match(%r'\Ahttp://test.host/service_orders/1')
        expect(flash[:notice]).to be_present
      end
    end

    context "when creating a ServiceOrder fails" do
      let(:mock_outcome) do
        d = instance_double("Trailblazer::Operation::Result", success?: false)

        allow(d).to receive(:[]).with("contract.resource").and_return(mock_form)

        d
      end

      let(:mock_form) do
        instance_double("ServiceOrder::Contract::Form")
      end

      it "re-renders :new form with validation errors" do
        expect(ServiceOrder::Save).to(
          receive(:call).with(
            hash_including(test: "1"), current_user: user
          ).once.and_return(mock_outcome)
        )

        expect(controller).to receive(:render).with(:new).once

        make_request

        expect(flash.now[:alert]).to be_present
      end
    end
  end
end
