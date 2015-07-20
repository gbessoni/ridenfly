require 'rails_helper'

RSpec.describe Admin::Reports::CompaniesController do

  before do
    sign_in create(:admin)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index with params" do
    it "returns http success" do
      get :index, q: {
        reservations_pickup_datetime_start_date_gteq: '2014-10-10',
        reservations_pickup_datetime_end_date_lteq: '2014-10-12'
      }
      expect(response).to have_http_status(:success)
    end
  end
end
