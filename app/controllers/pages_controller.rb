class PagesController < ApplicationController
  def home
    @homes = Home.where(active: true)
  end

  def search
    # STEP 1
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    # STEP 2
    if session[:loc_search] && session[:loc_search] != ""
      @homes_address = Home.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @homes_address = Home.where(active: true).all
    end

    # STEP 3
    @search = @homes_address.ransack(params[:q])
    @homes = @search.result

    @arrHomes = @homes.to_a

    # STEP 4
    # if (params[:start_date] && params[:end_date] && !params[:start_date].empty? &&  !params[:end_date].empty?)
      
    #   start_date = Date.parse(params[:start_date])
    #   end_date = Date.parse(params[:end_date])

      @homes.each do |home|

    #     not_available = home.reservations.where(
    #       "((? <= start_date AND start_date <= ?)
    #       OR (? <= end_date AND end_date <= ?)
    #       OR (start_date < ? AND ? < end_date))
    #       AND status = ?",
    #       start_date, end_date,
    #       start_date, end_date,
    #       start_date, end_date,
    #       1
    #     ).limit(1)
        
    #     not_available_in_calendar = Calendar.where(
    #       "home_id = ? AND status = ? AND day <= ? AND day >= ?",
    #       home.id, 1, end_date, start_date
    #     ).limit(1)
        
    #     if not_available.length > 0 || not_available_in_calendar.length > 0
    #       @arrHomes.delete(home)
    #     end
      # end
    end

  end
end