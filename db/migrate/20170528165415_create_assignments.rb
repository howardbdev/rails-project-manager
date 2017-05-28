class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :boss_id

      t.timestamps
    end
  end
end
