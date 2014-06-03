class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :to_language, :class_name => 'Language'
  belongs_to :from_language, :class_name => 'Language'
  belongs_to :to_document, :class_name => 'Document'
  belongs_to :from_document, :class_name => 'Document'
  attr_accessible :owner_id, :to_language_id, :from_language_id, :from_document_id, :to_document_id, :source_filename, :name

  has_attached_file :source_filename

  validates_attachment_presence :source_filename
  validates_attachment_size :source_filename, :less_than => 100.megabytes
  validates_attachment_content_type :source_filename, content_type: ['application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  validates_presence_of :from_language_id
  validate :different_languages

  after_create :defcreated
  after_commit do |project|
    return if project.nil? or not @new_item
    @new_item = nil
    doc = Docx::Document.open(project.source_filename.path)
    chapter = 1
    order = 0;
    project.from_document = Document.create :language_id => project.from_language
    project.to_document = Document.create :language_id => project.to_language
    project.save!
    doc.paragraphs.each do |p|
      #TODO fix for any language
      chapter += 1 if p.to_s.downcase.start_with? 'chapter '
      Paragraph.create(:text => p.to_s, :status => 'original', :chapter => chapter, :order => order, :document_id => project.from_document_id)
      Paragraph.create(:text => '', :status => 'empty', :chapter => chapter, :order => order, :document_id => project.to_document_id)
      order += 1
    end
  end

  def orig_language_name
    self.from_language.nil? ? '' : self.from_language.name
  end
  def language_name
    self.to_language.nil? ? '' : self.to_language.name
  end

  protected
  def defcreated
    @new_item = true
  end

  #TODO: fix message translation
  def different_languages
    if self.from_language_id == self.to_language_id
      self.errors[:different_languages] << "languages need to be different"
    end
  end

end
