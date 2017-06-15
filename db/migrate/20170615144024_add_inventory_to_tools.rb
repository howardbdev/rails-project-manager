class AddInventoryToTools < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :inventory, :integer, default: 1
  end
end
