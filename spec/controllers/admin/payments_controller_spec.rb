require 'rails_helper'

RSpec.describe Admin::PaymentsController, type: :controller do
  let(:company) do
    create(:company, user: create(:user))
  end

  before do
    sign_in create(:admin)
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    before do
      create(:payment, company: company)

      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "successfull" do
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

    context "unsuccessful" do
      before do
        post :create, payment: {
          company_id: company.id,
        }, format: :json
      end

      it { expect(response.status).to eql 422 }
      it { expect(Payment.last).to be_nil }
    end
  end

  describe "PUT #update" do
    let(:payment) { create(:payment, company: company, paid: false) }

    before do
      put :update, id: payment, payment: {paid: true}, format: :json
    end

    it { expect(response).to be_success }
    it { expect(Payment.last.paid).to eql true }
  end

  describe "DELETE #destroy" do
    let(:payment) { create(:payment, company: company) }

    before do
      delete :destroy, id: payment.id
    end

    it { expect(response).to redirect_to admin_payments_url }
    it { expect(Payment.count).to eql 0 }
  end
end
