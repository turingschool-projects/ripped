FactoryGirl.define do
  factory :exercise do
    sequence :name do |n|
      "Exercise #{n}"
    end
    content "exercise content"
  end
end
