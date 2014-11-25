require 'rails_helper'

RSpec.describe Admin::ReservationsController do
  let(:admin)   { create(:admin) }
  let(:company) do
    create(:company, user: admin)
  end
  let(:airport) do
    create(:airport)
  end
  let(:rate) do
    create(:rate, airport: airport, company: company)
  end
  let(:valid_attributes) do
    build(:reservation).attributes.merge(
      rate_id: rate.id
    )
  end
  let(:invalid_attributes) do
    {net_fare: nil}
  end
  let(:valid_session) { {} }
  let(:reservation) do
    create(:reservation, valid_attributes)
  end

  before do
    sign_in admin
  end

  describe "user role" do
    let(:user) { create(:user, roles: [User::COMPANY]) }

    context "company" do
      before do
        create(:company, user: user)
        sign_in user
        get :index
      end

      it { expect(response).to be_success }
    end

    context "without company" do
      before do
        sign_in user
        get :index
      end

      it { expect(response).to redirect_to(admin_root_url) }
    end
  end

  describe "GET index" do
    before { reservation }

    it "assigns all reservations as @reservations" do
      get :index, {}, valid_session
      expect(assigns(:reservations)).to eq([reservation])
    end
  end

  describe "GET index as csv" do
    before { reservation }

    it "assigns all reservations as @reservations" do
      get :index, {format: :csv}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "assigns the requested reservation as @reservation" do
      get :show, {:id => reservation.to_param}, valid_session
      expect(assigns(:reservation)).to eq(reservation)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reservation" do
      reservation
      expect {
        delete :destroy, {:id => reservation.to_param}, valid_session
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the reservations list" do
      delete :destroy, {:id => reservation.to_param}, valid_session
      expect(response).to redirect_to(admin_reservations_url)
    end
  end
end
