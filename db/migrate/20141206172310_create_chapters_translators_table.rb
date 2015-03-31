class CreateChaptersTranslatorsTable < ActiveRecord::Migration
  def change
  	create_table :chapters_translators, id: false do |t|
      t.belongs_to :chapter
      t.belongs_to :translator
  	end
  end
end
