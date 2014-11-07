require 'rails_helper'

RSpec.describe Admin::AirportsController do

  let(:valid_attributes) do
    build(:airport).attributes
  end

  let(:invalid_attributes) do
    {code: 'asdf123'}
  end

  let(:valid_session) { {} }

  before do
    sign_in create(:admin)
  end

  describe "GET index" do
    it "assigns all airports as @airports" do
      airport = Airport.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:airports)).to eq([airport])
    end
  end

  describe "GET show" do
    it "assigns the requested airport as @airport" do
      airport = Airport.create! valid_attributes
      get :show, {:id => airport.to_param}, valid_session
      expect(assigns(:airport)).to eq(airport)
    end
  end

  describe "GET new" do
    it "assigns a new airport as @airport" do
      get :new, {}, valid_session
      expect(assigns(:airport)).to be_a_new(Airport)
    end
  end

  describe "GET edit" do
    it "assigns the requested airport as @airport" do
      airport = Airport.create! valid_attributes
      get :edit, {:id => airport.to_param}, valid_session
      expect(assigns(:airport)).to eq(airport)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Airport" do
        expect {
          post :create, {:airport => valid_attributes}, valid_session
        }.to change(Airport, :count).by(1)
      end

      it "assigns a newly created airport as @airport" do
        post :create, {:airport => valid_attributes}, valid_session
        expect(assigns(:airport)).to be_a(Airport)
        expect(assigns(:airport)).to be_persisted
      end

      it "redirects to the created airport" do
        post :create, {:airport => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Airport.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved airport as @airport" do
        post :create, {:airport => invalid_attributes}, valid_session
        expect(assigns(:airport)).to be_a_new(Airport)
      end

      it "re-renders the 'new' template" do
        post :create, {:airport => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) do
        {zipcode: '12333'}
      end

      it "updates the requested airport" do
        airport = Airport.create! valid_attributes
        put :update, {:id => airport.to_param, :airport => new_attributes}, valid_session
        expect(airport.reload.zipcode).to eql '12333'
      end

      it "assigns the requested airport as @airport" do
        airport = Airport.create! valid_attributes
        put :update, {:id => airport.to_param, :airport => valid_attributes}, valid_session
        expect(assigns(:airport)).to eq(airport)
      end

      it "redirects to the airport" do
        airport = Airport.create! valid_attributes
        put :update, {:id => airport.to_param, :airport => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, airport])
      end
    end

    describe "with invalid params" do
      it "assigns the airport as @airport" do
        airport = Airport.create! valid_attributes
        put :update, {:id => airport.to_param, :airport => invalid_attributes}, valid_session
        expect(assigns(:airport)).to eq(airport)
      end

      it "re-renders the 'edit' template" do
        airport = Airport.create! valid_attributes
        put :update, {:id => airport.to_param, :airport => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested airport" do
      airport = Airport.create! valid_attributes
      expect {
        delete :destroy, {:id => airport.to_param}, valid_session
      }.to change(Airport, :count).by(-1)
    end

    it "redirects to the airports list" do
      airport = Airport.create! valid_attributes
      delete :destroy, {:id => airport.to_param}, valid_session
      expect(response).to redirect_to(admin_airports_url)
    end
  end

end
