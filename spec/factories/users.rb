FactoryGirl.define do
  factory :user do

    census_id 14

    sequence :first_name do |n|
      "Joh#{n}"
    end

    sequence :last_name do |n|
      "Do#{n}"
    end

    token ENV["census_token"]
  end
end
