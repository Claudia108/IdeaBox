require 'rails_helper'

feature "user deletes idea", :js => true do
  scenario "they no longer see the idea on the page" do
    create_list(:idea, 3)
    idea = Idea.first

    visit '/'

    within("li:first-child") {
      expect(page).to have_content(idea.title)
      expect(page).to have_content(idea.body)

      find(".delete-idea").click
      wait_for_ajax
      expect(page).not_to have_content(idea.title)
      expect(page).not_to have_content(idea.body)
    }
  end
end
