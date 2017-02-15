FactoryGirl.define do
  factory :user do

    sequence :census_id do |n|
      n = rand(59)
      "#{n}"
    end

    sequence :first_name do |n|
      "Joh#{n}"
    end

    sequence :last_name do |n|
      "Do#{n}"
    end

    token "1d7ff31ba472ed175978ac864cb9b74076208bb9b38798c42e14a0817f804a1b"
  end
end
