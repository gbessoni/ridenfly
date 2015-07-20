require 'rails_helper'

RSpec.describe Admin::PaymentsController, type: :controller do
  before do
    sign_in create(:admin)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:company) do
      create(:company, user: create(:user))
    end

    before do
      post :create, payment: {
        company_id: company.id,
        from: '2015-10-10 00:12:21',
        to: '2015-10-12 00:22:00'
      }, format: :json
    end

    it { expect(response).to be_success }
    it { expect(Payment.last).to be_present }
  end
end
