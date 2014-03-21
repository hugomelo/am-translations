class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin reader]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  validates :name, presence: true

  has_many :projects, :foreign_key => :owner_id
  has_many :reviewers
  has_many :translators
  has_many :reviews, :through => :reviewers
  has_many :translations, :through => :translators, :foreign_key => 'project_id'

  def manage
  end
end
