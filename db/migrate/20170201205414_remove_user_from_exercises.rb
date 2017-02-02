class RemoveUserFromExercises < ActiveRecord::Migration[5.0]
  def change
    remove_column :exercises, :user_id, :integer
  end
end
