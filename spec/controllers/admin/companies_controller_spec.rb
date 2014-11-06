require 'rails_helper'

RSpec.describe Admin::CompaniesController do

  let(:valid_attributes) do
    build(:company).attributes.merge(
      user_attributes: {
        email: build(:user).email,
        password: 'somepassword',
        password_confirmation: 'somepassword'
      }
    )
  end

  let(:invalid_attributes) do
    {name: ''}
  end

  let(:valid_session) { {} }

  before do
    sign_in create(:admin)
  end

  describe "GET index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe "GET show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, {:id => company.to_param}, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "GET new" do
    it "assigns a new company as @company" do
      get :new, {}, valid_session
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "GET edit" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :edit, {:id => company.to_param}, valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, {:company => valid_attributes}, valid_session
        }.to change(Company, :count).by(1)
      end

      it "assigns a newly created company as @company" do
        post :create, {:company => valid_attributes}, valid_session
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end

      it "redirects to the created company" do
        post :create, {:company => valid_attributes}, valid_session
        expect(response).to redirect_to([:admin, Company.last])
      end

      it "assigns role 'COMPANY' to the created company user" do
        post :create, {:company => valid_attributes}, valid_session
        expect(assigns(:company).user).to be_company
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        post :create, {:company => invalid_attributes}, valid_session
        expect(assigns(:company)).to be_a_new(Company)
      end

      it "re-renders the 'new' template" do
        post :create, {:company => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: 'new name'}
      }

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => new_attributes}, valid_session
        expect(company.reload.name).to eql 'new name'
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => new_attributes}, valid_session
        expect(assigns(:company)).to eq(company)
      end

      it "redirects to the company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => new_attributes}, valid_session
        expect(response).to redirect_to([:admin, company])
      end
    end

    describe "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
        expect(assigns(:company)).to eq(company)
      end

      it "re-renders the 'edit' template" do
        company = Company.create! valid_attributes
        put :update, {:id => company.to_param, :company => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, {:id => company.to_param}, valid_session
      }.to change(Company, :count).by(-1)
    end

    it "redirects to the companies list" do
      company = Company.create! valid_attributes
      delete :destroy, {:id => company.to_param}, valid_session
      expect(response).to redirect_to(admin_companies_url)
    end
  end

end
