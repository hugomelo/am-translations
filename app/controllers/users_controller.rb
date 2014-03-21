class UsersController < ApplicationController

  before_filter :find_user
  def dashboard
  end

  def edit
    render 'devise/registrations/edit', locals: {user: @user}
  end

  private
  def find_user
    @user = current_user
  end
end
