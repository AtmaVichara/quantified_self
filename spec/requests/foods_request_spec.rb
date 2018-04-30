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

  context "GET /api/v1/foods/:id" do
    it "returns selected food" do
      create(:food, name: 'Cheese', calories: 110)

      get '/api/v1/foods/1'

      expect(response).to be_success

      food = JSON.parse(response.body)
      expect(food["name"]).to eq("Cheese")
      expect(food["calories"]).to eq(110)
    end
  end
end
