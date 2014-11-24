FactoryGirl.define do
  factory :app, class: 'Doorkeeper::Application' do
    name "test_app"
    redirect_uri Doorkeeper.configuration.native_redirect_uri
  end
end