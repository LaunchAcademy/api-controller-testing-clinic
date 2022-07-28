class Api::V1::CampersController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    render json: Camper.all
  end

  def create
    camper = Camper.new(camper_params)

    if camper.save 
      render json: camper
    else 
      render json: { errors: camper.errors.full_messages.to_sentence }, status: 401
    end
  end

  private

  def camper_params
    params.require(:camper).permit(:name, :campsite_id)
  end
end