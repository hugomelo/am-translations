class FixColumnOnReviewers < ActiveRecord::Migration
  def change
    rename_column :reviewers, :reviewer_id, :user_id
  end
end
