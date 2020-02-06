require "rails_helper"

RSpec.feature "Editing Drawers" do

  before do
    user = User.create(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
    visit "/"
    click_link @drawer.title
  end

  scenario "A user updates a drawer" do
    find('.edit-drawer-icon').click
    fill_in "Title", with: "Updated Title"
    fill_in "Description", with: "Updated Description of Drawer"
    click_button "Update Drawer"

    expect(page).to have_content("Drawer has been updated")
    expect(page).to have_content("Updated Title")
    expect(page).to have_content("Updated Description of Drawer")
    expect(page.current_path).to eq(drawer_codetools_path(@drawer))
  end

  scenario "A user fails to update a drawer" do
    find('.edit-drawer-icon').click

    fill_in "Title", with: ""
    fill_in "Description", with: "Updated Description of Drawer"
    click_button "Update Drawer"

    expect(page).to have_content("Drawer has not been updated")
    expect(page.current_path).to eq(drawer_path(@drawer))
  end
end
