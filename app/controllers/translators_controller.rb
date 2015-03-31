class TranslatorsController < ApplicationController

  def index
    @translators = Translator.all
  end

  def create
    @translator = Translator.create(params[:translator])

    respond_to do |format|
      if @translator.save
        flash[:notice] = 'Translator was successfully created.'
        format.html { redirect_to(@translator) }
        format.xml  { render xml: @translator, status: :created, location: @translator }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @translator.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign
    if request.xhr?
      @project = Project.find params[:project_id]
      translator = @project.translators.build(params[:translator])
      if translator and translator.save
        @project.translators << translator
        @unassigned_chapters = Chapter.t_remaining @project.from_document_id
        @success = true
      else
        @success = false
      end
    else
      redirect_to "/notfound"
    end
  end
end
