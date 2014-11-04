FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "user_#{n}@example.com" }
    password              "user_password"
    password_confirmation "user_password"    
  end

  factory :admin, class: User do
    sequence(:email)      { |n| "admin_#{n}@example.com" }
    password              "admin_password"
    password_confirmation "admin_password"
  end
end
