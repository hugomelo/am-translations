class ChaptersController < ApplicationController

  def remaining_translators
  	@user = User.find params[:user_id]
  	@project = Project.find_by_from_document_id params[:document_id]
  	@chapters = Chapter.t_remaining(params[:document_id])

  	respond_to do |format|
  		format.html { render partial: 'remaining_chapters', locals: {type: 'translator'} }
  		format.json  { render json: @chapters }
  		format.js  { render js: @chapters }
  	end
  end

  def remaining_reviewers
  	@user = User.find params[:user_id]
  	@project = Project.find_by_from_document_id params[:document_id]
  	@chapters = Chapter.r_remaining(params[:document_id])

  	respond_to do |format|
  		format.html { render partial: 'remaining_chapters', locals: {type: 'reviewer'} }
  		format.json  { render json: @chapters }
  		format.js  { render js: @chapters }
  	end
  end
end
