class DropTranslators < ActiveRecord::Migration
  def change
    drop_table :translators
  end
end
