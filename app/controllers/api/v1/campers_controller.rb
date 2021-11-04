class Api::V1::CampersController < ApplicationController
  def index
    campers = Camper.all
    render json: campers
  end

  def create
    # binding.pry
    camper = Camper.new(camper_params)
    if camper.save
      render json: camper
    else
      render json: { errors: camper.errors.full_messages.to_sentence }
    end
  end

  private

  def camper_params
    params.require(:camper).permit(:name, :campsite_id)
  end
end