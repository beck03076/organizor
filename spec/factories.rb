FactoryGirl.define do
  sequence :first_name do |n|
    "Wolfgang#{n}"
  end
  sequence :surname do |n|
    "Mozart#{n}"
  end
  sequence :email do |n|
    "wolfgang#{n}@mozart.com"
  end
  sequence(:date_of_birth) { |n| (Date.new(1985,12,31) + n.days).to_s }
  
  factory :user do
    email 
  end
  
  factory :enquiry do
    email1 FactoryGirl.generate(:email) 
    first_name 
    surname
    date_of_birth
    active true
  end
  
end
