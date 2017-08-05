class InvitationsController < ApplicationController
  skip_before_action :authenticate_user!, raise: false, only: [:confirm]

  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @invitation }
    end
  end

  # create or resend invitation mail
  def create
    @invited=0
    @project = Project.find params.permit(:project_id)
    role= invitation_params[:role]
    invitation_params[:emails].split("\n").each do |e|
      e.strip.split(' ').each do |email|
        @invitation = Invitation.where(email: email, role: role, project_id: @project.id).first
        unless @invitation.present?
          @invitation = @project.invitations.new(email: email, role: role)
          next unless @invitation.save
        end
        @invited += 1
        InvitationMailer.send("%{role}_invitation" % {role: @invitation.role}, @invitation, current_user).deliver
      end
    end

    respond_to do |format|
      if @invited.size > 0
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
    (redirect_to(root_url); return) unless params.permit(:token).present?
    @invitation = Invitation.find_token(params.permit(:token).to_s)

    unless @invitation
      redirect_to root_url, flash: {error: t('invitations.confirm.invalid_token')}
      return
    end

    @user = User.where(email: @invitation.email).first
    @project = Project.find @invitation.project_id

    # create user
    unless @user.present?
      name = @invitation.email.split('@').first.capitalize
      pass = SecureRandom.hex(8)
      @user = User.new(email: @invitation.email, name: name, password: pass, password_confirmation: pass)
      @user.confirm!
      (redirect_to(root_path); return) unless @user.save
    end

    # include in the project as :role
    @project.send(@invitation.role+"s_users") << @user
    @project.save

    sign_in @user
    @invitation.destroy
    InvitationMailer.notice_admin_of_new_user(@project, @user).deliver
    flash[:notice] = t("invitations.confirm.notice_account_activated")
  end

  def edit_user
    if current_user
      current_user.update_attributes params.permit(:user)
      flash[:notice] = t("invitations.edit_user.user_profile_saved")
    else
      flash[:error] = t("invitations.edit_user.not_loggedin")
    end
      (redirect_to(root_path); return)
  end

  protected

  def invitation_params
    params.require(:invitation).permit([:emails, :role])
  end

end
