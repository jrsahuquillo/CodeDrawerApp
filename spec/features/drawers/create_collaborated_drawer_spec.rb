require "rails_helper"

RSpec.feature "Creating collaborated drawer" do
  before do
    @user1 = User.create(email: "example_user1@example.com", username: "example_user1", password: "password")
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user1)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user1, public: false)
    @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    DrawerCollaborator.create(drawer_id: @drawer.id, friend_id: @user2.id)
  end

  scenario "user who creates drawer displays drawer collaborator username" do
    login_as(@user1)
    visit '/'
    expect(page).to have_content(@user2.username)
  end

  scenario "user who collaborates drawer displays drawer title and creator username" do
    login_as(@user2)
    visit drawer_codetools_path(@drawer)
    expect(page).to have_content(@user1.username)
    expect(page).to have_content(@drawer.title)
    expect(page).to have_content(@codetool.title)
  end

  scenario "user who collaborates can not edit or delete collaborated drawer" do
    login_as(@user2)
    visit drawer_codetools_path(@drawer)
    expect(page).not_to have_css('.edit-drawer-icon')
    expect(page).not_to have_css('.delete-drawer-icon')
  end

  scenario "user who collaborates can create new codetool" do
    login_as(@user2)
    visit '/'
    click_link @drawer.title
    click_link "New Codetool"
    fill_in "Title", with: "Creating a Codetool"
    fill_in "Content", with: "Lorem Ipsum"
    click_button "Create Codetool"

    expect(Codetool.last.drawer).to eq(@drawer)
    expect(Codetool.last.user).to eq(@user2)
    expect(Codetool.last.public).to eq(false)
    expect(page).to have_content("Codetool has been created")
    expect(page).to have_content(@drawer.codetools.last.title)
    expect(page).to have_content(@drawer.codetools.last.content)
    expect(page.current_path).to eq(drawer_codetools_path(@drawer.id))
  end

  scenario "user who collaborates can edit but not delete other users codetools in collaborated drawer" do
    login_as(@user2)
    visit '/'
    click_link @drawer.title
    click_link @codetool.title

    expect(page).not_to have_css('.delete-codetool-icon')
    expect(page).to have_css('.edit-codetool-icon')

    click_link "Edit Codetool"
    expect(page).to have_content("Editing: #{@drawer.title} #{@drawer.user.username} / #{@codetool.title} #{@codetool.user.username}")

    fill_in "Title", with: "Changing a Codetool"
    fill_in "Content", with: "Lorem Ipsum changed"
    click_button "Update Codetool"

    expect(page).to have_content("Changing a Codetool")
    expect(page).to have_content("Lorem Ipsum changed")
  end


end
