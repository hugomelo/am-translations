class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :filename
      t.references :language

      t.timestamps
    end
    add_index :documents, :language_id
  end
end
