#!/bin/bash

shell_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
cache_dir="$HOME/.cache/weather"
cache="${cache_dir}/weather1day.json"
config="$shell_dir/../config.json"

KEY="$(cat $config | jq -r '.weather.apikey')"
LAT="$(cat $config | jq -r '.weather.lat')"
LONG="$(cat $config | jq -r '.weather.lon')"
UNIT="$(cat $config | jq -r '.weather.unit')"

if [[ ! -d "$cache_dir" ]]; then
	mkdir ${cache_dir}
fi

while true; do
  weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid="$KEY"&lat="$LAT"&lon="$LONG"&units="$UNIT"")
	##echo $weather
	if [ ! -z "$weather" ]; then
		weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
		weather_icon_code=$(echo "$weather" | jq -r ".weather[].icon" | head -1)
		weather_description=$(echo "$weather" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g")

		#Big long if statement of doom
		if [ "$weather_icon_code" == "50d" ]; then
			weather_icon=""
			weather_quote="Forecast says it's misty | Make sure you don't get lost on your way..."
			weather_color="color10"
		elif [ "$weather_icon_code" == "50n" ]; then
			weather_icon=""
			weather_quote="Forecast says it's a misty night | Don't go anywhere tonight or you might get lost..."
			weather_color="color10"
		elif [ "$weather_icon_code" == "01d" ]; then
			weather_icon=""
			weather_quote="It's a sunny day, gonna be fun! | Don't go wandering all by yourself though..."
			weather_color="color9"
		elif [ "$weather_icon_code" == "01n" ]; then
	 		weather_icon=""
			weather_quote="It's a clear night | You might want to take a evening stroll to relax..."
			weather_color="color10"
		elif [ "$weather_icon_code" == "02d" ]; then
			weather_icon=""
			weather_quote="It's  cloudy, sort of gloomy | You'd better get a book to read..."
			weather_color="color2"
		elif [ "$weather_icon_code" == "02n" ]; then
			weather_icon=""
			weather_quote="It's a cloudy night | How about some hot chocolate and a warm bed?"
			weather_color="color6"
		elif [ "$weather_icon_code" == "03d" ]; then
			weather_icon=""
			weather_quote="It's  cloudy, sort of gloomy | You'd better get a book to read..."
			weather_color="color2"
		elif [ "$weather_icon_code" == "03n" ]; then
			weather_icon=""
			weather_quote="It's a cloudy night | How about some hot chocolate and a warm bed?"
			weather_color="color6"
		elif [ "$weather_icon_code" == "04d" ]; then
			weather_icon=""
			weather_quote="It's  cloudy, sort of gloomy | You'd better get a book to read..."
			weather_color="color2"
		elif [ "$weather_icon_code" == "04n" ]; then
			weather_icon=""
			weather_quote="It's a cloudy night | How about some hot chocolate and a warm bed?"
			weather_color="color6"
		elif [ "$weather_icon_code" == "09d" ]; then
			weather_icon=""
			weather_quote="It's rainy, it's a great day! | Get some ramen and watch as the rain falls..."
			weather_color="color11"
		elif [ "$weather_icon_code" == "09n" ]; then
			weather_icon=""
			weather_quote=" It's gonna rain tonight it seems | Make sure your clothes aren't still outside..."
			weather_color="color13"
		elif [ "$weather_icon_code" == "10d" ]; then
			weather_icon=""
			weather_quote="It's rainy, it's a great day! | Get some ramen and watch as the rain falls..."
			weather_color="color11"
		elif [ "$weather_icon_code" == "10n" ]; then
			weather_icon=""
			weather_quote=" It's gonna rain tonight it seems | Make sure your clothes aren't still outside..."
			weather_color="color13"
		elif [ "$weather_icon_code" == "11d" ]; then
			weather_icon=""
			weather_quote="There's storm for forecast today | Make sure you don't get blown away..."
			weather_color="color9"
		elif [ "$weather_icon_code" == "11n" ]; then
			weather_icon=""
			weather_quote="There's gonna be storms tonight | Make sure you're warm in bed and the windows are shut..."
			weather_color="color9"
		elif [ "$weather_icon_code" == "13d" ]; then
			weather_icon=""
			weather_quote="It's gonna snow today | You'd better wear thick clothes and make a snowman as well!"
			weather_color="color15"
		elif [ "$weather_icon_code" == "13n" ]; then
			weather_icon=""
			weather_quote="It's gonna snow tonight | Make sure you get up early tomorrow to see the sights..."
			weather_color="color15"
		elif [ "$weather_icon_code" == "40d" ]; then
			weather_icon=""
			weather_quote="Forecast says it's misty | Make sure you don't get lost on your way..."
			weather_color="color10"
		elif [ "$weather_icon_code" == "40n" ]; then
			weather_icon=""
			weather_quote="Forecast says it's a misty night | Don't go anywhere tonight or you might get lost..."
			weather_color="color2"
    else
			weather_icon=""
			weather_quote="Sort of odd, I don't know what to forecast | Make sure you have a good time!"
			weather_color="color15"
		fi
    echo "{" >$cache
		echo "\"icon\": \"$weather_icon\"," >>$cache
		echo "\"des\": \"$weather_description\"," >>$cache
		echo "\"temp\": \"${weather_temp}°C\"," >>$cache
    echo "\"quote1\": \"$(echo $weather_quote | cut -d'|' -f1)\"," >>$cache
    echo "\"quote2\": \"$(echo $weather_quote | cut -d'|' -f2)\"," >>$cache
		echo "\"color\": \"$weather_color\"" >>$cache # currently only work with colorz as pywal16 backend
    echo "}" >>$cache
  else
    echo lol
		#echo "Weather Unavailable" >${cache_weather_stat}
		#echo "" >${cache_weather_icon}
		#echo -e "Ah well, no weather huh? | Even if there's no weather, it's gonna be a great day!" >${cache_weather_quote}
		#echo "-" >${cache_weather_degree}
		#echo "color15" >${cache_weather_hex}
	fi
  sleep 1800
done
