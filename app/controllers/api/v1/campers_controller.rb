class Api::V1::CampersController < ApplicationController
  def index
    render json: Camper.all
  end

  def create
    camper = Camper.new(camper_params)

    if camper.save
      render json: camper
    else
      render json: { errors: camper.errors.full_messages }
    end
  end

  private

  def camper_params
    params.require(:camper).permit(:name, :campsite_id)
  end
end
