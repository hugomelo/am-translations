class CreateTranslators < ActiveRecord::Migration
  def change
    create_table :translators do |t|
      t.references :project
      t.references :user

      t.timestamps
    end
    add_index :translators, :project_id
    add_index :translators, :user_id
  end
end
