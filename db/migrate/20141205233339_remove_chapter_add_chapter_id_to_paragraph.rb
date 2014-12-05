class RemoveChapterAddChapterIdToParagraph < ActiveRecord::Migration
  def up
  	remove_column :paragraphs, :chapter
  end

  def down
  	add_column :paragraphs, :chapter
  end
end
