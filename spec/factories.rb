FactoryGirl.define do
  factory :idea do
    sequence(:title) { |n| "Idea #{n}" }
    sequence(:body) { |n| "Description #{n}" }
    quality 0
  end
end
