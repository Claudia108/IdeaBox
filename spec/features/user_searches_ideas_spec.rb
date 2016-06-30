require 'rails_helper'

RSpec.feature "user searches ideas", js: true do
  scenario "user searches ideas" do
    idea1 = Idea.create(title: "First idea", body: "So fun!")
    idea2 = Idea.create(title: "Second Idea", body: "More fun!")
    idea3 = Idea.create(title: "Third idea", body: "Most fun!")

    visit '/'

    expect(page).to have_content(idea1.title)
    expect(page).to have_content(idea1.body)
    expect(page).to have_content(idea2.title)
    expect(page).to have_content(idea2.body)
    expect(page).to have_content(idea3.title)
    expect(page).to have_content(idea3.body)

    find("#search-text").click
    find("#search-text").set('first')
    wait_for_ajax

    expect(page).to have_content(idea1.title)
    expect(page).to have_content(idea1.body)

    expect(page).to_not have_content(idea2.title)
    expect(page).to_not have_content(idea2.body)
    expect(page).to_not have_content(idea3.title)
    expect(page).to_not have_content(idea3.body)

    find("#search-text").set('more')
    wait_for_ajax

    expect(page).to_not have_content(idea1.title)
    expect(page).to_not have_content(idea1.body)

    expect(page).to have_content(idea2.title)
    expect(page).to have_content(idea2.body)

    expect(page).to_not have_content(idea3.title)
    expect(page).to_not have_content(idea3.body)

    find("#search-text").set("Idea");
    wait_for_ajax

    expect(page).to have_content(idea1.title)
    expect(page).to have_content(idea1.body)
    expect(page).to have_content(idea2.title)
    expect(page).to have_content(idea2.body)
    expect(page).to have_content(idea3.title)
    expect(page).to have_content(idea3.body)
  end
end
