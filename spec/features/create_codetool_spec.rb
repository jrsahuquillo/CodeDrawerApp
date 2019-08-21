require "rails_helper"

RSpec.feature "Creating Drawers" do
  before do
    @user = User.create!(email: "example_user@example.com", password: "password")
    login_as(@user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user)
  end

  scenario "a user creates a new codetool" do
    visit "/"
    click_link @drawer.title
    click_link "New Codetool"
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    click_button "Create Codetool"

    expect(Codetool.last.drawer).to eq(@drawer)
    expect(Codetool.last.user).to eq(@user)
    expect(page).to have_content("Codetool has been created")
    expect(page).to have_content(@drawer.codetools.last.title)
    expect(page).to have_content(@drawer.codetools.last.content)
    expect(page.current_path).to eq(drawer_path(@drawer.id))
  end
end
