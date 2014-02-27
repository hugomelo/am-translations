class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.text :text
      t.references :project
      t.string :status
      t.integer :chapter
      t.integer :order

      t.timestamps
    end
    add_index :paragraphs, :project_id
  end
end
