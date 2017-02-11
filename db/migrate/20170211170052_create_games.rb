class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.date :played_on
      t.integer :player_one_score
      t.integer :player_two_score
      t.integer :player_one_id
      t.integer :player_two_id
      t.timestamps
    end
    add_index :games, :player_one_id
    add_index :games, :player_two_id
    add_foreign_key :games, :users, column: :player_one_id
    add_foreign_key :games, :users, column: :player_two_id
  end
end
