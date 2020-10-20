require "rails_helper"

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#index" do
    let!(:camper1) { FactoryBot.create(:camper) }
    let!(:camper2) { FactoryBot.create(:camper) }
  
    it "return a successful status and content type of json" do
      get :index
      
      # binding.pry
      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end  
    
    it "should return all campers from the database" do
      get :index
      # binding.pry
      returned_response = JSON.parse(response.body)

      expect(returned_response.length).to eq 2

      expect(returned_response[0]["name"]).to eq camper1.name
      expect(returned_response[0]["campsite_id"]).to eq camper1.campsite_id
    
      expect(returned_response[1]["name"]).to eq camper2.name
      expect(returned_response[1]["campsite_id"]).to eq camper2.campsite_id
    end
  end

  describe "POST#create" do
    context "when a request correct params is made" do
      let!(:new_camper_data) { { camper: { name: "Jagr", campsite_id: 4 } } }
      
      it "add the camper to the database" do
        previous_count = Camper.count

        post :create, params: new_camper_data
        
        new_count = Camper.count
        
        expect(new_count).to eq previous_count + 1
      end
      
      it "returns the new camper object as json" do
        post :create, params: new_camper_data
        # binding.pry
        returned_response = JSON.parse(response.body)
        
        expect(returned_response["name"]).to eq "Jagr"
        expect(returned_response["campsite_id"]).to eq 4
      end
    end

    context "when a malformed request is made" do
      let!(:bad_camper_data) { { camper: { campsite_id: 4 } } }
     
      it "should not save to the database" do
        previous_count = Camper.count
       
        post :create, params: bad_camper_data
        # binding.pry
        new_count = Camper.count
        
        expect(previous_count).to eq new_count
      end
      
      it "should return an error message" do
        post :create, params: bad_camper_data
        
        returned_response = JSON.parse(response.body)
        # binding.pry
        expect(returned_response["errors"][0]).to eq "Name can't be blank"
      end
    end
  end
end