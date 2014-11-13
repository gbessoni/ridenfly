require 'rails_helper'

RSpec.describe Admin::Import::RatesController do

  before do
    sign_in create(:admin)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST 'create'" do
    context "success" do
      before do
        allow_any_instance_of(Import::Rate).to receive(:perform) { true }
        allow_any_instance_of(Import::Rate).to receive(:objects) { [
          build(:rate)
        ] }
        post :create, import_rate: {import_file: double}
      end

      it { expect(response).to have_http_status(:success) }
    end

    context "fail" do
      before do
        post :create, import_rate: {import_file: ''}
      end

      it { expect(response).to have_http_status(:success) }
    end
  end
end
