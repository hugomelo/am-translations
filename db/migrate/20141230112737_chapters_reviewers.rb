class ChaptersReviewers < ActiveRecord::Migration
  def change
  	create_table :chapters_reviewers, id: false do |t|
      t.belongs_to :chapter
      t.belongs_to :reviewer
  	end
  end
end
