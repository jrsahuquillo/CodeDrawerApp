require "rails_helper"

RSpec.feature "Showing a Drawer" do

  before do
    user = User.create(email: "example_user@example.com", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
  end

  scenario "a user shows a drawer" do
    visit "/"
    click_link @drawer.title

    expect(page).to have_content(@drawer.title)
    expect(page).to have_content(@drawer.description)
    expect(current_path).to eq(drawer_path(@drawer))
  end

end
