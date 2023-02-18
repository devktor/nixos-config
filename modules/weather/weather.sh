  response=$(curl -s wttr.in?format=%c+%t+%w);
  if [ $? -eq 0 ]&&[ $(echo $response | grep Sorry | wc -l) -eq 0 ];
  then
    data=($response);
    condition=${data[0]};
    temperature=${data[1]};
    wind=${data[2]};
    echo "condition = $codtition";
    echo "temperature = $temperature";
    echo "wind = $wind";
  fi
