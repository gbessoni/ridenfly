FactoryGirl.define do
  factory :user do
    
  end

  factory :admin, class: User do
    sequence(:email)      { |n| "admin_#{n}@example.com" }
    password              "admin_password"
    password_confirmation "admin_password"
  end
end
