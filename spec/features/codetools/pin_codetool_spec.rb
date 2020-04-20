require "rails_helper"

RSpec.feature "Pin a codetool" do
  before do
    @user1 = User.create(email: "example_user1@example.com", username: "example_user1", password: "password")
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user1)
    @codetool = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user1, public: true)
    # @user2 = User.create!(email: "example_user2@example.com", username: "example_user2", password: "password2")
    # Friendship.create(user_id: @user2.id, friend_id: @user1.id)
    login_as(@user1)
  end

  scenario "a user pins a codetool and it is displayed in the Word Board" do
    PinCodetool.create(user_id: @user1.id, codetool_id: @codetool.id)
    visit '/pin_codetools'
    expect(page).to have_content(@codetool.title)
  end

  # scenario "a user unfavorites a friend public codetool" do
  #   FavoriteCodetool.create(user_id: @user2.id, codetool_id: @codetool.id)
  #   # visit "/search-friends"
  #   # click_link @user1.username
  #   # click_link @codetool.title
  #   # find('.destroy-favorite').click
  #   FavoriteCodetool.where(user_id: @user2.id, codetool_id: @codetool.id).destroy_all
  #   expect(FavoriteCodetool.all.count).to eq(0)
  # end

  # scenario "a user displays list of favorited codetools" do
  #   FavoriteCodetool.create(user_id: @user2.id, codetool_id: @codetool.id)
  #   visit "/favorite_codetools"
  #   expect(page).to have_content(@codetool.title)
  # end

end
