class CreateTranslatorships < ActiveRecord::Migration
  def change
    create_table :translatorships do |t|
      t.string :project_id
      t.string :user_id

      t.timestamps
    end
    add_index :translatorships, :project_id
    add_index :translatorships, :user_id
  end
end
