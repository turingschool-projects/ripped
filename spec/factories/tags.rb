FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "name #{n}"
    end
  end
end
