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
      user_ids = params[:translator][:translator_tokens].split(',')
      @success = true
      translators = []
      user_ids.each do |user_id|
        translators << Translator.new(user_id: user_id)
      end
      @project.translators = translators
    else
      redirect_to "/notfound"
    end
  end
end
