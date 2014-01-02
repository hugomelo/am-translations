class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :source
      t.references :document
      t.references :owner

      t.timestamps
    end
    add_index :projects, :source_id
    add_index :projects, :document_id
    add_index :projects, :owner_id
  end
end
