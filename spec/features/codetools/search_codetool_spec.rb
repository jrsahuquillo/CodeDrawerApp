require "rails_helper"

RSpec.feature "Searching Codetools" do
  before do
    @user = User.create!(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(@user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user)
    @codetool1 = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user)
    @codetool2 = Codetool.create(title: "The second codetool", content: "Content of second codetool", drawer: @drawer, user: @user)
  end

  scenario "a user searches a specific codetool title" do
    visit '/search'
    fill_in "Search (CRTL + F)", with: "first"
    find(:css, 'button.global-search').click

    expect(page).to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page.current_path).to eq(search_path)
    expect(page).not_to have_css('.drawer-search')
  end

  scenario "a user searches a specific codetool content" do
    visit '/search'
    fill_in "Search (CRTL + F)", with: "First coDEtool"
    find(:css, 'button.global-search').click

    expect(page).to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page.current_path).to eq(search_path)
    expect(page).not_to have_css('.drawer-search')
  end

  scenario "a user searches empty content" do
    visit '/search'
    fill_in "Search (CRTL + F)", with: ""
    find(:css, 'button.global-search').click

    expect(page).to have_content("There are no codetools containing the term(s) .")
    expect(page.current_path).to eq(search_path)
  end

  scenario "a not logged user can't access to search page" do
    logout
    visit '/search'
    expect(page.current_path).to eq(new_user_session_path)
    expect(page).not_to have_css('button.search')
  end

  scenario "a user searches in a drawer scope" do
    visit '/'
    click_link @drawer.title
    fill_in "Search (CRTL + F)", with: "first"
    find(:css, '.drawer-search').click

    expect(page).to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page.current_path).to eq(search_path)
  end

  scenario "a user searches a drawer codetool in other drawer scope" do
    @drawer2 = Drawer.create(title: "The second drawer", description: "Description of second drawer", user: @user)
    # @codetool3 = Codetool.create(title: "The third codetool", content: "Content of third codetool", drawer: @drawer2, user: @user)
    visit '/'
    click_link @drawer2.title
    fill_in "Search (CRTL + F)", with: "first"
    find(:css, '.drawer-search').click

    expect(page).not_to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
    expect(page).to have_css('.drawer-search')
    expect(page.current_path).to eq(search_path)
  end

  scenario "a user can't search in drawer scope in favorite codetools page" do
    visit '/favorite_codetools'
    expect(page).not_to have_css('.drawer-search')
  end

    scenario "a user can't search in drawer scope in pin codetools page" do
    visit '/pin_codetools'
    expect(page).not_to have_css('.drawer-search')
  end
end
