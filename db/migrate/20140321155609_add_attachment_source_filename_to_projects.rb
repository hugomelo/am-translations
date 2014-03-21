class AddAttachmentSourceFilenameToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :source_filename
    end
  end

  def self.down
    drop_attached_file :projects, :source_filename
  end
end
