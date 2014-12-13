class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.integer :order
      t.references :document

      t.timestamps
    end
  end
end