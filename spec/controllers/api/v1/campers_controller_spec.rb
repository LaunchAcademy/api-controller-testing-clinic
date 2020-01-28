require 'rails_helper'

RSpec.describe Api::V1::CampersController do
  describe "GET#index" do
    let!(:camper1) { FactoryBot.create(:camper) }
    let!(:camper2) { FactoryBot.create(:camper) }

    it 'returns a successful response status and a content type of JSON' do
      get :index

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"
    end

    it 'returns a JSON hash of all campers in the database' do
      get :index

      response_body = JSON.parse(response.body)

      expect(response_body.length).to eq 2

      expect(response_body[0]["name"]).to eq camper1.name
      expect(response_body[0]["campsite_id"]).to eq camper1.campsite_id

      expect(response_body[1]["name"]).to eq camper2.name
      expect(response_body[1]["campsite_id"]).to eq camper2.campsite_id
    end
  end

  describe "POST#create" do
    context 'when a successful request is made with proper params' do
      let!(:new_camper_hash) { { camper: { name: "Gerald", campsite_id: 1} } }

      it 'adds a new camper to the database' do
        # previous_count = Camper.count
        # post :create, params: new_camper_hash, format: :json
        # new_count = Camper.count
        #
        # expect(new_count).to be(previous_count + 1)

        expect{ post :create, params: new_camper_hash, format: :json }.to change { Camper.count }.from(0).to(1)
      end

      it 'returns the new camper as JSON' do
        post :create, params: new_camper_hash, format: :json

        response_body = JSON.parse(response.body)

        expect(response_body.length).to eq 5
        expect(response_body["name"]).to eq "Gerald"
        expect(response_body["campsite_id"]).to eq 1
      end
    end

    context 'when a malformed request is made' do
      let!(:bad_camper_hash) { { camper: { campsite_id: 1 } } }

      it 'does not persist data to database' do
        previous_count = Camper.count
        post :create, params: bad_camper_hash, format: :json
        new_count = Camper.count

        expect(new_count).to eq previous_count
      end

      it 'returns validation errors' do
        post :create, params: bad_camper_hash, format: :json
        response_body = JSON.parse(response.body)

        expect(response_body["errors"][0]).to eq "Name can't be blank"
      end
    end
  end
end
