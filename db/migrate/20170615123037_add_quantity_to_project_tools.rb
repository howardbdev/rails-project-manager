class AddQuantityToProjectTools < ActiveRecord::Migration[5.0]
  def change
    add_column :project_tools, :quantity, :integer, default: 1
  end
end
