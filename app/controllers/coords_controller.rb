require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    
    if (val=params[:address]).blank? == true
        @address = "Corner of Foster and Sheridan"
    else
    @address = params[:address]
    end

     @url_safe_address = URI.encode(@address)
    url_a = "http://maps.googleapis.com/maps/api/geocode/json?address="+ @url_safe_address +"&sensor=false"
    raw_data = open(url_a).read
    parsed_data = JSON.parse(raw_data)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    @your_api_key = "1da527e2fe88c3b347ef24bc4348aa72"

 
     url_b = "https://api.forecast.io/forecast/" + @your_api_key + "/" + @latitude.to_s+ "," + @longitude.to_s
     raw_data = open(url_b).read
     parsed_data = JSON.parse(raw_data)
     @temperature = parsed_data["currently"]["temperature"]
     @minutely_summary = parsed_data["minutely"]["summary"]
     @hourly_summary = parsed_data["hourly"]["summary"]
     @daily_summary = parsed_data["daily"]["summary"]
  end
end
