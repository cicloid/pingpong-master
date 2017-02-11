class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :games_as_player_one, class_name: 'Game',
    foreign_key: 'player_one_id'
  has_many :games_as_player_two, class_name: 'Game',
    foreign_key: 'player_two_id'


  def games
    Game.where('player_one_id = ? OR player_two_id = ?', self.id, self.id)
  end

  def k_factor
    # TODO: Naive way to do player tiers
    # Probably I would use something similar to the competitive Skill Ratings
    # of Overwatch. But since I have some time constraints and this is only a
    # toy implementation I would skip that and just take the number of games
    # as the source of the K-Factor.
    # Either way, the provided example doesn't take into account the
    # K-Factor and the effect that has on providing a more stable system and
    # ranking the users to their skill level.
    case games.count
    when 0...10
      32
    when 11...24
      24
    else
      16
    end
  end

  def update_rating!(new_rating)
    self.previous_rating = self.rating
    self.rating = new_rating
    self.save
  end

  def games_played
    games.count
  end

  def opponents
    User.where.not(id: self.id)
  end

end
