#!/usr/bin/lua
local https = require("ssl.https")
local json = require("json")

-- To use edit variables below for your timezone and location then add the next line to your conky config, uncommented
-- ${alignc}${execpi 3600 ~/.config/conky/moonphase.lua}

-- Change to your timezone offset
local tz = "-0"

-- Change to the lattitude and longitude you want to use
local lat = "51.5"
local long = "-0.116667"
local curdate = os.date("!%Y%m%d")
local curtime = os.date("!%Y%m%d%H%M%S")
local api_url = ("https://api.solunar.org/solunar/%s,%s,%s,%s"):format(lat, long, curdate, tz)

local moon = {
	["New Moon"] = "🌑",
	["Waxing Crescent"] = "🌒",
	["First Quarter"] = "🌓",
	["Waxing Gibbous"] = "🌔",
	["Full moon"] = "🌕",
	["Waning Gibbous"] = "🌖",
	["Third Quarter"] = "🌗",
	["Waning Crescent"] = "🌘",
}

local file_exists = function(name)
	local f = io.open(name, "r")
	if f ~= nil then
		f:close()
		return true
	else
		return false
	end
end

if file_exists("moonphase.json") then
	local cache = io.open("moonphase.json", "r")
	local data = json.decode(cache:read())
	cache:close()
	local timepassed = os.difftime(curtime, data.timestamp)
else
	local timepassed = 6000
end
local makecache = function(s)
	local cache = io.open("moonphase.json", "w+")
	s.timestamp = curtime
	local save = json.encode(s)
	cache:write(save)
	cache:close()
end

if timepassed < 3600 then
	local response = data
else
	local mooninfo = https.request(api_url)
	if mooninfo then
		local response = json.decode(mooninfo)
		makecache(response)
	else
		response = data
	end
end

local phase = response.moonPhase

local conky_text = [[${font Symbola:size=20}%s${font} %s]]

io.write((conky_text):format(moon[phase], phase))
