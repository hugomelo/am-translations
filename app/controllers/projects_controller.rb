class ProjectsController < ApplicationController
  before_filter :find_project, :except => [:new, :create, :index]

  def new
    @project = Project.new
    @languages = Language.all
  end

  def create
    @project = Project.new(params[:project])
    @project.owner_id = current_user.id

    respond_to do |wants|
      if @project.save
        flash[:notice] = t('projects.create.project_created')
        wants.html { redirect_to(assign_chapters_project_path(@project)) }
      else
        @languages = Language.all
        wants.html { render :action => "new" }
      end
    end
  end

  def index
    @projects = Project.all
  end

  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.xml  { render :xml => @project }
    end
  end

  def edit
  	  authorize @project
  end
  def assign_chapters
  	authorize @project
    redirect_to assign_translators_project_path(@project) unless @project.can_have_chapters?
  end

  def chapter_paragraphs
    @paragraphs = @project.from_paragraphs.in_chapter params[:chapter]
  end

  def assign_translators
  	authorize @project
    @translators = @project.translators
    @invitation = Invitation.new
    @unassigned_chapters = Chapter.t_remaining @project.from_document_id
  end

  def assign_reviewers
  	authorize @project
    @reviewers = @project.reviewers
    @invitation = Invitation.new
    @unassigned_chapters = Chapter.r_remaining @project.from_document_id
  end

  def translate
  	authorize @project
  end

  def review
  	authorize @project
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |wants|
      wants.html { redirect_to(projects_url) }
      wants.js  { }
    end
  end

  private
  def find_project
    if not params[:id].nil? and Project.exists?(params[:id])
    @project = Project.find params[:id]
    else
      flash[:error] = t("Unable to find model with ID #{params[:id]}!")
      redirect_to projects_path
    end
  end
end
