require "rails_helper"

RSpec.describe Api::V1::CampersController, type: :controller do
  describe "GET#index" do

    it "return a successful status and content type of json" do

    end  

    it "should return all campers from the database" do

    end
  end

  describe "POST#create" do
    context "when a request correct params is made" do

      it "add the camper to the database" do

      end

      it "returns the new camper object as json" do

      end
    end

    context "when a malformed request is made" do

      it "should not save to the database" do

      end

      it "should return an error message" do

      end
    end
  end
end