# frozen_string_literal: true

class TeamMailer < ApplicationMailer
  def send_report
    @teams = Team.all

    mail(
      to: 'some_email_address@gmail.com',
      bcc: '',
      subject: 'Teams'
    )
  end

  def send_rep_with_managers_and_teams(count)
    @created = count
    mail(
    to: 'address@gmail.com',
    bcc: '',
    subject: 'Managers and teams'
    )
  end
end
