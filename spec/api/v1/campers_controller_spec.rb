require "rails_helper"

RSpec.describe Api::V1::CampersController, type: :controller do
  let!(:first_camper) { FactoryBot.create(:camper) }
  let!(:second_camper) { FactoryBot.create(:camper) }

  describe "GET#index" do
    it "returns a successful response with json data" do
      get :index

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it "returns all of the campers in the database" do
      # => [{"id"=>2, "name"=>"Ronette Pulaski", "campsite_id"=>2}]

      get :index
      response_body = JSON.parse(response.body)
      # binding.pry
      expect(response_body[0]["name"]).to eq first_camper.name
      expect(response_body[1]["name"]).to eq second_camper.name

      expect(response_body[1]["name"]).to eq second_camper.name


    end
  end
end
