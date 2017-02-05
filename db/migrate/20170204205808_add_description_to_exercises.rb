class AddDescriptionToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :description, :text
  end
end
