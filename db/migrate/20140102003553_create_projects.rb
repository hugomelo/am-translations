class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :owner
      t.references :from_document
      t.references :to_document
      t.references :from_language
      t.references :to_language

      t.timestamps
    end
    add_index :projects, :owner_id
    add_index :projects, :from_document_id
    add_index :projects, :to_document_id
    add_index :projects, :from_language_id
    add_index :projects, :to_language_id
  end
end
