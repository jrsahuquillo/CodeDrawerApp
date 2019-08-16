require "rails_helper"

RSpec.feature "Listing Drawers" do

  before do
      @drawer1 = Drawer.create(title: "The first drawer", description: "Description of first drawer")
      @drawer2 = Drawer.create(title: "The second drawer", description: "Description of second drawer")
  end

  scenario "a user creates a new drawer" do
    visit "/"

    expect(page).to have_content(@drawer1.title)
    expect(page).to have_content(@drawer1.description)
    expect(page).to have_content(@drawer2.title)
    expect(page).to have_content(@drawer2.description)
    expect(page).to have_link(@drawer1.title)
    expect(page).to have_link(@drawer1.title)
  end

end
