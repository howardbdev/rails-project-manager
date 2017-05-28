class RemoveBossIdFromAssignments < ActiveRecord::Migration[5.0]
  def change
    remove_column :assignments, :boss_id
  end
end
