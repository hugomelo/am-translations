class ProjectsController < ApplicationController

  before_filter :find_project

  def new
    @project = Project.new
    @languages = LanguageList::ALL_LANGUAGES
  end

  def index
    @projects = Project.all
  end

  private
  def find_project
    @project = Project.find params[:id] unless params[:id].nil?
  end
end
