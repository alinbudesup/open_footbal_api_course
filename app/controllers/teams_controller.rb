# frozen_string_literal: true
require 'csv'

class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy download_logo eee_logos]

  def index
    @teams = Team.all
    ImportTeamsJob.perform_later
    TeamMailer.send_report.deliver_later
  end

  def show
    head :not_found unless @team.present?
  end

  def download_logo
    # send_data(@team.logo.download, filename: 'logo.jpg')
    redirect_to rails_blob_url(@team.logo)
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      render :show, status: :created
    else
      handle_error(@team.errors)
    end
  end

  def update
    if @team.update(team_params)
      render :show
    else
      handle_error(@team.errors)
    end
  end

  def destroy
    if @team.destroy
      render :head
    else
      handle_error(@team.errors)
    end
  end

  def bulk
    file = CSV.read(csv_params[:csv].path)
    # puts item[0][0]
    CsvUtilsJob.perform_later(file)
  end

  def eee_logos
    @logos_arr = []
    @team.logos.each do |logo|
      @logos_arr << logo.variant(resize: '360x180')
      @logos_arr << logo.variant(resize: '640x640')
    end
     @logos_arr
  end

  private

  def permitted_params
    params.permit(:id)
  end

  def team_params
    params.require(:team).permit(:name, :abbreviation, :logos)
  end

  def csv_params
    params.permit(:csv)
  end

  def set_team
    @team = Team.find(permitted_params[:id])
  end
end
