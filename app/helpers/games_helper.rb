module GamesHelper
  def win_lose_draw(user, game)
    if user.id == game.player_one_id
      player_score = game.player_one_score
      opponent_score = game.player_two_score
    else
      player_score = game.player_two_score
      opponent_score = game.player_one_score
    end

    if player_score > opponent_score
      "W"
    elsif player_score < opponent_score
      "L"
    else
      "D"
    end
  end

  def opponent(user, game)
    if user.id == game.player_one_id
      game.player_two.email
    else
      game.player_one.email
    end
  end
end
