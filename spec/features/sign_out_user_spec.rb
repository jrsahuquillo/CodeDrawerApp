require "rails_helper"

RSpec.feature "Signin out users" do

  before do
    @user = User.create!(email: "example_user@example.com", password: "password")
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @user.email
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
