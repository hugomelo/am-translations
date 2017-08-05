class UsersController < ApplicationController

  before_action :find_user

  def autocomplete_user_name
  	respond_to do |format|
      format.json { render json: User.token_fields(params[:term]).map { |user| {:id => user.id, :label => "#{user.name} <#{user.email}>", :value => user.name} } }
    end
  end
  def dashboard
  end

  def index
  end

  def edit
    render 'devise/registrations/edit', locals: {user: @user}
  end

  private
  def find_user
    @user = current_user
  end
end
