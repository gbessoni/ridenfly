require 'rails_helper'

RSpec.describe Admin::RatesController do
  let(:admin)   { create(:admin) }
  let(:airport) { create(:airport) }
  let(:company) { create(:company, user: admin) }
  let(:valid_attributes) do
    build(:rate).attributes.merge(
      airport_id: airport.id,
      company_id: company.id,
      to_airport_pickup_time_list: ['10:00AM', '11:00PM'].join(
        Rate::PickupTimeMerger::PICKUP_TIMES_SEP
      ),
      lat_lng: '13,21'
    )
  end
  let(:invalid_attributes) do
    {base_rate: nil}
  end
  let(:valid_session) { {} }

  before do
    sign_in admin
  end

  describe "admin and company roles missing" do
    before do
      sign_in create(:user, roles: [])
      get :index
    end

    it { expect(response).to redirect_to(admin_root_url) }
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
    it "assigns all rates as @rates" do
      rate = Rate.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:rates)).to eq([rate])
    end
  end

  describe "GET index as csv" do
    it "assigns all rates as @rates" do
      rate = Rate.create! valid_attributes
      get :index, {format: :csv}, valid_session
      expect(response).to be_success
    end
  end

  describe "GET show" do
    it "assigns the requested rate as @rate" do
      rate = Rate.create! valid_attributes
      get :show, {:id => rate.to_param}, valid_session
      expect(assigns(:rate)).to eq(rate)
    end
  end

  describe "GET new" do
    it "assigns a new rate as @rate" do
      get :new, {}, valid_session
      expect(assigns(:rate)).to be_a_new(Rate)
    end
  end

  describe "GET edit" do
    it "assigns the requested rate as @rate" do
      rate = Rate.create! valid_attributes
      get :edit, {:id => rate.to_param}, valid_session
      expect(assigns(:rate)).to eq(rate)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rate" do
        expect {
          post :create, {:rate => valid_attributes}, valid_session
        }.to change(Rate, :count).by(1)
      end

      it "assigns a newly created rate as @rate" do
        post :create, {:rate => valid_attributes}, valid_session
        expect(assigns(:rate)).to be_a(Rate)
        expect(assigns(:rate)).to be_persisted
      end

      it "redirects to the created rate" do
        post :create, {:rate => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Rate.last])
      end

      it "renders success when ajax request" do
        xhr :post, :create, {:rate => valid_attributes}, valid_session
        expect(response).to render_template("shared/_success_message")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved rate as @rate" do
        post :create, {:rate => invalid_attributes}, valid_session
        expect(assigns(:rate)).to be_a_new(Rate)
      end

      it "re-renders the 'new' template" do
        post :create, {:rate => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end

      it "renders form with errors when ajax request" do
        xhr :post, :create, {:rate => invalid_attributes}, valid_session
        expect(response).to render_template("admin/rates/_form")
      end
    end
  end

  describe "PUT update" do
    let(:rate) { Rate.create! valid_attributes }

    describe "with valid params" do
      let(:new_attributes) do
        { base_rate: 75.5,
          to_airport_pickup_time_list: '09:00PM',
          from_airport_pickup_time_list: '08:00PM',
        }
      end

      it "updates the requested rate" do
        put :update, {:id => rate.to_param, :rate => new_attributes}, valid_session
        expect(rate.reload.base_rate).to eql 75.5
        expect(rate.to_airport_pickup_times.map(&:pickup_str)).to include '09:00PM'
        expect(rate.from_airport_pickup_times.map(&:pickup_str)).to include '08:00PM'
      end

      it "assigns the requested rate as @rate" do
        put :update, {:id => rate.to_param, :rate => valid_attributes}, valid_session
        expect(assigns(:rate)).to eq(rate)
      end

      it "redirects to the rate" do
        put :update, {:id => rate.to_param, :rate => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, rate])
      end

      it "renders success when ajax request" do
        xhr :put, :update, {:id => rate.to_param, :rate => valid_attributes}, valid_session
        expect(response).to render_template("shared/_success_message")
      end
    end

    describe "with invalid params" do
      it "assigns the rate as @rate" do
        put :update, {:id => rate.to_param, :rate => invalid_attributes}, valid_session
        expect(assigns(:rate)).to eq(rate)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => rate.to_param, :rate => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end

      it "renders form with errors when ajax request" do
        xhr :put, :update, {:id => rate.to_param, :rate => invalid_attributes}, valid_session
        expect(response).to render_template("admin/rates/_form")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested rate" do
      rate = Rate.create! valid_attributes
      expect {
        delete :destroy, {:id => rate.to_param}, valid_session
      }.to change(Rate, :count).by(-1)
    end

    it "redirects to the rates list" do
      rate = Rate.create! valid_attributes
      delete :destroy, {:id => rate.to_param}, valid_session
      expect(response).to redirect_to(admin_rates_url)
    end
  end

end
