require "rails_helper"

RSpec.feature "Searching Codetools" do
  before do
    user = User.create!(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user)
    @codetool1 = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: user)
    @codetool2 = Codetool.create(title: "The second codetool", content: "Content of second codetool", drawer: @drawer, user: user)
  end

  scenario "a user searches a specific codetool title" do
    visit '/search'
    fill_in "Search", with: "first"
    find(:css, '.search').click

    expect(page).to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page.current_path).to eq(search_path)
  end

  scenario "a user searches a specific codetool content" do
    visit '/search'
    fill_in "Search", with: "First coDEtool"
    find(:css, 'button.search').click

    expect(page).to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page.current_path).to eq(search_path)
  end

  scenario "a not logged user can't access to search page" do
    logout
    visit '/search'
    expect(page.current_path).to eq(new_user_session_path)
    expect(page).not_to have_css('button.search')
  end
end
