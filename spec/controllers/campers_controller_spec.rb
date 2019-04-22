require 'rails_helper'

RSpec.describe Api::V1::CampersController, type: :controller do 
  describe 'GET#index' do
    let!(:camper1) { FactoryBot.create(:camper) }
    let!(:camper2) { FactoryBot.create(:camper) }

    it 'returns successful response with json-formatted data' do
      get :index 

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns all campers in the database' do 
      get :index

      response_json = JSON.parse(response.body)
      
      expect(response_json.length).to eq 2
      expect(response_json[0]['name']).to eq camper1.name
      expect(response_json[1]['name']).to eq camper2.name
      expect(response_json[0]['campsite_id']).to eq camper1.campsite_id
      expect(response_json[1]['campsite_id']).to eq camper2.campsite_id
    end
  end

  describe 'POST#create' do
    let!(:new_camper) { { name: 'Jim', campsite_id: 1 } }
    it 'adds a new camper to the database' do
      expect { post :create, body: new_camper.to_json }.to change { Camper.count }.by 1
    end

    it 'returns the new camper as json' do
      post :create, body: new_camper.to_json

      response_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'

      expect(response_json['name']).to eq new_camper[:name]
      expect(response_json['campsite_id']).to eq new_camper[:campsite_id]
    end

    it 'returns an error if camper name is not provided' do
      bad_camper = {
        campsite_id: 1
      }

      post :create, body: bad_camper.to_json

      response_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'

      expect(response_json['error']['name']).to eq ["can't be blank"]
    end
  end
end