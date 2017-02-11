class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :games_as_player_one, class_name: 'Game', foreign_key: 'player_one_id'
  has_many :games_as_player_two, class_name: 'Game', foreign_key: 'player_two_id'


  def games
    Game.where('player_one_id = ? OR player_two_id = ?', self.id, self.id)
  end


  def games_played
    games.count
  end

end
