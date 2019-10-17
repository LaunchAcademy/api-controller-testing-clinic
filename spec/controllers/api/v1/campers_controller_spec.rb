require "rails_helper"

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#index" do
    let!(:first_camper) { FactoryBot.create(:camper) }
    let!(:second_camper) { FactoryBot.create(:camper) }

    it "returns a successful status and a content type of json" do
      get :index

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it "returns a json hash of our campers" do
      get :index

      response_body = JSON.parse(response.body)

      expect(response_body[0]["name"]).to eq first_camper.name
      expect(response_body[0]["campsite_id"]).to eq first_camper.campsite_id

      expect(response_body[1]["name"]).to eq second_camper.name
      expect(response_body[1]["campsite_id"]).to eq second_camper.campsite_id
    end
  end

  describe "POST#create" do
    context "when a successful request is made with the proper params" do
      let!(:new_camper_hash) { { camper: { name: "Jimbo", campsite_id: 1 } } }

      it "creates a new camper object in the database" do
        expect{ post :create, params: new_camper_hash, format: :json}.to change { Camper.count }.by 1
        # expect{ post :create, new_camper_hash, format: :json}.to change { Camper.count }.by 1
      end

      it "returns the newly created camper" do
         post :create, params: new_camper_hash, format: :json

         response_body = JSON.parse(response.body)

         expect(response_body["name"]).to eq "Jimbo"
         expect(response_body["campsite_id"]).to eq 1
      end
    end

    context "when a malformed request is made" do
      let!(:bad_camper_hash_of_the_internet) { { camper: { campsite_id: 1 } } }

      it "does not create a new camper record in the database" do
        old_count = Camper.count
        post :create, params: bad_camper_hash_of_the_internet, format: :json
        new_count = Camper.count
        expect(new_count).to eq old_count
      end

      it "returns validation errors" do
        post :create, params: bad_camper_hash_of_the_internet, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["errors"][0]).to eq "Name can't be blank"
      end
    end
  end
end
