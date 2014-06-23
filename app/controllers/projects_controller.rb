class ProjectsController < ApplicationController
  autocomplete :translator, :name

  before_filter :find_project

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
        wants.html { redirect_to(assign_project_path(@project)) }
      else
        @languages = Language.all
        wants.html { render :action => "new" }
      end
    end
  end

  def assign
    steps = [:chapters, :translators, :reviewers]
    if params[:step].nil? or not steps.include? params[:step]
      @step = :chapters
    else
      @step = params[:step]
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

  private
  def find_project
    @project = Project.find params[:id] unless params[:id].nil?
  end
end
