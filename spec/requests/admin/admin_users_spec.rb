require 'rails_helper'

RSpec.describe "Admin::Users" do
  before do
    sign_in_as_a_valid_user
  end

  describe "GET /admin/users" do
    it "works!" do
      get admin_users_path
      expect(response).to have_http_status(200)
    end
  end
end
