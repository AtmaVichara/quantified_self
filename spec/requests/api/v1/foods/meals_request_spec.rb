require 'rails_helper'

describe "Meals Request Endpoint" do
  context "GET /api/v1/meals" do
    it "it returns all meals" do
      meal1 = create(:meal)
      meal2 = create(:meal)
      food1 = create(:food)
      food2 = create(:food)
      create(:meal_food, food: food2, meal: meal1)
      create(:meal_food, food: food1, meal: meal2)
      get "/api/v1/meals"
      expect(response).to be_success

      meals = JSON.parse(response.body)

      expect(meals.count).to eq(2)
      meals[0]["foods"].each do |food|
        expect(food).to be_a(Hash)
        expect(food["name"]).to eq(food2.name)
        expect(food["calories"]).to eq(food2.calories)
      end
      meals[1]["foods"].each do |food|
        expect(food).to be_a(Hash)
        expect(food["name"]).to eq(food1.name)
        expect(food["calories"]).to eq(food1.calories)
      end
    end
  end
end
