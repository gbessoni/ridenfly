require 'rails_helper'

RSpec.describe Admin::AppsController do
  let(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  describe "GET 'index'" do
    before do
      get :index
    end

    it { expect(response).to be_success }
  end

  describe "POST 'create'" do
    let(:app) { Doorkeeper::Application.last }

    before do
      post :create, application: {
        name: 'test', uid: 'test', secret: 'test',
        redirect_uri: 'urn:ietf:wg:oauth:2.0:oob'
      }
    end

    it { expect(response).to redirect_to(
      oauth_application_url(app)
    ) }

    it { expect(app.owner).to eql admin }
  end
end
