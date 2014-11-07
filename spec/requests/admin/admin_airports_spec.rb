require 'rails_helper'

RSpec.describe "Admin::Airports" do
  before do
    sign_in_as_a_valid_user
  end

  describe "GET /admin/airports" do
    it "works!" do
      get admin_airports_path
      expect(response).to have_http_status(200)
    end
  end
end
