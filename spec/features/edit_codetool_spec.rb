require "rails_helper"

RSpec.feature "Editing Codetools" do

  before do
      user = User.create(email: "example_user@example.com", username: "example_user", password: "password")
      login_as(user)
      @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
      @codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: user)
  end

  scenario "A user updates a codetool" do
    visit "/"
    click_link @drawer.title
    find('.show-codetool').click
    click_link "Edit Codetool"

    fill_in "Title", with: "Updated Title"
    fill_in "Content", with: "Updated Content of Codetool"
    click_button "Update Codetool"

    expect(page).to have_content("Codetool has been updated")
    expect(page).to have_content("Updated Title")
    expect(page).to have_content("Updated Content of Codetool")
    expect(page.current_path).to eq(drawer_codetools_path(@drawer))
  end

end
