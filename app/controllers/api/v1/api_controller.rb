class Api::V1::ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  # set up some functionality that only gets run for api controllers

end
