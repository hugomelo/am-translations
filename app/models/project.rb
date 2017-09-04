# encoding: utf-8
class Project < ApplicationRecord
  belongs_to :owner, :class_name => 'User'
  belongs_to :to_language, :class_name => 'Language'
  belongs_to :from_language, :class_name => 'Language'
  belongs_to :to_document, :class_name => 'Document', required: false
  belongs_to :from_document, :class_name => 'Document', required: false
  has_many   :from_paragraphs, through: :from_document, :source => 'paragraphs'
  has_many   :to_paragraphs, through: :to_document, :source => 'paragraphs'
  has_many   :translators
  has_many   :translators_users, through: :translators, source: 'user' do
    def <<(new_item)
      super( Array(new_item) - proxy_association.owner.translators_users )
    end
  end
  has_many   :reviewers
  has_many   :reviewers_users, through: :reviewers, source: 'user' do
    def <<(new_item)
      super( Array(new_item) - proxy_association.owner.reviewers_users )
    end
  end
  has_many   :invitations

  #scope :grouped_paragraphs, from_paragraphs.select(['paragraphs.id', 'paragraphs.text', 'paragraphs.chapter']).group(:chapter)
  has_attached_file :source_filename

  validates_attachment_presence :source_filename
  validates_attachment_size :source_filename, :less_than => 100.megabytes
  validates_attachment_content_type :source_filename, content_type: ['application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  validates_presence_of :from_language_id
  validate :different_languages

  before_create :build_documents
  after_create_commit :import_document

  def build_documents
    self.create_from_document! :language_id => from_language_id
    self.create_to_document! :language_id => to_language_id
  end
  def import_document
    doc = Docx::Document.open(source_filename.path)
    chapter_order = 1
    paragraph_order = 0
    chapter_words = ["capítulo", "parte"]
    debugger
    chapter = Chapter.create! document_id: from_document_id, order: chapter_order, name: 'introduction'
    doc.paragraphs.each do |p|
      #TODO fix for any language
      if p.to_s.size < 50
      	p_down = p.to_s.downcase
      	chapter_words.each do |word|
      	  if p_down.include? word
            chapter = Chapter.create! document_id: from_document_id, order: chapter_order, name: p.text
            chapter_order += 1
      	  	break
      	  end
      	end
      end
      Paragraph.create!(:text => p.to_s, :status => 'original', :chapter_id => chapter.id, :order => paragraph_order, :document_id => from_document_id)
      Paragraph.create!(:text => '', :status => 'empty', :chapter_id => chapter.id, :order => paragraph_order, :document_id => to_document_id)
      paragraph_order += 1
    end
  end

  def orig_language_name
    self.from_language.nil? ? '' : self.from_language.name
  end
  def language_name
    self.to_language.nil? ? '' : self.to_language.name
  end

  def is_article?
    self.content_type == 'article'
  end
  def is_book?
    self.content_type == 'book'
  end

  def can_have_chapters?
    ['book'].include? self.content_type
  end

  protected

  #TODO: fix message translation
  def different_languages
    if self.from_language_id == self.to_language_id
      self.errors[:different_languages] << "languages need to be different"
    end
  end

end
