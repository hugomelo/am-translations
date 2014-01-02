class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :reviewer
      t.references :document
      t.text :general_comment

      t.timestamps
    end
    add_index :reviews, :reviewer_id
    add_index :reviews, :document_id
  end
end
