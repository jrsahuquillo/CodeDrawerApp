require "rails_helper"

RSpec.feature "Creating Drawers" do
  scenario "a user creates a new drawer" do
    visit "/"
    click_link "New Drawer"
    fill_in "Title", with: "Creating a Drawer"
    fill_in "Description", with: "Lorem Ipsum"
    click_button "Create Drawer"

    expect(page).to have_content("Drawer has been created")
    expect(page.current_path).to eq(drawers_path)
  end

  scenario "a user fails to create a new drawer without title" do
    visit "/"
    click_link "New Drawer"
    fill_in "Title", with: ""
    fill_in "Description", with: "Lorem Ipsum"
    click_button "Create Drawer"

    expect(page).to have_content("Drawer has not been created")
    expect(page).to have_content("Title can't be blank")
  end

  scenario "a user creates a new drawer without description" do
    visit "/"
    click_link "New Drawer"
    fill_in "Title", with: "Creating a Drawer without description"
    fill_in "Description", with: ""
    click_button "Create Drawer"

    expect(page).to have_content("Drawer has been created")
  end

end
