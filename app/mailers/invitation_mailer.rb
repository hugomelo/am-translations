class InvitationMailer < ActionMailer::Base
  default from: "noreply@am-translations.org"

  def translator_invitation(invitation, inviter)
    @invitation = invitation
    @inviter = inviter
    mail(to: @invitation.email, subject: t('invitation_mailer.mailer_translator_invitation') % {sitename: t('welcome.index.sitename')})
  end

  def notice_admin_of_new_user(project, invited)
    @project = project
    @invited = invited
    mail(to: @project.owner.email, subject: t('invitation_mailer.notice_admin_of_new_user.new_user_activated'))
  end
end
