require 'rails_helper'

RSpec.describe User, type: :model do
  context "with two players on the system" do
    it "has a K-Factor of 32" do
      player_one = User.new
      expect(player_one.k_factor).to eq(32)
    end

    it "with 13 games on the system" do
      player_one = User.create!(email: "who@knows.com",
                                password: "123123123")
      player_two = User.create!(email: "who_else@knows.com",
                                password: "123123123")

      12.times do
        save_a_game_for player_one, player_two
      end
      expect(player_one.k_factor).to eq(24)
    end

    it "with 33 games on the system" do
      player_one = User.create!(email: "who@knows.com",
                                password: "123123123")
      player_two = User.create!(email: "who_else@knows.com",
                                password: "123123123")

      33.times do
        save_a_game_for player_one, player_two
      end
      expect(player_one.k_factor).to eq(16)
    end

  end

  def save_a_game_for(player, opponent)
    return Game.create!(
      player_one: player,
      player_two: opponent,
      player_one_score: "21",
      player_two_score: "0",
      played_on: Date.today
    )

  end
end

