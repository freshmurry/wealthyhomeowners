class HomesController < ApplicationController
  before_action :set_home, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show, :preload, :preview]
  before_action :is_authorized, only: [:listing, :pricing, :description, :photo_upload, :features, :location, :update]

  def index
    @homes = current_user.homes
  end

  def new
    @home = current_user.homes.build
  end

  def create
    # This code makes host register with Stripe first. We want people to create their listing without having to signup with Stripe first.
    # if !current_user.is_active_host
    #   return redirect_to payout_path, alert: "Please Connect to Stripe Express first."
    # end
      
    @home = current_user.homes.build(home_params)
    if @home.save
      redirect_to listing_home_path(@home), notice: "Saved..."
    else
      flash[:alert] = "Something went wrong..."
      render :new
    end
  end
  
  def show
    @photos = @home.photos
    @guest_reviews = @home.guest_reviews
  end
  
  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @home.photos
  end

  def features
  end

  def location
  end
  
  def update
    new_params = home_params
    new_params = home_params.merge(active: true) if is_ready_home

    if @home.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end
  
  def destroy
    # @home = Home.find(params[:id])
    # @home.destroy
  end
  
  # def destroy
    # @listing = Listing.find(params[:id])
    # @home = @lisiting.home

    # @listing.destroy
    # @listings = Listing.where(home_id: @home.id)
    
    # respond_to :js
  # end
  
  #---- RESERVATIONS ----
  def preload
    today = Date.today
    reservations = @home.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)
    unavailable_dates = @home.calendars.where("status = ? AND day > ?", 1, today)

    special_dates = @home.calendars.where("status = ? AND day > ? AND price <> ?", 0, today, @home.price)
    
    render json: {
      reservations: reservations,
      unavailable_dates: unavailable_dates,
      special_dates: special_dates
    }
  end

  # def preview
  #   start_date = Date.parse(params[:start_date])
  #   end_date = Date.parse(params[:end_date])

  #   output = {
  #     conflict: is_conflict(start_date, end_date, @home)
  #   }

  #   render json: output
  # end
  
  # private
  #   def is_conflict(start_date, end_date, home)
  #     check = home.reservations.where("(? < start_date AND end_date < ?) AND status = ?", start_date, end_date, 1)
  #     check_2 = home.calendars.where("day BETWEEN ? AND ? AND status = ?", start_date, end_date, 1).limit(1)
      
  #     check.size > 0 || check_2.size > 0 ? true : false 
  #   end

    def set_home
      @home = Home.find(params[:id])
    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @home.user_id
    end

    def is_ready_home
      !@home.active && !@home.price.blank? && !@home.listing_name.blank? && !@home.photos.blank? && !@home.address.blank?
    end

    def home_params
      params.require(:home).permit(:home_type, :bathrooms, :bedrooms, :listing_name, :summary, :address, :is_pool,
      :is_sauna, :is_hot_tub, :price, :active, :instant)
    end
end