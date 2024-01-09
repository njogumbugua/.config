#!/usr/bin/env lua
-- load the http socket module
local http = require("socket.http")
-- load the json module
local json = require("json")

local api_url = "https://api.openweathermap.org/data/2.5/onecall?"

-- Your lattitude and longitude
LAT = 51.509865
LON = -0.118092

-- metric or imperial
local cf = "metric"

-- get an open weather map api key: http://openweathermap.org/appid
local apikey = "api-key"

-- measure is °C if metric and °F if imperial
local measure = "°" .. (cf == "metric" and "C" or "F")
local wind_units = (cf == "metric" and "km/h" or "mph")

-- Unicode weather symbols to use
local icons = {
	["01"] = "☀",
	["02"] = "🌤",
	["03"] = "🌥",
	["04"] = "☁",
	["09"] = "🌧",
	["10"] = "🌦",
	["11"] = "🌩",
	["13"] = "🌨",
	["50"] = "🌫",
}

local currenttime = os.date("!%Y%m%d%H%M%S")

local file_exists = function(name)
	local f = io.open(name, "r")
	if f ~= nil then
		f:close()
		return true
	else
		return false
	end
end

if file_exists("weather.json") then
	local cache = io.open("weather.json", "r")
	local data = json.decode(cache:read())
	cache:close()
	local timepassed = os.difftime(currenttime, data.timestamp)
else
	local timepassed = 6000
end

local makecache = function(s)
	local cache = io.open("weather.json", "w+")
	s.timestamp = currenttime
	local save = json.encode(s)
	cache:write(save)
	cache:close()
end

if timepassed < 3600 then
	response = data
else
	local weather = http.request(
		("%slat=%s&lon=%s&exclude=minutely,hourly&units=%s&APPID=%s"):format(api_url, LAT, LON, cf, apikey)
	)
	if weather then
		local response = json.decode(weather)
		makecache(response)
	else
		local response = data
	end
end

math.round = function(n)
	return math.floor(n + 0.5)
end

local degrees_to_direction = function(d)
	local val = math.round(d / 22.5)
	local directions = {
		[0] = "N",
		[1] = "NNE",
		[2] = "NE",
		[3] = "ENE",
		[4] = "E",
		[5] = "ESE",
		[6] = "SE",
		[7] = "SSE",
		[8] = "S",
		[9] = "SSW",
		[10] = "SW",
		[11] = "WSW",
		[12] = "W",
		[13] = "WNW",
		[14] = "NW",
		[15] = "NNW",
	}
	return directions[val % 16]
end

local temp = response.current.temp
local min = response.daily[1].temp.min
local max = response.daily[1].temp.max
local conditions = response.current.weather[1].description
local icon2 = response.current.weather[1].id
local icon = response.current.weather[1].icon:sub(1, 2)
local humidity = response.current.humidity
local wind = response.current.wind_speed
local deg = degrees_to_direction(response.current.wind_deg)
local sunrise = os.date("%H:%M", response.current.sunrise)
local sunset = os.date("%H:%M", response.current.sunset)
local forcast_icon = response.daily[2].weather[1].icon:sub(1, 2)
local forcast_temp = response.daily[2].temp.day
local forcast_conditions = response.daily[2].weather[1].main

local conky_text = [[
${font Symbola:size=48}%s ${voffset -10}${font :size=20}${color1}%s${font}${voffset -5}%s${color}
${alignc}${voffset 28} %s
${alignc}High: ${color1}%s%s    ${color}Low: ${color1}%s%s${color}
${alignc}Humidity: ${color1}%s%%${color}
${alignc}Wind: ${color1}%s%s %s${color}
${alignc}Tomorrow:
${alignc}${color1}${font Symbola:size=20}%s${font} %s%s %s${color}
${alignc}${font Symbola:size=20}─☀─${font}
${alignc}${color1}%s${color} | ${color1}%s${color}
]]
io.write(
	(conky_text):format(
		icons[icon],
		math.round(temp),
		measure,
		conditions,
		math.round(max),
		measure,
		math.round(min),
		measure,
		humidity,
		math.round(wind),
		wind_units,
		deg,
		icons[forcast_icon],
		math.round(forcast_temp),
		measure,
		forcast_conditions,
		sunrise,
		sunset
	)
)
