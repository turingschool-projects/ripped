class AddStatusToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :status, :integer, default: 0
  end
end
