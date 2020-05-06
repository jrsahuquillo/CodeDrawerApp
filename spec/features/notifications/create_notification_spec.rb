require "rails_helper"

RSpec.feature "Creates Notifications" do
  before do
    @user1 = User.create!(email: "example_user1@example.com", username: "example_user1", password: "password1")
    @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user1)

    login_as(@user1)
  end

  scenario "a user is followed by other" do
    visit '/search-friends'
    find('.follow-button').click
    login_as(@user2)
    visit '/'
    click_link 'Last notifications'

    expect(page).to have_content("#{@user1.username} #{Notification.last.action}")
  end

  scenario "a user creates a codetool in a collaborated drawer" do
    Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    DrawerCollaborator.create(drawer_id: @drawer.id, friend_id: @user2.id)
    visit "/"
    click_link @drawer.title
    click_link "New Codetool"
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    click_button "Create Codetool"

    login_as(@user2)
    visit '/'
    click_link 'Last notifications'

    expect(page).to have_content("#{@user1.username} #{Notification.last.action} #{Codetool.last.title}")
  end

  scenario "a user favorites other user codetool" do
    Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    Friendship.create(user_id: @user1.id, friend_id: @user2.id)
    codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user2, public: true)

    visit "/search-friends"
    click_link "#{@user2.username}"
    find('.favorite-button').click

    login_as(@user2)
    visit '/'
    click_link 'Last notifications'

    expect(page).to have_content("#{@user1.username} #{Notification.last.action} #{codetool.title}")
  end

  scenario "a user updates a collaborated drawer codetool" do
    Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    DrawerCollaborator.create(drawer_id: @drawer.id, friend_id: @user2.id)
    visit "/"
    click_link @drawer.title
    click_link "New Codetool"
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    click_button "Create Codetool"

    click_link "Edit Codetool"
    fill_in "Title", with: "Updated Title"
    click_button "Update Codetool"

    login_as(@user2)
    visit '/'
    click_link 'Last notifications'

    expect(page).to have_content("#{@user1.username} #{Notification.last.action} #{Codetool.last.title}")
  end

  scenario "notifications are deleted when clicks Clear button" do
    visit '/search-friends'
    find('.follow-button').click
    login_as(@user2)
    visit '/'
    click_link 'Last notifications'
    click_link 'Clear'

    expect(Notification.all).to eq([])
  end

end
