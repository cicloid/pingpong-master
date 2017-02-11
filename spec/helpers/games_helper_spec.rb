require 'rails_helper'

RSpec.describe GamesHelper, type: :helper do
  let(:player_one) { User.create!(email: 'playerone@me.com', password: '123123123') }
  let(:player_two) { User.create!(email: 'playertwo@me.com', password: '123123123') }
  let(:game) {
    Game.new(
      player_one: player_one,
      player_two: player_two,
      player_one_score: "21",
      player_two_score: "0",
      played_on: Date.today
    )

  }

  describe "Output of win lose draw given a PvP draw" do

    it "outputs W when first player wins" do
      expect(helper.win_lose_draw(player_one, game)).to eq("W")
    end

    it "outputs L when asking for the second player" do
      expect(helper.win_lose_draw(player_two, game)).to eq("L")
    end

    it "outputs D when there is a draw" do
      draw_game = Game.new(
        player_one: player_one,
        player_two: player_two,
        player_one_score: "21",
        player_two_score: "21",
        played_on: Date.today
      )
      expect(helper.win_lose_draw(player_two, draw_game)).to eq("D")
    end
  end

  describe "Outputs opponent email" do
    it "when player two is the opponent" do
      expect(helper.opponent(player_one, game)).to eq("playertwo@me.com")
    end
    it "when player one is the opponent" do
      expect(helper.opponent(player_two, game)).to eq("playerone@me.com")
    end
  end
end
