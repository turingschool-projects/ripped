FactoryGirl.define do
  factory :user do
    sequence :census_id do |n|
      "#{n}"
    end
  end
end
