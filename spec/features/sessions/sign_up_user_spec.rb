require "rails_helper"

RSpec.feature "Signup users" do
  scenario "with valid credentials" do
    visit "/"
    find('.sign-up-link').click
    fill_in "Email", with: "user-example@example.com"
    fill_in "Username", with: "userexample"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")

  end

  scenario "with invalid credentials" do
    visit "/"
    find('.sign-up-link').click
    fill_in "Email", with: ""
    fill_in "Username", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("3 errors prohibited this user from being saved:")
  end

end
