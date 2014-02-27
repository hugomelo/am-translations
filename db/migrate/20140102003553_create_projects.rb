class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :source
      t.references :document
      t.references :owner
      t.string :source_filename
      t.references :source_project
      t.references :original_language
      t.references :language

      t.timestamps
    end
    add_index :projects, :source_id
    add_index :projects, :document_id
    add_index :projects, :owner_id
    add_index :projects, :source_project_id
    add_index :projects, :original_language_id
    add_index :projects, :language_id
  end
end
