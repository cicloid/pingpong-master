require 'rails_helper'

RSpec.feature "Leaderboard", type: :feature do
  let!(:player_one) { User.create!(email: 'playerone@me.com', password: '123123123') }
  let!(:player_two) { User.create!(email: 'playertwo@me.com', password: '123123123') }

  it "adds a new game and shows it on the user history" do

    login_as user: player_one.email, password: "123123123"
    click_link "Log Game"
    fill_in "Your Score", with: "21"
    fill_in "Their Score", with: "19"
    select player_two.email, from: "game_player_two_id"
    click_on "Save"
    click_on "Leaderboard"
    expect(page).to have_text("985")
    expect(page).to have_text("1016")
  end

  def login_as(user: nil, password: nil)
    visit "/users/sign_in"
    fill_in "Email", with: user
    fill_in "Password", with: password
    click_button "Sign in"
  end

end
