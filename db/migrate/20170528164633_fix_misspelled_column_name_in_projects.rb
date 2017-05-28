class FixMisspelledColumnNameInProjects < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :desription, :description
  end
end
