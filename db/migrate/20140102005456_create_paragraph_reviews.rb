class CreateParagraphReviews < ActiveRecord::Migration
  def change
    create_table :paragraph_reviews do |t|
      t.references :review
      t.references :paragraph

      t.timestamps
    end
    add_index :paragraph_reviews, :review_id
    add_index :paragraph_reviews, :paragraph_id
  end
end
