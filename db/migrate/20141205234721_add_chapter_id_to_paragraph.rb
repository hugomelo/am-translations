class AddChapterIdToParagraph < ActiveRecord::Migration
  def change
    change_table :paragraphs do |t|
      t.references :chapter, index: true
    end
	def down
      change_table :paragraphs do |t|
      	t.remove :chapter_id
      end
  	end
  end
end
