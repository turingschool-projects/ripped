FactoryGirl.define do
  factory :solution do
    sequence :content do |n|
      "solution content #{n}"
    end
    user
    exercise
  end
end
