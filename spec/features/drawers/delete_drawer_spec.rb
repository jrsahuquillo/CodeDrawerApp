require "rails_helper"

RSpec.feature "Delete a Drawer" do

  before do
    user = User.create(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
  end

  scenario "A user deletes a drawer" do
    visit drawer_codetools_path(@drawer)
    click_link @drawer.title
    find('.delete-drawer-icon').click

    expect(page).to have_content("Drawer has been deleted")
  end
end
