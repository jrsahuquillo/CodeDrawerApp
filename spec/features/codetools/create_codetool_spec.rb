require "rails_helper"

RSpec.feature "Creating Codetools" do
  before do
    @user = User.create!(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(@user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user)
    visit "/"
    click_link @drawer.title
    click_link "New Codetool"
  end

  scenario "a user creates a new codetool" do
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    click_button "Create Codetool"

    expect(Codetool.last.drawer).to eq(@drawer)
    expect(Codetool.last.user).to eq(@user)
    expect(Codetool.last.position).to eq(0)
    expect(Codetool.last.public).to eq(false)
    expect(page).to have_content("Codetool has been created")
    expect(page).to have_content(@drawer.codetools.last.title)
    expect(page).to have_content(@drawer.codetools.last.content)
    expect(page.current_path).to eq(drawer_codetools_path(@drawer.id))
  end

  scenario "a user creates a new codetool without content" do
    fill_in "Title", with: "Creating a Codetool with Markdown"
    click_button "Create Codetool"
      expect(page).to have_content(@drawer.codetools.last.title)
  end

  scenario "a user creates a new codetool with bold markdown" do
    fill_in "Title", with: "Creating a Codetool with Markdown"
    fill_in "Content", with: "**Lorem Ipsum**"
    click_button "Create Codetool"
    expect(page.html).to include("<strong>Lorem Ipsum</strong>")
  end

  scenario "a user creates a new codetool with code markdown" do
    fill_in "Title", with: "Creating a Codetool with Markdown"
    fill_in "Content", with: "`Lorem Ipsum`"
    click_button "Create Codetool"
    expect(page.html).to include("<code>Lorem Ipsum</code>")
  end

  scenario "a user creates a new codetool with checkbox markdown" do
    fill_in "Title", with: "Creating a Codetool with Checkbox Markdown"
    fill_in "Content", with: "- [x] Lorem Ipsum"
    click_button "Create Codetool"
    expect(page).to have_css("input[type='checkbox']")
  end

  scenario "a user creates a new public codetool" do
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    find('#public_checkbox').set(true)
    click_button "Create Codetool"
    expect(Codetool.last.public).to eq(true)
  end

end
