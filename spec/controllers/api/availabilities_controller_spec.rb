require 'rails_helper'

RSpec.describe Api::AvailabilitiesController do
  let(:app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: app) }
  let(:params) { {format: :json, access_token: access_token.token} }

  describe "GET index" do
    it "returns http success" do
      get :index, params
      expect(response).to have_http_status(:success)
    end
  end

end
