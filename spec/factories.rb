FactoryGirl.define do
  factory :user do
    sequence(:name)   { |n| "Weiwei #{n}" }
    sequence(:email)  { |n| "peggyliu_#{n}@gmail.com" }
    password  "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end
