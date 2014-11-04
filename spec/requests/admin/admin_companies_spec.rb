require 'rails_helper'

RSpec.describe "Admin::Companies" do
  before do
    sign_in_as_a_valid_user
  end

  describe "GET /admin/companies" do
    it "works!" do
      get admin_companies_path
      expect(response).to have_http_status(200)
    end
  end
end
