class ReviewersController < ApplicationController

  def create
    @reviewer = Reviewer.create(reviewer_params)

    respond_to do |format|
      if @reviewer.save
        flash[:notice] = t('.saved_success')
        format.html { redirect_to(@reviewer) }
        format.xml  { render xml: @reviewer, status: :created, location: @reviewer }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @reviewer.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign
    if request.xhr?
      @project = Project.find params[:project_id]
      reviewer = @project.reviewers.build(reviewer_params)
      if reviewer and reviewer.save
        @project.reviewers << reviewer
        @unassigned_chapters = Chapter.r_remaining @project.from_document_id
        @success = true
      else
        @success = false
      end
    else
      redirect_to "/notfound"
    end
  end

  protected

  def reviewer_params
    params.require(:reviewer).permit(:project_id, :user_id, :chapter_ids)
  end
end
