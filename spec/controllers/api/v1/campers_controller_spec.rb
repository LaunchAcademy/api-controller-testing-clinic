require "rails_helper"

# verb / action 
# check the response status 
# check the response content type 
# check the attributes of the response body (dont forget the use JSON)

RSpec.describe Api::V1::CampersController, type: :controller do

  describe "GET#index" do
    let!(:camper_1) { FactoryBot.create(:camper) }
    let!(:camper_2) { FactoryBot.create(:camper) }

    it "return a successful status and content type of json" do
      get :index

      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end  

    it "should return all campers from the database" do
      get :index 

      parsed_response = JSON.parse(response.body)
      
      expect(parsed_response[0]["id"]).to eq(camper_1.id)
      expect(parsed_response[0]["name"]).to eq(camper_1.name)
      expect(parsed_response[0]["campsite_id"]).to eq(camper_1.campsite_id)
      expect(parsed_response[1]["id"]).to eq(camper_2.id)
      expect(parsed_response[1]["name"]).to eq(camper_2.name)
      expect(parsed_response[1]["campsite_id"]).to eq(camper_2.campsite_id)
    end
  end

  describe "POST#create" do
    context "when a request correct params is made" do
      let!(:campsite) { FactoryBot.create(:campsite) }
      let!(:camper_data) { 
        {
            camper: {
                name: "Bobilonius Prime",
                campsite_id: campsite.id
            }
        }
      }

      # generate "camper data" as if it was submitted from a form 

      it "add the camper to the database" do
        camper_count = Camper.count 

        post :create, params: camper_data

        new_camper_count = Camper.count 
        
        expect(new_camper_count).to eq(camper_count + 1)
      end

      it "returns the new camper object as json" do 
        post :create, params: camper_data 
        
        parsed_response = JSON.parse(response.body)

        expect(parsed_response["name"]).to eq(camper_data[:camper][:name])
        expect(parsed_response["campsite_id"]).to eq(camper_data[:camper][:campsite_id])
      end
    end

    context "when a malformed request is made" do
      let!(:bad_camper) { { camper: { name: "" } }}

      it "should not save to the database" do
        camper_count = Camper.count 

        post :create, params: bad_camper

        new_camper_count = Camper.count 
        
        expect(new_camper_count).to eq(camper_count)
      end

      it "should return an error message" do
         post :create, params: bad_camper

         parsed_response = JSON.parse(response.body)
        expect(parsed_response["errors"]).to eq("Campsite must exist and Name can't be blank")
      end
    end
  end
end