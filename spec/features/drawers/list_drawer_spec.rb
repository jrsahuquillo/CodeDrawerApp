require "rails_helper"

RSpec.feature "Listing Drawers" do

  before do
    user1 = User.create(email: "example_user1@example.com", username: "example_user", password: "password")
    login_as(user1)
    @drawer1 = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user1)
    @drawer2 = Drawer.create(title: "The second drawer", description: "Description of second drawer", user: user1)
  end

  scenario "a user lists all drawers" do
    visit "/"

    expect(page).to have_content(@drawer1.title)
    # expect(page).to have_content(@drawer1.description)
    expect(page).to have_content(@drawer2.title)
    # expect(page).to have_content(@drawer2.description)
    expect(page).to have_link(@drawer1.title)
    expect(page).to have_link(@drawer2.title)
  end

  scenario "a user has no drawers" do
    Drawer.delete_all

    visit "/"

    expect(page).not_to have_content(@drawer1.title)
    expect(page).not_to have_content(@drawer1.description)
    expect(page).not_to have_content(@drawer2.title)
    expect(page).not_to have_content(@drawer2.description)
    expect(page).not_to have_link(@drawer1.title)
    expect(page).not_to have_link(@drawer2.title)

    within(".h1#no-drawers") do
      expect(page).to have_content("No drawers created")
    end
  end

  scenario "a user lists only all his drawers" do
    user2 = User.create(email: "example_user2@example.com", username: "example_user2", password: "password")
    @drawer3 = Drawer.create(title: "The third drawer", description: "Description of third drawer", user: user2)
    login_as(user2)
    visit "/"

    expect(page).to have_content(@drawer3.title)
    expect(page).to have_content(@drawer3.description)
    expect(page).to have_link(@drawer3.title)
    expect(page).to have_link(@drawer3.title)
    expect(page).not_to have_content(@drawer1.title)
    expect(page).not_to have_content(@drawer1.description)
    expect(page).not_to have_content(@drawer2.title)
    expect(page).not_to have_content(@drawer2.description)
  end


end
