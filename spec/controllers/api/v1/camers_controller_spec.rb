require "rails_helper"

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#index" do
    let!(:camper_1) { FactoryBot.create(:camper) }
    let!(:camper_2) { FactoryBot.create(:camper) }

    it "return a successful status and content type of json" do
      get :index

      # binding.pry
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end  

    it "should return all campers from the database" do
      get :index

      returned_json = JSON.parse(response.body)

      expect(returned_json.length).to eq(2)
      expect(returned_json[0]["name"]).to eq(camper_1.name)
      expect(returned_json[0]["campsite_id"]).to eq(camper_1.campsite_id)

      expect(returned_json[1]["name"]).to eq(camper_2.name)
      expect(returned_json[1]["campsite_id"]).to eq(camper_2.campsite_id)
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
        # binding.pry
        prev_count = Camper.all.length
        # prev_count = Camper.count
        # binding.pry
        post :create, params: camper_data

        new_count = Camper.all.length
        # new_count = Camper.count
# binding.pry
        expect(new_count).to eq(prev_count + 1)
      end

      it "returns the new camper object as json" do
        post :create, params: camper_data

        returned_json = JSON.parse(response.body)
        # binding.pry
        expect(returned_json.length).to eq(5)
        expect(returned_json["name"]).to eq("Jagr")
        expect(returned_json["campsite_id"]).to eq(campsite.id)
      end
    end

    context "when a malformed request is made" do
      let!(:bad_camper) { { camper: { name: "" } }}

      it "should not save to the database" do
        prev_count = Camper.all.length
        # prev_count = Camper.count

        post :create, params: bad_camper

        new_count = Camper.all.length
        # new_count = Camper.count

        expect(prev_count).to eq (new_count)
      end

      it "should return an error message" do
        post :create, params: bad_camper

        returned_json = JSON.parse(response.body)

        expect(returned_json["errors"]).to eq("Campsite must exist and Name can't be blank")
      end
    end
  end
end