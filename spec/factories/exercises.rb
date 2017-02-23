FactoryGirl.define do
  factory :exercise do
    sequence :name do |n|
      "Exercise #{n}"
    end
    sequence :description do |n|
      "exercise description #{n}"
    end
    sequence :content do |n|
      "exercise content #{n}"
    end
    tags { [create(:tag)] }
  end
end
