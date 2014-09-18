class CreateReviewerships < ActiveRecord::Migration
  def change
    create_table :reviewerships do |t|
      t.string :project_id
      t.string :user_id

      t.timestamps
    end
    add_index :reviewerships, :project_id
    add_index :reviewerships, :user_id
  end
end
