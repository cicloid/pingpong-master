class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = current_user.games
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    @game.player_one_id = current_user.id

    if @game.save
      # TODO: Player rating recalculation: Not sure if this the right place for
      # this. Somehow it feels wrong having it here.
      update_ratings_for_players(@game)

      redirect_to games_url, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:played_on, :player_two_id,
                                   :player_one_score, :player_two_score)
    end

    def update_ratings_for_players(game)
      game.player_one.update_rating!(game.rating_one)
      game.player_two.update_rating!(game.rating_two)
    end
end
