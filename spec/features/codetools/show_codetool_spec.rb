require "rails_helper"

RSpec.feature "Showing a Codetool" do
  before do
    @user = User.create(email: "example_user@example.com", username: "example_user", password: "password")
    login_as(@user)
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of codetool", drawer: @drawer, user: @user, public: true)
  end

  scenario "a user shows a codetool that belongs a drawer" do
    visit "/"
    click_link @drawer.title

    expect(page).to have_content(@codetool.title)
    expect(page).to have_content(@codetool.content)
    expect(current_path).to eq(drawer_codetools_path(@drawer))
  end

  scenario "a user shows detail of a codetool that belongs a drawer" do
    visit "/"
    click_link @drawer.title
    find(:css, '.detail-codetool-icon').click

    expect(page).to have_content(@codetool.title)
    expect(page).to have_content(@codetool.content)
    expect(current_path).to eq(drawer_codetool_path(@drawer, @codetool))
  end

  scenario "a user can't shows detail of a not public codetool" do
    user2 = User.create(email: "example_user2@example.com", username: "example_user2", password: "password")
    drawer2 = Drawer.create(title: "The second drawer", description: "Description of second drawer", user: user2)
    codetool2 = Codetool.create(title: "The second codetool", content: "Content of second codetool", drawer: drawer2, user: user2, public: false)

    visit "/drawers/#{drawer2.to_param}/codetools/#{codetool2.to_param}"

    expect(page).not_to have_content(codetool2.title)
    expect(page).not_to have_content(codetool2.content)
    expect(page).to have_content("This Codetool is not public. Ask #{user2.username} to make it public to show it")
    expect(current_path).to eq(drawer_codetool_path(drawer2, codetool2))
  end

  scenario "a user can show detail of a not public codetool of a drawer collaborated by him" do
    user3 = User.create(email: "example_user3@example.com", username: "example_user3", password: "password")
    drawer3 = Drawer.create(title: "The third drawer", description: "Description of third drawer", user: user3)
    codetool3 = Codetool.create(title: "The third codetool", content: "Content of third codetool", drawer: drawer3, user: user3, public: false)
    Friendship.create(user_id: user3.id, friend_id: @user.id)
    DrawerCollaborator.create(drawer_id: drawer3.id, friend_id: @user.id)

    visit "/drawers/#{drawer3.to_param}/codetools/#{codetool3.to_param}"

    expect(page).to have_content(codetool3.title)
    expect(page).to have_content(codetool3.content)
    expect(current_path).to eq(drawer_codetool_path(drawer3, codetool3))
  end

end
