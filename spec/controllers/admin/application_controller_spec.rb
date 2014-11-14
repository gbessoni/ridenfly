require 'rails_helper'

RSpec.describe Admin::ApplicationController do
  before do
    sign_in create(:admin)
  end

  describe "rescue from active record not found error" do
    controller do
      def index
        Reservation.find(params[:id])
      end
    end

    before do
      get :index, id: 1
    end

    it "redirects to admin root page" do
      expect(response).to redirect_to admin_root_url
    end
  end
end
