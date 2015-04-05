class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :name
      t.string :email
      t.string :token
      t.integer :project_id
      t.string :role

      t.timestamps
    end
  end
end
