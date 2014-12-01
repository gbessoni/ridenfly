require 'rails_helper'

RSpec.describe "Admin::Reservations" do
  before do
    sign_in_as_a_valid_user
  end

  describe "GET /admin/reservations" do
    it "works!" do
      get admin_reservations_path
      expect(response).to have_http_status(200)
    end
  end
end
