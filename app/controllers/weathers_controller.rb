require 'open_weather'
class WeathersController < ApplicationController
  before_action :set_weather, only: [:show, :edit, :update, :destroy]

  # GET /weathers
  # GET /weathers.json
  def index
    @weathers = Weather.all
  end

  # GET /weathers/1
  # GET /weathers/1.json
  def show
  end

  # GET /weathers/new
  def new
    @weather = Weather.new
    @weathers = Weather.group(:city)
  end

  # GET /weathers/1/edit
  def edit
  end

  def searched
    city = params[:city]
    id = params[:city_id]
    options_days = { units: "metric", APPID: "18107de29a0ba76acdaf2a3f5eb9b3c6" , mode:  'xml', cnt: 12 }
    $next_days = OpenWeather::Forecast.city("#{city}", options_days )
    options_current = { units: "metric", APPID: "18107de29a0ba76acdaf2a3f5eb9b3c6" }
    $weather = OpenWeather::Current.city("#{city}", options_current )
    redirect_to :action => "show", :id => id
  end

  # POST /weathers
  # POST /weathers.json
  def create
    @weather = Weather.new(weather_params)
    options_days = { units: "metric", APPID: "18107de29a0ba76acdaf2a3f5eb9b3c6" , mode:  'xml', cnt: 12 }
    $next_days = OpenWeather::Forecast.city("#{@weather.city}", options_days )
    options_current = { units: "metric", APPID: "18107de29a0ba76acdaf2a3f5eb9b3c6" }
    $weather = OpenWeather::Current.city("#{@weather.city}", options_current )
    respond_to do |format|
      if @weather.save
        format.html { redirect_to @weather, notice: 'Weather was successfully created.' }
        format.json { render :show, status: :created, location: @weather }
      else
        format.html { render :new }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weathers/1
  # PATCH/PUT /weathers/1.json
  def update
    respond_to do |format|
      if @weather.update(weather_params)
        format.html { redirect_to @weather, notice: 'Weather was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather }
      else
        format.html { render :edit }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathers/1
  # DELETE /weathers/1.json
  def destroy
    @weather.destroy
    respond_to do |format|
      format.html { redirect_to weathers_url, notice: 'Weather was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather = Weather.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_params
      params.require(:weather).permit(:city)
    end
end
