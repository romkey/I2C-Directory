class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  # GET /devices
  # GET /devices.json
  def index
    @devices = if params[:q]
                 Device.where("part_number ILIKE '%#{params[:q]}%' OR friendly_name ILIKE '%#{params[:q]}%' OR manufacturer ILIKE '%#{params[:q]}%'").order(part_number: :asc)
               else
                 Device.order(part_number: :asc)
               end

    if user_signed_in?
      if params[:suggestion]
        @devices = @devices.suggestions
      else
        @devices = @devices.published
      end
    else
      @devices = @devices.published
    end

    respond_to do |format|
      format.html {
        @devices = @devices.paginate(page: params[:page])
        render :index
      }

      format.json {
        headers['Content-Disposition'] = 'attachment; filename="i2c-devices.json"'
        headers['Content-Type'] ||= 'application/json'
        send_data @devices.to_json, filename: 'devices.json'
      }

      format.cpp {
        headers['Content-Disposition'] = 'attachment; filename="i2cscanner_devices.cpp'
        headers['Content-Type'] ||= 'text/x-c'
        render 'i2c_scanner_devices.cpp', filename: 'i2c_scanner_devices.cpp'
      }

      format.rss {
        @devices = @devices.order(created_at: :desc).limit(20)
        render 'feed', layout: false
      }
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
    @suggestion = params[:suggestion] || false
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /devices
  # POST /devices.json
  def suggest
    @device = Device.new(device_params, suggestion: true)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find_by slug: params[:slug]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:part_number, :friendly_name, :addresses, :manufacturer, :suggestion, :obsolete, :datasheet, :adafruit, :sparkfun, :amazon, address_ids: [])
    end
end
