class SuppliesController < ApplicationController
  def index
    @title = "All Supplies:"
    @supplies = Supply.all
  end
end
