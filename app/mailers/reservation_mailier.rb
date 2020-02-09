class ReservationMailer < ApplicationMailer
  def send_email_to_guest(guest, home)
    @recipient = guest
    @home = venue
    mail(to: @recipient.email, subject: "Thank you! 💯")
  end
end