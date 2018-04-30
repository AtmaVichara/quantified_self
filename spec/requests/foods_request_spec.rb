require 'rails_helper'

describe "Foods Endpoint" do
  context "GET request /api/v1/foods" do
    it "returns all foods" do
      create_list(:food, 10)

      get '/api/v1/foods'

      expect(response).to be_success

      foods = JSON.parse(response.body)
      expect(foods.count).to eq(10)
      foods.each do |food|
        expect(food).to be_a(Hash)
        expect(food["name"]).to_not be(nil)
        expect(food["calories"]).to be_a(Integer)
      end
    end
  end
end
