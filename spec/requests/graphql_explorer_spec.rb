RSpec.describe "GraphQL Explorer" do
  before { EvmSpecHelper.local_miq_server }

  describe "GET /graphql" do
    it "displays the graphiql explorer to an authenticated user" do
      user = FactoryGirl.create(:user_with_email, :password => "smartvm", :role => "super_administrator")
      post "/dashboard/authenticate", :params => { :user_name => user.userid, :user_password => user.password }

      get("/graphql")

      expect(response).to have_http_status(:ok)
    end

    it "redirects to the login page for an unauthenticated user" do
      get("/graphql")

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to("/?timeout=false")
    end
  end
end
