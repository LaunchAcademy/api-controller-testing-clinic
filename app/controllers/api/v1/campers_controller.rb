class Api::V1::CampersController < ApplicationController
  def index
    render json: Camper.all
  end

  def create
    # binding.pry
    new_camper = Camper.new(camper_params)

    if new_camper.save
      render json: new_camper
    else
      render json: { errors: new_camper.errors.full_messages }
    end
  end

  private

  def camper_params
    params.require(:camper).permit(:name, :campsite_id)
  end
end