class Api::V1::CampersController < ApplicationController 
  def index
    render json: Camper.all
  end

  def create
    camper_data = JSON.parse(request.body.read)
    camper = Camper.new(camper_data)

    if camper.save
      render json: camper
    else 
      render json: { error: camper.errors }
    end
  end
end