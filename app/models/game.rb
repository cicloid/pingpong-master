class Game < ApplicationRecord
  belongs_to :player_one, class_name: 'User', foreign_key: 'player_one_id'
  belongs_to :player_two, class_name: 'User', foreign_key: 'player_two_id'

  validates :player_one_score,
    numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 21
  }, presence: true

  validates :player_two_score,
    numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 21
  }, presence: true

  validate :valid_point_lead_for_win

  def rating_one
    rating_for_player(
      result: game_result,
      old_rating: player_one.rating,
      opponent_rating: player_two.rating,
      k_factor: player_one.k_factor
    )
  end

  def rating_two
    rating_for_player(
      result: (1.0 - game_result),
      old_rating: player_two.rating,
      opponent_rating: player_one.rating,
      k_factor: player_two.k_factor
    )
  end

  # Based on Elo Rating System... thanks to all those hours playing Destiny I
  # alredy knew about this one.
  #
  # http://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details
  def rating_for_player(result: nil, old_rating: 1000,
                        opponent_rating: 1000, k_factor: 32)
    (old_rating.to_f + (k_factor.to_f * (
        result.to_f - expected_rating(
          opponent_rating, old_rating
        )
      )).to_i
    )
  end

  # Based on Elo Rating System... thanks to all those hours playing Destiny I
  # alredy knew about this one.
  #
  # http://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details
  def expected_rating(other, old)
    1.0 / ( 1.0 + ( 10.0 ** ((other.to_f - old.to_f) / 400.0) ) )
  end


  def game_result
    if player_one_score > player_two_score
      1.0
    elsif player_one_score == player_two_score
      0.5
    else
      0
    end
  end

  private

  # TODO: Intent should be clear on this one. probable a less convuluted way
  # to do this exists
  def valid_point_lead_for_win
    return unless self.player_one_score && self.player_two_score
    scores = [self.player_one_score, self.player_two_score].sort
    difference = scores[1] - scores[0]
    if difference < 2 && difference > 0
      errors.add(:base, "Point difference should be of at least two points")
    end
  end

end
