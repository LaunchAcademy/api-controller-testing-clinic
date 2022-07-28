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

      parsedResponse = JSON.parse(response.body)

      expect(parsedResponse[0]["name"]).to eq(camper_1.name)
      expect(parsedResponse[0]["id"]).to eq(camper_1.id)
      expect(parsedResponse[0]["campsite_id"]).to eq(camper_1.campsite_id)
      
      expect(parsedResponse[1]["name"]).to eq(camper_2.name)
      expect(parsedResponse[1]["id"]).to eq(camper_2.id)
      expect(parsedResponse[1]["campsite_id"]).to eq(camper_2.campsite_id)
    end
  end

  describe "POST#create" do
    context "when a request correct params is made" do
      let!(:campsite) { FactoryBot.create(:campsite) }
      let!(:camper_data) { {
        camper: { 
          name: "Jagr", 
          campsite_id: campsite.id 
        }
      }}

      it "add the camper to the database" do
        # get the current amount of campers 
        # ensure it goes up by one 
        prev_count = Camper.all.length
        
        post :create, params: camper_data

        new_count  = Camper.all.length

        expect(new_count).to eq(prev_count + 1)

      end

      it "returns the new camper object as json" do

        post :create, params: camper_data

        parsedResponse = JSON.parse(response.body)

        expect(parsedResponse["id"]).to eq(Camper.last.id)
        expect(parsedResponse["name"]).to eq(camper_data[:camper][:name])
        expect(parsedResponse["campsite_id"]).to eq(campsite.id)
        expect(parsedResponse["created_at"]).not_to be_nil
        expect(parsedResponse["updated_at"]).not_to be_nil 
      end
    end

    context "when a malformed request is made" do
      let!(:bad_camper) { { camper: { name: "" } }}

      it "should not save to the database" do
        # ensure the count hasnt changed
  
      end

      it "should return an error message" do
         post :create, params: bad_camper

         parsedResponse = JSON.parse(response.body)
         
         expect(parsedResponse["errors"]).to eq("Campsite must exist and Name can't be blank")
      end
    end
  end
end