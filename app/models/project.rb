class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :language
  belongs_to :original_language, :class_name => 'Language'
  has_one :source_project, :class_name => 'Project'
  has_many :paragraphs
  attr_accessible :owner_id, :language_id, :original_language_id, :source_project, :source_filename, :name

  has_attached_file :source_filename
  #TODO remove source_filename on migration

  validates_attachment_presence :source_filename
  validates_attachment_size :source_filename, :less_than => 100.megabytes
  validates_attachment_content_type :source_filename, content_type: ['application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  validates_presence_of :original_language_id
  validate :different_languages

  after_create :defcreated
  after_commit do |project|
    return if project.nil? or not @new_item
    doc = Docx::Document.open(project.source_filename.path)
    chapter = 1
    order = 0;
    doc.paragraphs.each do |p|
      #TODO fix for any language
      puts p
      chapter += 1 if p.to_s.downcase.start_with? 'chapter '
      Paragraph.create(:text => p.to_s, :status => 'original', :chapter => chapter, :order => order, :project_id => project.id)
      order += 1
    end
  end

  def orig_language_name
    self.original_language.nil? ? '' : self.original_language.name
  end
  def language_name
    self.language.nil? ? '' : self.language.name
  end

  protected
  def defcreated
    @new_item = true
  end

  #TODO: fix message translation
  def different_languages
    if self.original_language_id == self.language_id
      self.errors[:different_languages] << "languages need to be different"
    end
  end

end
