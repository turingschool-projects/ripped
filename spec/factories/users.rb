FactoryGirl.define do
  factory :user do

    sequence :census_id do |n|
      "#{n}"
    end

    sequence :first_name do |n|
      "Joh#{n}"
    end

    sequence :last_name do |n|
      "Do#{n}"
    end

    sequence :token do |n|
      "#{n}"
    end
  end
end
