class Api::V1::FoodsController < ApplicationController

  def index
    render json: Food.all
  end

  def show
    render json: Food.find(params[:id])
  end

  def create
    food = Food.new(food_params)
    if food.save
      render json: food
    else
      render status: 400
    end
  end

  def update
    begin
      food = Food.find(params[:id])
      if food.update(food_params)
        render json: food
      else
        render status: 400
      end
    rescue ActiveRecord::RecordNotFound
      render status: 400
    end 
  end


  private

    def food_params
      params.require(:food).permit(:calories, :name)
    end
end
