require "rails_helper"

RSpec.feature "Searching Friends" do
  before do
    @user1 = User.create!(email: "example_user1@example.com", username: "example_user1", password: "password1")
    @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    login_as(@user1)
    visit '/'
    click_link "Friends"
    fill_in "Search Friends", with: "example_user2"
    find(:css, '.search-friends-button').click
  end

  xscenario "a user is followed by other and receives a 'following' notification" do
    login_as(@user2)
    visit '/'
    selector1 = find(:css, '.notifications-badge')
    expect(selector1).to have_content("1")

    selector2 = find(:css, '.notifications-list')
    expect(selector2).to have_content("#{@user1.username} is following you")
  end

end
