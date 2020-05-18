require "rails_helper"

RSpec.feature "Delete a Codetool" do

  before do
    user = User.create(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: user)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: user)
  end

  scenario "A user deletes a codetool" do
    visit "/"
    click_link @drawer.title
    find('.show-codetool').click
    click_link "Edit Codetool"
    click_link "Delete Codetool"

    expect(page).to have_content("Codetool has been deleted")
    expect(page.current_path).to eq(drawer_codetools_path(@drawer))
  end
end
