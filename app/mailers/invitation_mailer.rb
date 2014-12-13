class InvitationMailer < ActionMailer::Base
  default from: "noreply@am-translations.org"

  def translator_invitation(invitation, inviter)
    @invitation = invitation
    @inviter = inviter
    mail(to: @invitation.email, subject: t('invitation_mailer.mailer_translator_invitation'))
  end
end
