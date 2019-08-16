require "rails_helper"

RSpec.feature "Listing Drawers" do

  before do
      @drawer1 = Drawer.create(title: "The first drawer", description: "Description of first drawer")
      @drawer2 = Drawer.create(title: "The second drawer", description: "Description of second drawer")
  end

  scenario "a user lists all drawers" do
    visit "/"

    expect(page).to have_content(@drawer1.title)
    expect(page).to have_content(@drawer1.description)
    expect(page).to have_content(@drawer2.title)
    expect(page).to have_content(@drawer2.description)
    expect(page).to have_link(@drawer1.title)
    expect(page).to have_link(@drawer1.title)
  end

  scenario "a user has no drawers" do
    Drawer.delete_all

    visit "/"

    expect(page).not_to have_content(@drawer1.title)
    expect(page).not_to have_content(@drawer1.description)
    expect(page).not_to have_content(@drawer2.title)
    expect(page).not_to have_content(@drawer2.description)
    expect(page).not_to have_link(@drawer1.title)
    expect(page).not_to have_link(@drawer1.title)

    within("h1#no-drawers") do
      expect(page).to have_content("No drawers created")
    end
  end

end
