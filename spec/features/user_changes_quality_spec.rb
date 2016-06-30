require 'rails_helper'

RSpec.feature "user changes quality of idea" do
  scenario "user upvotes idea", js: true do
    idea = create(:idea)

    visit '/'

    expect(page).to have_content("swill")

    within("#idea-#{idea.id}") do
      find(".upvote").click
    end

    expect(page).to have_current_path('/')
    expect(page).to have_content("plausible")

    within("#idea-#{idea.id}") do
      find(".upvote").click
    end

    expect(page).to have_content("genius")

    within("#idea-#{idea.id}") do
      find(".upvote").click
    end

    expect(page).to have_content("genius")
  end

  scenario "user downvotes idea", js: true do
    idea = create(:idea, quality: 2)

    visit '/'

    expect(page).to have_content("genius")

    within("#idea-#{idea.id}") do
      find(".downvote").click
    end

    expect(page).to have_content("plausible")

    within("#idea-#{idea.id}") do
      find(".downvote").click
    end

    expect(page).to have_content("swill")

    within("#idea-#{idea.id}") do
      find(".downvote").click
    end

    expect(page).to have_content("swill")
  end
end
