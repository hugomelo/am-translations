class ProjectsController < ApplicationController

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
        flash[:notice] = 'Project was successfully created.'
        wants.html { redirect_to(@project) }
      else
        @languages = Language.all
        wants.html { render :action => "new" }
      end
    end
  end

  def assign
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
