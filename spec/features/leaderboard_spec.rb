require 'rails_helper'

RSpec.feature "Leaderboard", type: :feature do
  let(:player_one) { User.create!(email: 'playerone@me.com', password: '123123123') }
  let(:player_two) { User.create!(email: 'playertwo@me.com', password: '123123123') }

  let(:player_one_with_one_win) { User.create!(email: 'playerone@me.com', 
                                               password: '123123123',
                                               rating: 1016) }
  let(:player_two_with_one_loss) { User.create!(email: 'playertwo@me.com', 
                                                 password: '123123123',
                                                 rating: 985) }

  it "adds a new game and shows it on the user history" do
    opponent = player_two
    player = player_one

    login_as user: player.email, password: "123123123"
    click_link "Log Game"
    fill_in "Your Score", with: "21"
    fill_in "Their Score", with: "19"
    select opponent.email, from: "game_player_two_id"
    click_on "Save"
    click_on "Leaderboard"

    expect(page).to have_text("985")
    expect(page).to have_text("1016")
  end


  it "lose a game and get a lower rating" do
    opponent = player_two_with_one_loss
    player = player_one_with_one_win

    login_as user: player.email, password: "123123123"
    click_link "Log Game"

    fill_in "Your Score", with: "18"
    fill_in "Their Score", with: "21"
    select opponent.email, from: "game_player_two_id"
    click_on "Save"
    click_on "Leaderboard"

    expect(page).to have_text("1001")
    expect(page).to have_text("999")
  end

  it "draw a game no change in score" do
    opponent = player_two
    player = player_one

    login_as user: player.email, password: "123123123"
    click_link "Log Game"
    fill_in "Your Score", with: "21"
    fill_in "Their Score", with: "21"
    select opponent.email, from: "game_player_two_id"
    click_on "Save"
    click_on "Leaderboard"

    expect(page).to have_text("1000")
    expect(page).to have_text("1000")
  end

  def login_as(user: nil, password: nil)
    visit "/users/sign_in"
    fill_in "Email", with: user
    fill_in "Password", with: password
    click_button "Sign in"
  end

end
