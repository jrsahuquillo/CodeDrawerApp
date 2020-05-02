require "rails_helper"

RSpec.feature "Signin out users" do

  before do
    @user = User.create!(email: "example_user@example.com", username: "example_user", password: "password")
    visit "/"
    fill_in "Username or email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Sign up")
    expect(page).not_to have_content("Sign out")
  end
end
