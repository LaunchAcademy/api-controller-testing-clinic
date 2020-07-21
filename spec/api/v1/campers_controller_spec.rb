require 'rails_helper'

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#Index" do
    let!(:camper1) {FactoryBot.create(:camper)}
    let!(:camper2) {FactoryBot.create(:camper)}

    it "returns a status of 200" do
      get :index
      
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it "returns all the campers in the database" do
      get :index

      returned_json = JSON.parse(response.body)
      # binding.pry

      expect(returned_json[0]["name"]).to eq(camper1.name)
      expect(returned_json[0]["campsite_id"]).to eq(camper1.campsite_id)

      expect(returned_json[1]["name"]).to eq(camper2.name)
      expect(returned_json[1]["campsite_id"]).to eq(camper2.campsite_id)
    end
  end

  describe "POST#Create" do
    let!(:camper_data) { {camper: {name: "Bob", campsite_id: 1}} }
    let!(:bad_camper_data) { {camper: {campsite_id: 1}} }

    context "when a request with the correct params is made" do
      it "adds a new camper to the database" do
        previous_count = Camper.count

        post :create, params: camper_data
        new_count = Camper.count

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"

        expect(new_count).to eq(previous_count + 1)
      end
  
      it "returns the newley added camper as a json object" do
        post :create, params: camper_data

        returned_json = JSON.parse(response.body)
        # binding.pry

        expect(returned_json["name"]).to eq("Bob")
        expect(returned_json["campsite_id"]).to eq(1)
      end  
    end

    context "when a bad request is made" do

      it "should not add the camper to the database" do
        previous_count = Camper.count

        post :create, params: bad_camper_data
        new_count = Camper.count
# binding.pry
        expect(previous_count).to eq(new_count)
      end

      it "returns an error message" do
        post :create, params: bad_camper_data

        returned_json = JSON.parse(response.body)
        # binding.pry
        expect(returned_json["errors"][0]).to eq("Name can't be blank")
      end
    end
  end
end