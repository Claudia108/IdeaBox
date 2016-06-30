require 'rails_helper'

RSpec.feature "user creates new idea" do
  scenario "user fills in title and body and saves", js: true do
    visit '/'

    fill_in "Title", with: "Idea 1"
    fill_in "Describe Your Idea", with: "Description 1"
    find("#save-idea").click

    expect(current_path).to eq("/")

    expect(page).to have_content("Idea 1")
    expect(page).to have_content("Description 1")
    expect(page).to have_content("swill")
  end
end
