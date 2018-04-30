require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe "relationships" do
    it {should have_many(:meal_foods)}
    it {should have_many(:foods).through(:meal_foods)}
  end
end
