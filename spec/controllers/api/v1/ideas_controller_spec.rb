require 'rails_helper'

RSpec.describe Api::V1::IdeasController, type: :controller do
  scenario "ideas#index" do
    create_list(:idea, 5)
    expect(Idea.count).to eq(5)

    get :index

    ideas = JSON.parse(response.body)

    expect(ideas.count).to eq(5)
  end

  scenario "idea#create" do
    expect(Idea.count).to eq(0)
    post :create, { idea: {
                    title: "Idea title",
                    body: "Idea body"
                  }}

    idea = JSON.parse(response.body)

    expect(Idea.count).to eq(1)
    expect(idea["title"]).to eq("Idea title")
    expect(idea["body"]).to eq("Idea body")

  end

  scenario "idea#update_content" do
    idea = create(:idea)

    patch :update, { id: idea.id, idea: {
                     title: "New Title",
                     body: "New Description"
                    }}
    new_content = JSON.parse(response.body)

    expect(new_content["title"]).to eq("New Title")
    expect(new_content["body"]).to eq("New Description")
    expect(new_content["id"]).to eq(idea.id)
  end

  scenario "idea#update_quality" do
    idea = create(:idea)

    patch :update, { id: idea.id, idea: { quality: 1 } }

    new_content = JSON.parse(response.body)
    expect(new_content["id"]).to eq(idea.id)
    expect(new_content["quality"]).to eq("plausible")
  end

  scenario "idea#delete" do
    idea = create(:idea)

    expect(Idea.count).to eq(1)

    delete :destroy, { id: idea.id }

    id = response.body

    expect(Idea.count).to eq(0)
    expect(id).to eq(idea.id.to_s)
  end
end
