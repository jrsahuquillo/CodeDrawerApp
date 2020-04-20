require "rails_helper"

RSpec.feature "Pin a codetool" do
  before do
    @user1 = User.create(email: "example_user1@example.com", username: "example_user1", password: "password")
    @drawer = Drawer.create(title: "The first drawer", description: "Description of first drawer", user: @user1)
    @codetool1 = Codetool.create(title: "The first codetool", content: "Content of first codetool", drawer: @drawer, user: @user1, public: true)
    PinCodetool.create(user_id: @user1.id, codetool_id: @codetool1.id)
    @codetool2 = Codetool.create(title: "The second codetool", content: "Content of second codetool", drawer: @drawer, user: @user1, public: true)
    PinCodetool.create(user_id: @user1.id, codetool_id: @codetool2.id)
    login_as(@user1)

    visit '/pin_codetools'
  end

  scenario "a user pins a codetool and it is displayed in the Word Board" do
    expect(page).to have_content(@codetool1.title)
    expect(page).to have_content(@codetool2.title)
  end

  scenario "pinned codetool are cleared" do
    find('.clear-pinned-codetools').click

    expect(page).not_to have_content(@codetool1.title)
    expect(page).not_to have_content(@codetool2.title)
  end

end
