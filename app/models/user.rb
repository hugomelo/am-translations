class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin reader]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  validates :name, presence: true

  has_many :projects, :foreign_key => :owner_id
  has_many :translatorships
  has_many :translation_projects, through: :translatorships, source: :project
  has_many :reviewerships
  has_many :review_projects, through: :reviewerships, source: :project
  has_many :reviews, :foreign_key => :reviewer_id

  scope :token_fields, ->(q) {where("name LIKE ? AND email LIKE ?","%#{q}%","%#{q}%").all}

  def manage
  end

  def has_no_project?
  	  self.projects.empty? and self.translation_projects.empty? and self.review_projects.empty?
  end
end
