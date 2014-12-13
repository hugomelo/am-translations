class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin reader]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :name_email
  validates :name, presence: true

  has_many :projects, :foreign_key => :owner_id
  has_many :translators
  has_many :translation_projects, through: :translators, source: :project
  has_many :reviewers
  has_many :review_projects, through: :reviewers, source: :project
  has_many :reviews, :foreign_key => :reviewer_id

  scope :token_fields, ->(q) {where("name LIKE ? OR email LIKE ?","%#{q}%","%#{q}%").all}

  def manage
  end

  def name_email
    "#{self.name}_#{self.email}"
  end

  def has_no_project?
  	  self.projects.empty? and self.translation_projects.empty? and self.review_projects.empty?
  end
end
