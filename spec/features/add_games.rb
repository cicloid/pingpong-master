require 'rails_helper'

RSpec.feature "Add new games", type: :feature do
  it "adds a new game and shows it on the user history" do
    login_as user: "who@knows.com", password: "123123123"
    click_link "Log Game"
    fill_in "Your Score", with: "21"
    fill_in "Their Score", with: "19"
    click_on "Save"
    expect(page).to have_text("Game was succesfully created.")
  end

  def login_as(user: nil, password: nil)
    visit "/users/sign_up"
    fill_in "Email", with: user
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Sign up"
  end

end
