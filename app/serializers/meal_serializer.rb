class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :foods

  def foods 
    object.foods
  end
end
