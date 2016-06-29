require 'rails_helper'

RSpec.feature 'user updates idea', js: true do
  scenario "user updates idea title" do
    idea = create(:idea)
    new_title = 'New Title'

    visit '/'

    find(".title").click
    find(".title").set(new_title)
    find(".title").native.send_keys(:enter)

    expect(page).to have_content(new_title)
    expect(page).to_not have_content(idea.title)
  end

  scenario "user edits idea body" do
    idea = create(:idea)
    new_body = 'New Description'

    visit '/'

    find(".body").click
    find(".body").set(new_body)
    find(".body").native.send_keys(:enter)

    expect(page).to have_content(new_body)
    expect(page).to_not have_content(idea.body)
  end
end
