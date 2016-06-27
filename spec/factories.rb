FactoryGirl.define do
  factory :idea do
    sequence(:title) { |n| "Idea #{n}" }
    sequence(:body) { |n| "Description about Idea #{n}" }
    quality 1
  end
end
