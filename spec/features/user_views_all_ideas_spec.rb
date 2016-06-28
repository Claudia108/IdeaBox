require 'rails_helper'

RSpec.feature "user sees all ideas" do
  scenario "user sees all ideas", js: true do
    idea1, idea2, idea3 = create_list(:idea, 3)

    visit '/'
    wait_for_ajax

    # Idea.all.each do |idea|
      expect(page).to have_content(idea1.title)
      expect(page).to have_content(idea1.body)
      expect(page).to have_content(idea1.quality)
    # end

    expect(page).to have_selector('h3', count: 3)
  end

  scenario "user sees most recent idea on top", js: true do
    idea = create(:idea)

    visit '/'
    wait_for_ajax

    within('h2:first-child') {expect(page).to have_content(idea.title)}
    within('h2:first-child') {expect(page).to have_content(idea.body)}

    new_idea = create(:idea)

    visit '/'
    wait_for_ajax

    within('h2:first-child') { expect(page).to have_content(new_idea.title) }
    within('h2:first-child') { expect(page).to have_content(new_idea.body) }
  end
end
