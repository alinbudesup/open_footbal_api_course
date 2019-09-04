class PlayersController < ApplicationController

  before_action :set_player, only: %i[show update]

  def index
    # ImportTeamsJob.perform_later
    @player = Player.all
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render :show, status: :created
    else
      handle_error(@player.errors)
    end
  end

  def update
    if @player.update(player_params)
      render :show, status: :created
    else
      handle_error(@player.errors)
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :age, :team_id)
  end

  def set_player
    @player = Player.find(params[:id])
  end
end
