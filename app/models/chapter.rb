class Chapter < ActiveRecord::Base
  attr_accessible :document_id, :name, :order

  has_many :paragraphs
  belongs_to :document

  has_and_belongs_to_many :translators
  has_and_belongs_to_many :reviewers

  validates_presence_of :document_id

  # remaining chapters for translators
  scope :t_remaining, ->(document_id) {includes(:translators).where('chapters_translators.chapter_id' => nil, document_id: document_id)}
  # remaining chapters for reviewers
  scope :r_remaining, ->(document_id) {includes(:reviewers).where('chapters_reviewers.chapter_id' => nil, document_id: document_id)}
end
