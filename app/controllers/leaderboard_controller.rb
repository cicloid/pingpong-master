class LeaderboardController < ApplicationController
  def index
    @users = User.all.order(rating: :desc)
  end
end
