class RemoveSourceFilenameFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :source_filename
  end

  def down
    add_column :projects, :source_filename, :string
  end
end
