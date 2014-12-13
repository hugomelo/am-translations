class Document < ActiveRecord::Base
  attr_accessible :language_id, :chapter_id

  has_one :from_project, class_name: 'Project', foreign_key: :from_document_id
  has_many :to_projects, class_name: 'Project', foreign_key: :to_document_id
  belongs_to :to_language, :class_name => 'Language'
  belongs_to :from_language, :class_name => 'Language'
  has_many :paragraphs
  has_many :chapters

  # can't figure out a way for grouping it on database.
  def paragraphs_by_chapter
    c = {}
    paragraphs.each do |p|
      c[p.chapter] ||= []
      c[p.chapter].push p
    end
    c
  end
end
