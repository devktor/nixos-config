{pkgs, ...}:
''
  response = $(curl -s wttr.in?format=%c+%t+%w);
  if [$? -eq 0] && [$(echo $response | grep Sorry | wc -l) -eq 0 ];then
    data = $(echo $response|tr " " "\n");
    condition = data[0];
    temperature = data[1];
    wind = data[2];
  fi
''
