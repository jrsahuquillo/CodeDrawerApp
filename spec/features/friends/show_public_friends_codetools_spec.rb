require "rails_helper"

RSpec.feature "Show public friends codetools" do
  before do
    @user1 = User.create(email: "example_user1@example.com", username: "example_user1", password: "password")
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user1)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user1, public: true)
    @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    login_as(@user2)
  end

  scenario "a user shows a friend public codetools" do
    visit '/friends'
    expect(page).to have_content(@codetool.title)
  end

  scenario "friendship icon is displayed" do
    login_as(@user1)
    visit '/search-friends'
    expect(page).to have_css(".octicon-organization")
    expect(page).to have_content("Follow back")
  end

  scenario "a user shows friend public codetools by friend" do
    visit '/search-friends'
    click_link @user1.username
    expect(page).to have_content(@codetool.title)
  end
end
