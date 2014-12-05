class MoveParagraphIndexChapter < ActiveRecord::Migration
  def up
    add_index :paragraphs, :chapter
  end

  def down
  	  remove_index :paragraphs, :chapter
  end
end
