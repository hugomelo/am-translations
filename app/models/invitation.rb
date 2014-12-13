class Invitation < ActiveRecord::Base
  attr_accessible :confirmation_hash, :email, :name, :project_id, :role
  attr_reader :emails
  belongs_to :project
  belongs_to :user

  validates_format_of :email,:with => Devise::email_regexp

  after_initialize :generate_hash
  def generate_hash
    self.confirmation_hash = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
