require 'rails_helper'

RSpec.describe "Api::Availabilities" do
  describe "GET /api/1/availabilities" do
    it "works!" do
      get api_availabilities_url(format: :json)
      expect(response).to have_http_status(200)
    end
  end
end
