require 'rails_helper'

RSpec.describe Api::AvailabilitiesController do

  let(:params) { {format: :json} }

  describe "GET index" do
    it "returns http success" do
      get :index, params
      expect(response).to have_http_status(:success)
    end
  end

end
