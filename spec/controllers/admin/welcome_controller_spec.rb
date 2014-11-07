require 'rails_helper'

RSpec.describe Admin::WelcomeController do

  before do
    sign_in create(:admin)
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
