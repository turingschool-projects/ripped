class AddStatusToFeedback < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :status, :integer, default: 0  
  end
end
