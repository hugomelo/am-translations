class Project < ActiveRecord::Base
  belongs_to :source, :class_name => 'Document'
  belongs_to :document
  belongs_to :owner, :class_name => 'User'
  belongs_to :language
  belongs_to :source_language, :class_name => 'Language'
  has_one :source_project, :class_name => 'Project'
  has_many :paragraphs
  attr_accessible :source_filename, :name

  after_create :import_document
  def import_document
    doc = Docx::Document.open(@project.source_filename)
    chapter = 1
    order = 0;
    doc.paragraphs.each do |p|
      #TODO fix for any language
      chapter += 1 if p.downcase.start_with? 'chapter '
      Paragraph.create(:text => p, :status => 'original', :chapter => chapter, :order => order, :project => @project)
      order += 1
    end
  end
end
