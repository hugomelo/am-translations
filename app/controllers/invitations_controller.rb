class InvitationsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:confirm]

  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @invitation }
    end
  end

  def create
    @invited=0
    @project = Project.find params[:project_id]
    params[:invitation][:emails].split("\n").each do |e|
      e.strip.split(' ').each do |email|
        @invitation = @project.invitations.new(email: email, role: params[:invitation][:role])
        if Invitation.was_invited? @invitation or @invitation.save
          @invited += 1
          InvitationMailer.translator_invitation(@invitation, current_user).deliver
        end
      end
    end

    respond_to do |format|
      if @invited.size > 0
        flash[:notice] = t('invitations.create.invitation_successful')
        format.html { redirect_to(@project) }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end

  # Confirm token sent by mail as an invitation to project
  def confirm
    (redirect_to(root_url); return) unless params[:token].present?
    @invitation = Invitation.find_token(params[:token].to_s)

    unless @invitation
      redirect_to root_url, flash: {error: t('invitations.confirm.invalid_token')}
      return
    end

    @user = User.where(email: @invitation.email).first
    @project = Project.find @invitation.project_id

    if @user.present?
      @project.send(@invitation.role+"s_user_ids") << @user.id
      sign_in @user
      redirect_to(root_url)
      return
    end

    name = @invitation.email.split('@').first.capitalize
    pass = SecureRandom.hex(8)
    @user = User.new(email: @invitation.email, name: name, password: pass, password_confirmation: pass)
    @user.confirm!

    if @user.save
      @project.send(@invitation.role+"s_user_ids") << @user.id
      @project.save
      sign_in @user
      @invitation.destroy
      InvitationMailer.notice_admin_of_new_user(@project, @user).deliver
      flash[:notice] = t("invitations.confirm.notice_account_activated")
      return
    end
    redirect_to(root_url)
  end

  def edit_user
    if current_user
      current_user.update_attributes params[:user]
      flash[:notice] = t("invitations.edit_user.user_profile_saved")
    else
      flash[:error] = t("invitations.edit_user.not_loggedin")
    end
    redirect_to root_path
  end

end
