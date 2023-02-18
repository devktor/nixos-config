#!/bin/bash

if [ $(curl -s wttr.in | grep Sorry | wc -l) -eq 0 ] && [ $(curl -s wttr.in | grep Weather | wc -l) -eq 1 ]
    then
        weather=$(curl -s wttr.in?format="%c+%m+%t+%S+%s")
        # condition=$(echo $weather | cut -d " " -f 1)
        condition=$(echo $weather | awk '{print substr($0,1,1);exit}')
        moonphase=$(echo $weather | cut -d " " -f 2)
        temperature=$(echo $weather | cut -d " " -f 3 | sed s/+//)
        sunrise=$(echo $weather | cut -d " " -f 4)
        sunset=$(echo $weather | cut -d " " -f 5)
        if [[ "$(date +%H:%M:%S)" > "$sunrise" ]] && [[ "$(date +%H:%M:%S)" < "$sunset" ]]
            then
                echo "$condition $temperature"
            else
                echo "$moonphase $temperature"
        fi
    else
        echo "%{F#ffb86c}  %{F-}n/a"
fi
