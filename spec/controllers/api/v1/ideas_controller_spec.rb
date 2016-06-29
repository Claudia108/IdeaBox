require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do
  scenario "ideas#index" do
    create_list(:idea, 10)
    expect(Idea.count).to eq(10)

    get :index

    ideas = JSON.parse(response.body)

    expect(ideas.count).to eq(10)
  end
end
