require 'rails_helper'

RSpec.describe "Admin::Companies", :type => :request do
  describe "GET /admin_companies" do
    it "works! (now write some real specs)" do
      get admin_companies_path
      expect(response).to have_http_status(200)
    end
  end
end
