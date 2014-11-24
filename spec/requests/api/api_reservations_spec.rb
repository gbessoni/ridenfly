require 'rails_helper'

RSpec.describe "Api::Reservations" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }

  describe "GET /api/1/reservations" do
    it "works!" do
      get api_reservations_url(format: :json, access_token: access_token.token)
      expect(response).to have_http_status(200)
    end
  end
end
