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
        expect(food["calories"]).to be_a(String)
      end
    end
  end

  context "GET /api/v1/foods/:id" do
    it "returns selected food" do
      create(:food, name: 'Cheese', calories: "110")

      get '/api/v1/foods/1'

      expect(response).to be_success

      food = JSON.parse(response.body)
      expect(food["name"]).to eq("Cheese")
      expect(food["calories"]).to eq("110")
    end
  end

  context "POST /api/v1/foods" do
    it "creates selected food" do
      food = { "name" => "Cheese", "calories" => "110"}

      post '/api/v1/foods', params: {'food' => food }

      expect(response).to be_success
      new_food = JSON.parse(response.body)

      expect(new_food["name"]).to eq(food["name"])
      expect(new_food["calories"]).to eq(food["calories"])
    end

    it "returns 400 error" do
      food = {"calories" => '110'}

      post '/api/v1/foods', params: {'food' => food }

      expect(response).to_not be_success
      expect(response.status).to be(400)

      name = {"name" => 'something'}

      post '/api/v1/foods', params: {'food' => name }

      expect(response).to_not be_success
      expect(response.status).to be(400)
    end
  end
end
