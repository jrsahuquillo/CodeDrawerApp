require "rails_helper"

RSpec.feature "Creating Cases" do
  scenario "a user creates a new case" do
    visit "/"
    click_link "New Case"
    fill_in "Title", with: "Creating a Case"
    fill_in "Description", with: "Lorem Ipsum"
    click_button "Create Case"

    expect(page).to have_content("Case has been created")
    expect(page.current_path).to eq(cases_path)
  end
end
