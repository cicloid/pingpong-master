class AddRatingScoreToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rating, :integer, default: 1000
    add_column :users, :previous_rating, :integer, default: 1000
  end
end
