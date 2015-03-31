class InvitationMailer < ActionMailer::Base
  default from: "noreply@am-translations.org"

  def translator_invitation(invitation, inviter)
    @invitation = invitation
    @inviter = inviter
    mail(to: @invitation.email, subject: t('invitation_mailer.translator_invitation.mailer_translator_invitation') % {sitename: t('welcome.index.sitename')})
  end
end
