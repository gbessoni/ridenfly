FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    application { FactoryGirl.build(:app) }
  end
end
