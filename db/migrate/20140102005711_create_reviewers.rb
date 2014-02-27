class CreateReviewers < ActiveRecord::Migration
  def change
    create_table :reviewers do |t|
      t.references :user
      t.references :project

      t.timestamps
    end
    add_index :reviewers, :user_id
    add_index :reviewers, :project_id
  end
end
