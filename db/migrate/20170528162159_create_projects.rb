class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :desription
      t.string :location

      t.timestamps
    end
  end
end
