require "rails_helper"

RSpec.feature "Signup users" do
  scenario "with Github social login" do
    visit "/"
    find('a.github-oauth').click
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end
