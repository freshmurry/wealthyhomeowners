class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @homes = current_user.homes
  end
end