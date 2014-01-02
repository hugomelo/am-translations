class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.text :text
      t.references :document
      t.string :status
      t.integer :chapter

      t.timestamps
    end
    add_index :paragraphs, :document_id
  end
end
