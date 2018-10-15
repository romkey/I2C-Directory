require 'csv'
require 'pp'

class AdminController < ApplicationController
  before_action :authenticate_user!

  def index
    @most_views = Device.order(views: :desc).limit(20)
    @suggestions = Device.suggestions.order(created_at: :desc).limit(20)
    @datasheet_suggestions = Device.where("datasheet IS NULL OR datasheet = ''").joins(:datasheet_suggestions).group('devices.id').order(:part_number)
    @driver_suggestions = Device.where("drivers = '[]'").joins(:datasheet_suggestions).group('devices.id').order(:part_number)
  end

  def clear_database
    Device.delete_all

    redirect_to devices_path
  end

  def backup
  end

  def stats
  end

  # CSV
  # manufacturer, part number, friendly name, datasheet, addresses (space delimited)
  def import
    pp params

    uploaded = params[:csv]
    count = Device.import uploaded
    redirect_to '/devices', notice: "#{count} devices imported"
  end
end
