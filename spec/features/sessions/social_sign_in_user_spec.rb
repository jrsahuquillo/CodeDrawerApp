require "rails_helper"

RSpec.feature "Sign in users" do
  scenario "with Github social login who singned up with social login previously" do
    visit "/"
    find('.oauth-btn .btn-github').click
    click_link "Sign out"

    visit "/"
    find('.oauth-btn .btn-github').click
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "with Github social login who singned up with password login previously" do
    User.create!(email: "codedrawerapp@mail.com", username: "codedrawerapp", password: "password")

    visit "/"
    find('.oauth-btn .btn-github').click
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "with password login who singned up with Github social login previously can´t login" do
    visit "/"
    find('.oauth-btn .btn-github').click
    click_link "Sign out"

    visit "/"
    fill_in "Username or email", with: "codedrawerapp@mail.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content("Invalid Username or email or password.")
  end
end
