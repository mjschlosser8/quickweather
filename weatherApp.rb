# Designed by Matt Schlosser
require 'httparty'
require "addressable/uri"

print 'Please enter your zip code (US only for now): '
zip = gets.to_s.chomp
url = "https://api.openweathermap.org/data/2.5/weather?zip=" + "#{zip}" + "&units=imperial&APPID=486516e4f171e6170947f80ba3e533f9"
encoded_url = URI.encode(url)
response = HTTParty.get(encoded_url).to_s

#----- CONDITIONS
puts "____________________"
puts " "
puts "Hello there!"
puts " "
location = JSON.parse(response)["name"]
puts "Currently in " + location + ":"

temp = JSON.parse(response)["main"]["temp"].to_s
puts "Temp: " + temp + " F"

if temp > '90'
  puts "Yowza! That's hot!"
elsif temp >= '70' and temp <= '89'
  puts "It's pretty warm out!"
elsif temp >= '50' and temp <= '69'
  puts "Feels pretty moderate, like springtime."
elsif temp >= '31' and temp <= '49'
  puts "It's cold!"
elsif temp <= '30'
  puts "It's freezing out, man!"
end

weathercon = JSON.parse(response)["weather"][0]["main"]
weatherdesc = JSON.parse(response)["weather"][0]["description"]
puts "Conditions: " + weathercon
puts "That " + weathercon + " is " + weatherdesc
puts "____________________"

#Five day forecast
puts "Here's your five-day forecast:"
five_day_url = "https://api.openweathermap.org/data/2.5/forecast?zip=" + "#{zip}" + "&units=imperial&APPID=486516e4f171e6170947f80ba3e533f9"
five_day_encoded_url = URI.encode(five_day_url)
five_day_response = HTTParty.get(five_day_encoded_url).to_s
forecast = JSON.parse(five_day_response)
puts forecast["list"]["weather"]['main']
#forecast["list"]["weather"].each do
#  print ["main"]
#end
