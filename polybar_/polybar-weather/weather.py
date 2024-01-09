import os
import configparser
import requests

import sys

# Read config file
config = configparser.ConfigParser()
config.read(f"{sys.argv[1]}/config.ini")

dict_weather_group_icon = {
    200: "",
    300: "",
    500: "",
    600: "",
    700: "",
    800: ["", ""],
    801: ["", ""],
    802: "",
    803: "",
    804: "",
}

URL = "http://api.openweathermap.org/data/2.5/onecall?lat={}&lon={}&units={}&exclude=minutely,hourly,daily,alerts&appid={}"
url_formated = URL.format(
    config["OPENWEATHERMAP"]["lat"],
    config["OPENWEATHERMAP"]["lon"],
    config["OPENWEATHERMAP"]["units"],
    config["OPENWEATHERMAP"]["appid"],
)

# get data
try:
    json_answer = requests.get(url_formated).json()
except:
    print("")
    exit()
current = json_answer["current"]

# get weather icon
weather_id = current["weather"][0]["id"]
weather_icon = dict_weather_group_icon.get(weather_id, (weather_id // 100) * 100)

# Dirty hack
if isinstance(weather_icon, int):
    weather_icon = dict_weather_group_icon.get((weather_id // 100) * 100, "")

if isinstance(weather_icon, list):
    weather_icon = (
        weather_icon[0]
        if current["sunrise"] < current["dt"] < current["sunset"]
        else weather_icon[1]
    )

# get unit
unit = str(round(current["temp"])) + "°"
degree = unit + "C" if config["OPENWEATHERMAP"]["units"] == "METRIC" else unit + "F"

print(f"{weather_icon} {degree}")
