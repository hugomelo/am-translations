class TranslatorsController < ApplicationController

  def index
    respond_to do |format|
   	  format.html
   	  format.json { render json: User.token_fields(params[:q]).map {|t| {:id => t.id, name: "#{t.name} <#{t.email}>" }} }
    end
  end

  def autocomplete_translator_name
  	  users =User.where('name LIKE ?', params[:term]).all
  	  render :json => users.map { |user| {:id => user.id, :label => user.name + " ("+user.email+")", :value => user.name} }
  end
end
