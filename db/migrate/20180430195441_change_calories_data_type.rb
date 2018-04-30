class ChangeCaloriesDataType < ActiveRecord::Migration[5.1]
  def change
    change_column :foods, :calories, :string
  end
end
