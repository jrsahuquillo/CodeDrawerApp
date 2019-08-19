require "rails_helper"

RSpec.feature "Delete a Drawer" do

  before do
    user = User.create(email: "example_user@example.com", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
  end

  scenario "A user deletes a drawer" do
    visit "/"
    click_link @drawer.title
    click_link "Delete"

    expect(page).to have_content("Drawer has been deleted")
    expect(page.current_path).to eq(drawers_path)
  end
end
