class ReservationMailer < ApplicationMailer
  def send_email_to_guest(guest, home)
    @recipient = guest
    @home = home
    mail(to: @recipient.email, subject: "Thank you! 💯")
  end
end