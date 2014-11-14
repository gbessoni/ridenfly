require 'rails_helper'

RSpec.describe "Api::Reservations" do
  describe "GET /api/1/reservations" do
    it "works!" do
      get api_reservations_url(format: :json)
      expect(response).to have_http_status(200)
    end
  end
end
