require 'rails_helper'

RSpec.describe Api::Reservations::CancelController do
  let(:admin) { create(:admin) }
  let(:app) { create(:app, owner: admin) }
  let(:access_token) { create(:access_token, application: app) }
  let(:company) { create(:company, user: admin) }
  let(:airport) { create(:airport) }
  let(:rate) do
    create(:rate, airport: airport, company: company)
  end
  let(:reservation) { create(:reservation, rate: rate) }
  let(:params) do
    { format: :json,
      access_token: access_token.token,
      reservation_id: reservation.id,
      reservation:{ cancelation_reason: 'it was a test' }
    }
  end

  describe "POST 'cancel'" do
    context "successful" do
      before do
        post :create, params
      end

      it { expect(response).to be_success }
      it { expect(
        reservation.reload.cancelation_reason
      ).to eql 'it was a test' }
    end
  end
end
