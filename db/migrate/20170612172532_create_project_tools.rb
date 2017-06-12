class CreateProjectTools < ActiveRecord::Migration[5.0]
  def change
    create_table :project_tools do |t|
      t.integer :tool_id
      t.integer :project_id

      t.timestamps
    end
  end
end
