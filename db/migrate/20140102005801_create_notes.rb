class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.references :paragraph
      t.references :translator

      t.timestamps
    end
    add_index :notes, :paragraph_id
    add_index :notes, :translator_id
  end
end
