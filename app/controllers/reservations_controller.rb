class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    home = Home.find(params[:home_id])

    if current_user == home.user
      flash[:alert] = "You cannot book your own home!"
    elsif current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method!"
      return redirect_to payment_path
    # else
    #   start_date = Date.parse(reservation_params[:start_date])
    #   end_date = Date.parse(reservation_params[:end_date])
    #   days = (end_date - start_date).to_i + 1

    #   special_dates = home.calendars.where(
    #     "status = ? AND day BETWEEN ? AND ? AND price <> ?",
    #     0, start_date, end_date, home.price
    #   )
      
      # @reservation = current_user.reservations.build(reservation_params)
      # @reservation.home = home
      # @reservation.price = home.price
      
      # @reservation.total = home.price * (days - special_dates.count)
      # special_dates.each do |date|
      #     @reservation.total += date.price
      # end
      
    #   if @reservation.Waiting!
    #     if home.Request?
    #       flash[:notice] = "Request sent successfully"
    #     else
    #       charge(home, @reservation)
    #     end
    #   else
    #     flash[:alert] = "Cannot make a reservation"
    #   end
      
    end
    redirect_to home
  end

  def past_spaces
    @spaces = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @homes = current_user.homes
  end
  
  # def approve
  #   charge(@reservation.home, @reservation)
  #   redirect_to your_reservations_path
  # end

  # def decline
  #   @reservation.Declined!
  #   redirect_to your_reservations_path
  # end

  private
  
  def send_sms(home, reservation)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+3125488878',
      to: home.user.phone_number,
      body: "#{reservation.user.fullname} booked your '#{home.listing_name}'"
    )
  end
  
    # def charge(home, reservation)
    #   if !reservation.user.stripe_id.blank?
    #     customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
    #     charge = Stripe::Charge.create(
    #       :customer => customer.id,
    #       :amount => reservation.total * 100,
    #       :description => home.listing_name,
    #       :currency => "usd", 
    #       :destination => {
        #     :amount => reservation.total * 80, # 80% of the total amount goes to the Host home, 20% is commission for the site
        #     :account => home.user.merchant_id # home's Stripe customer ID
        #   }
        # )
  
    #     if charge
    #       reservation.Approved!
    #       ReservationMailer.send_email_to_guest(reservation.user, home).deliver_later if reservation.user.setting.enable_email
    #       send_sms(home, reservation) if home.user.setting.enable_sms
    #       flash[:notice] = "Reservation created successfully!"
    #     else
    #       reservation.Declined!
    #       flash[:notice] = "Cannot charge with this payment method!"
    #     end
    #   end
    # rescue Stripe::CardError => e  
    #   reservation.declined!
    #   flash[:notice] = e.message
    # end
    
    # def set_reservation
    #   @reservation = Reservation.find(params[:id])
    # end
  
    # def reservation_params
    #   params.require(:reservation).permit(:start_date, :end_date)
    # end
end