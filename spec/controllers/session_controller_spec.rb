RSpec.describe SessionController do
  describe "GET :new" do
    xit "returns TODO" do
      expect(0).to eq(1)
    end
  end

  describe "POST :create" do
    subject(:make_request) { post :create, params: params }

    context "when credentials for an existing user are provided" do
      let(:params) { {email: user.email, password: password} }

      let(:password) { "1234" }
      let!(:user) { User.create!(password: password, email: "test@test.com") }

      it "logs user in and redirects to /service_orders index" do
        expect{ make_request }.to(
          change{ session[:user_id] }
        )

        expect(response.location).to match(%r'/service_orders')
      end
    end

    context "when invalid credentials are provided" do
      let(:params) { {email: "1", password: "2" } }

      it "re-renders login with a flash about invalid credentials" do
        make_request

        expect(flash[:alert]).to be_present
        expect(response.location).to eq("http://test.host/")
      end
    end
  end
end
