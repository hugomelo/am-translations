class Invitation < ApplicationRecord
  attr_accessible :token, :email, :name, :project_id, :role
  attr_reader :emails
  belongs_to :project
  belongs_to :user

  validates_format_of :email,:with => Devise::email_regexp
  validates_uniqueness_of :token

  scope :is_invited?, lambda { |invitation| where(email: invitation.email, project_id: invitation.project_id, role: invitation.role) }
  scope :find_tokens, lambda { |token| where(token: token) }

  after_initialize :generate_hash, :if => :new_record?
  def generate_hash
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def self.was_invited? invitation
    is_invited?(invitation).present?
  end

  def self.find_token token
    self.find_tokens(token).first
  end
end
