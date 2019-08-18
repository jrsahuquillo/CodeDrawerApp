require "rails_helper"

RSpec.feature "Delete a Drawer" do

  before do
      @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer")
  end

  scenario "A user deletes a drawer" do
    visit "/"
    click_link @drawer.title
    click_link "Delete"

    expect(page).to have_content("Drawer has been deleted")
    expect(page.current_path).to eq(drawers_path)
  end
end
