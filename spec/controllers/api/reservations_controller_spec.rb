require 'rails_helper'

RSpec.describe Api::ReservationsController do
  let(:company) do
    create(:company, user: create(:user))
  end
  let(:airport) do
    create(:airport)
  end
  let(:valid_attributes) do
    build(:reservation).attributes.merge(
      company_id: company.id,
      airport_id: airport.id
    )
  end
  let(:invalid_attributes) do
    {net_fare: nil}
  end
  let(:valid_session) { {} }
  let(:params) { {format: :json} }
  let(:reservation) do
    create(:reservation, valid_attributes)
  end
  let(:json_response) do
    JSON.parse(response.body)
  end

  describe "GET index" do
    before do
      reservation
      get :index, params, valid_session
    end

    it "assigns all reservations as @reservations" do
      expect(assigns(:reservations)).to eq([reservation])
    end

    it "renders json" do
      expect(json_response['reservations'].size).to eql(1)
    end
  end

  describe "GET show" do
    before do
      get :show, params.merge(:id => reservation.to_param), valid_session
    end

    it "assigns the requested reservation as @reservation" do
      expect(assigns(:reservation)).to eq(reservation)
    end

    it "renders json" do
      expect(json_response['reservation']).to include('id' => reservation.id)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reservation" do
        expect {
          post :create, params.merge(reservation: valid_attributes), valid_session
        }.to change(Reservation, :count).by(1)
      end

      it "assigns a newly created reservation as @reservation" do
        post :create, params.merge(reservation: valid_attributes), valid_session
        expect(assigns(:reservation)).to be_a(Reservation)
        expect(assigns(:reservation)).to be_persisted
      end

      it "renders json" do
        post :create, params.merge(reservation: valid_attributes), valid_session
        expect(json_response['reservation']).to include('id' => Reservation.last.id)
      end
    end

    describe "with invalid params" do
      before do
        post :create, params.merge(reservation: invalid_attributes), valid_session
      end

      it "assigns a newly created but unsaved reservation as @reservation" do
        expect(assigns(:reservation)).to be_a_new(Reservation)
      end

      it "renders json with errors" do
        expect(json_response['reservation']['errors']).to be_present
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) do
        {net_fare: 120.0}
      end

      before do
        put :update, params.merge(id: reservation.to_param, reservation: new_attributes), valid_session
      end

      it "updates the requested reservation" do
        expect(reservation.reload.net_fare).to eql 120.0
      end

      it "assigns the requested reservation as @reservation" do
        expect(assigns(:reservation)).to eq(reservation)
      end

      it "renders json" do
        expect(json_response['reservation']).to include('id' => reservation.id)
      end
    end

    describe "with invalid params" do
      before do
        put :update, params.merge(id: reservation.to_param, reservation: invalid_attributes), valid_session
      end

      it "assigns the reservation as @reservation" do
        expect(assigns(:reservation)).to eq(reservation)
      end

      it "renders json with errors" do
        expect(json_response['reservation']['errors']).to be_present
      end
    end
  end
end
