class Project < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :language
  belongs_to :original_language, :class_name => 'Language'
  has_one :source_project, :class_name => 'Project'
  has_many :paragraphs
  attr_accessible :owner_id, :language_id, :original_language_id, :source_project, :source_filename, :name

  after_create do |project|
    return if project.nil?
    doc = Docx::Document.open(project.source_filename)
    chapter = 1
    order = 0;
    doc.paragraphs.each do |p|
      #TODO fix for any language
      chapter += 1 if p.to_s.downcase.start_with? 'chapter '
      Paragraph.create(:text => p.to_s, :status => 'original', :chapter => chapter, :order => order, :project_id => project.id)
      order += 1
    end
  end
end
