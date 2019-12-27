require "rails_helper"

RSpec.feature "Searching Friends" do
  before do
    user1 = User.create!(email: "example_user1@example.com", username: "example_user1", password: "password1")
    @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    login_as(user1)
    visit '/'
    click_link "Search Friends"
  end

  scenario "a user follows other user searched by user name" do
    fill_in "Search Friends", with: "example_user2"
    find(:css, '.search-friends').click
    expect(page).to have_content(@user2.username)

    click_link "Follow"

    expect(page).to have_content(@user2.username)
    expect(page).to have_content("Unfollow")

  end

  scenario "a user folloss other user searched by user email" do
    fill_in "Search Friends", with: "example_user2@example.com"
    find(:css, '.search-friends').click
    expect(page).to have_content(@user2.username)

    click_link "Follow"

    expect(page).to have_content(@user2.username)
    expect(page).to have_content("Unfollow")
  end
end
