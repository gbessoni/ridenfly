require 'rails_helper'

RSpec.describe "Api::Reservations" do
  let(:access_app) { create(:app, owner: create(:admin)) }
  let(:access_token) { create(:access_token, application: access_app) }
  let(:json_response) { JSON.parse response.body }

  describe "GET /api/1/reservations" do
    it "works!" do
      get api_reservations_url(format: :json, access_token: access_token.token)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/1/reservations" do
    let(:reservation) do
      {rate_id: 1}
    end

    before do
      post api_reservations_url(
        format: :json,
        access_token: access_token.token,
        reservations: [reservation]
      )
    end

    # it { expect(response).to have_http_status(200) }
    # it { expect(json_response).to eql({}) }
  end
end
