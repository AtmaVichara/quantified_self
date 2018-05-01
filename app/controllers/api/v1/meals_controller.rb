class Api::V1::MealsController < ApplicationController

    def index
      render json: Meal.all
    end

    def show
      begin
        render json: Meal.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render status: 404
      end
    end

    def create
      begin
        meal = Meal.find(params[:meal_id])
        food = Food.find(params[:id])
        meal.foods << food
        render json: {message: "Successfully added #{food.name} to #{meal.name}"}
      rescue
        render status: 404
      end
    end

    def destroy
      begin
        meal = Meal.find(params[:meal_id])
        food = Food.find(params[:id])
        if MealFood.find_by(meal_id: meal.id, food_id: food.id).destroy
          render json: {message: "Successfully removed #{food.name} from #{meal.name}"}
        end
      rescue ActiveRecord::RecordNotFound
        render status: 404
      end
    end


end
