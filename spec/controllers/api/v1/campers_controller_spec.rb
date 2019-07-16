require 'rails_helper'

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#index" do
    let!(:camper1) { FactoryBot.create(:camper) }
    let!(:camper2) { FactoryBot.create(:camper) }

    before(:each) do
      get :index
    end

    it 'returns a successful response with json-formatted data' do
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns all campers in the database' do
      response_body = JSON.parse(response.body)

      expect(response_body.length).to eq 2

      expect(response_body[0]['name']).to eq camper1.name
      expect(response_body[1]['name']).to eq camper2.name

      expect(response_body[0]['campsite_id']).to eq camper1.campsite_id
      expect(response_body[1]['campsite_id']).to eq camper2.campsite_id
    end
  end

  describe 'POST#create' do
    describe 'happy path' do
      let!(:new_camper_hash){ { name: 'Jim', campsite_id: 1 } }

      it 'adds a new camper to the database' do
        expect{ post :create, body: new_camper_hash.to_json }.to change { Camper.count }.by 1
      end

      it 'returns a success response with json' do
        post :create, body: new_camper_hash.to_json

        expect(response.status).to eq 200
        expect(response.content_type).to eq 'application/json'
      end

      it 'returns the new camper as json' do
        post :create, body: new_camper_hash.to_json

        response_body = JSON.parse(response.body)

        # This wasn't working because response_body is
        # a hash, not an array! Calling length on it returns
        # the number of attributes.
        # expect(response_body.length).to eq 1

        expect(response_body["name"]).to eq new_camper_hash[:name]
        expect(response_body["campsite_id"]).to eq new_camper_hash[:campsite_id]
      end
    end

    describe 'sad path' do
      let!(:bad_camper_hash) { {campsite_id: 1} }

      it 'does not add camper to database if name is not provided' do
        previous_count = Camper.count
        post :create, body: bad_camper_hash.to_json
        new_count = Camper.count

        expect(new_count).to be(previous_count)
      end

      it 'returns an error if camper name is not provided' do
        post :create, body: bad_camper_hash.to_json

        response_body = JSON.parse(response.body)

        expect(response_body["error"]).to eq("camper did not save")
      end
    end
  end
end
