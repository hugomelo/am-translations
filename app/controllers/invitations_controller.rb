class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @invitation }
    end
  end

  def create
    @invitated=0
    @project = Project.find params[:project_id]
    params[:invitation][:emails].split("\n").each do |e|
      e.strip.split(' ').each do |email|
        @invitation = @project.invitations.new(email: email, role: params[:invitation][:role])
        if @invitation.save
          @invitated += 1
          InvitationMailer.translator_invitation(@invitation, current_user).deliver
        end
      end
    end

    respond_to do |format|
      if @invitated.size > 0
        flash[:notice] = t('invitations.create.invitation_successful')
        format.html { redirect_to(@project) }
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end
  end
end#DebateNaGlobo
