require "rails_helper"

RSpec.feature "Showing a Drawer" do
  before do
    user = User.create(email: "example_user@example.com", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of codetool", drawer: @drawer, user: user)
  end

  scenario "a user shows a codetool that belongs a drawer" do
    visit "/"
    click_link @drawer.title

    within("#showCodetool" + "#{@codetool.id}") do
      expect(page).to have_content(@codetool.title) # async
    end

    expect(page).to have_content(@codetool.title)
    expect(page).to have_content(@codetool.content)
    expect(current_path).to eq(drawer_path(@drawer)) # Modal
  end
end
