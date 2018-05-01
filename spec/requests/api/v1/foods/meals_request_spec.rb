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

  context "GET /api/v1/meals/:id/foods" do
    it "returns specific meal" do
      meal1 = create(:meal)
      meal2 = create(:meal)
      food1 = create(:food)
      food2 = create(:food)
      create(:meal_food, food: food2, meal: meal1)
      create(:meal_food, food: food1, meal: meal2)

      get "/api/v1/meals/1/foods"

      expect(response).to be_success

      meal = JSON.parse(response.body)
      meal["foods"].each do |food|
        expect(food).to be_a(Hash)
        expect(food["name"]).to eq(food2.name)
        expect(food["calories"]).to eq(food2.calories)
      end

      get "/api/v1/meals/3/foods"

      expect(response.status).to eq(404)
    end
  end

  context "POST /api/v1/meals/:meal_id/foods/:is" do
    it "creates food and associateds it with the meal" do
      food = create(:food)
      meal = create(:meal)

      post "/api/v1/meals/1/foods/1"

      expect(response).to be_succes

      res = JSON.parse(response.body)

      expect(res["message"]).to eq("Successfully added #{food.name} to #{meal.name}")

      post "/api/v1/meals/2/foods/1"

      expect(response.status).to be(404)
    end
  end

  context "DELETE /api/v1/meals/:meal_id/foods/:id" do
    it "deletes association between food and meal" do
      food = create(:food)
      meal = create(:meal)
      create(:meal_food, meal: meal, food: food)

      delete "/api/v1/meals/1/foods/1"

      expect(response).to be_success

      res = JSON.parse(response.body)

      expect(res["message"]).to eq("Successfully removed #{food.name} from #{meal.name}")

      delete "/api/v1/meals/2/foods/1"

      expect(response.status).to be(404)
    end
  end
end
