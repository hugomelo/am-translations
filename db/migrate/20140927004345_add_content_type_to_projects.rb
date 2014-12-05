class AddContentTypeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :content_type, :string
  end
end
