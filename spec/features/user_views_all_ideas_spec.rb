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

      expect(page).to have_content(idea2.title)
      expect(page).to have_content(idea2.body)
      expect(page).to have_content(idea2.quality)

      expect(page).to have_content(idea3.title)
      expect(page).to have_content(idea3.body)
      expect(page).to have_content(idea3.quality)

    # end

    expect(page).to have_selector('h4', count: 3)
  end

  scenario "user sees most recent idea on top", js: true do
    idea = create(:idea)

    visit '/'
    wait_for_ajax

    within('#idea-' + idea.id.to_s) {expect(page).to have_content(idea.title)}
    within('#idea-' + idea.id.to_s) {expect(page).to have_content(idea.body)}

    new_idea = create(:idea)

    visit '/'
    wait_for_ajax

    within('#idea-' + new_idea.id.to_s) { expect(page).to have_content(new_idea.title) }
    within('#idea-' + new_idea.id.to_s) { expect(page).to have_content(new_idea.body) }
  end
end
