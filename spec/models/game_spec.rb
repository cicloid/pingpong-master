require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:player_one) { User.create!(email: 'playerone@me.com', password: '123123123') }
  let(:player_two) { User.create!(email: 'playertwo@me.com', password: '123123123') }

  context "with two players on the system" do
    it "should record a new game of 21-0" do
      game = Game.new(
        player_one: player_one,
        player_two: player_two,
        player_one_score: "21",
        player_two_score: "0",
        played_on: Date.today
      )
      expect(game).to be_valid
    end

    it "should raise an error when point difference less than 2 points" do
      game = Game.new(
        player_one: player_one,
        player_two: player_two,
        player_one_score: "21",
        player_two_score: "20",
        played_on: Date.today
      )
      expect(game).to be_invalid
    end
  end
end

