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
