class AdminController < ApplicationController
  before_action :authenticate_user!

  def clear_database
    Device.delete_all

    redirect_to devices_path
  end

  def backup
  end

  def stats
  end
end
