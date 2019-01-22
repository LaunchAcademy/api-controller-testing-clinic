class CampersController < ApplicationController

  def index
    @title = "All Campers:"
    @campers = Camper.all
  end
end
