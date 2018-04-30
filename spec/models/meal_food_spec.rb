require 'rails_helper'

RSpec.describe MealFood, type: :model do
  describe "relationships" do
    it {should belong_to(:food)}
    it {should belong_to(:meal)}
  end
end
