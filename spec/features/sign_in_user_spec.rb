require "rails_helper"

RSpec.feature "Signin users" do

  before do
    @user = User.create!(username: "example_user", email: "example_user@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Username", with: @user.username
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@user.username}")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
    expect(page).to have_link("Sign out")
  end

end
