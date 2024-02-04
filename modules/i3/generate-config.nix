{ pkgs, terminal, filemanager, editor, browser, mail, mail_tray, background, ...}:
''
  # i3 config file (v4)
  #
  # Please see http://i3wm.org/docs/userguide.html for a complete reference!

   set $mod Mod4

  # Font for window titles. Will also be used by the bar unless a different font
  # is used in the bar {} block below.
  font pango:DejaVu Sans Mono 17

  # Before i3 v4.8, we used to recommend this one as the default:
  # font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
  # The font above is very space-efficient, that is, it looks good, sharp and
  # clear in small sizes. However, its unicode glyph coverage is limited, the old
  # X core fonts rendering does not support right-to-left and this being a bitmap
  # font, it doesn’t scale on retina/hidpi displays.

  # Use Mouse+$mod to drag floating windows to their wanted position floating_modifier $mod start a terminal 
  bindsym $mod+Return exec ${terminal}
  bindsym $mod+Shift+Return exec ${filemanager}
  # kill focused window
  bindsym $mod+Shift+q kill

  # start dmenu (a program launcher)
  bindsym $mod+d exec ${pkgs.dmenu}/bin/dmenu
  bindsym $mod+Shift+b exec ${browser}
  bindsym $mod+Shift+f exec ${filemanager}
  bindsym $mod+Shift+n exec ${editor}
  bindsym $mod+Shift+m exec ${mail}; 
  bindsym $mod+Shift+t exec ${pkgs.qtox}/bin/qtox;
  bindsym $mod+Shift+k exec ${pkgs.keepassxc}/bin/keepassxc
  bindsym $mod+Shift+s exec ${pkgs.signal-desktop}/bin/signal-desktop
  
  # There also is the (new) i3-dmenu-desktop which only displays applications
  # shipping a .desktop file. It is a wrapper around dmenu, so you need that
  # installed.

  # change focus
  #bindsym $mod+h focus left
  #bindsym $mod+j focus down
  #bindsym $mod+k focus up
  #bindsym $mod+l focus right

  # alternatively, you can use the cursor keys:
   bindsym $mod+Left focus left
   bindsym $mod+Down focus down
   bindsym $mod+Up focus up
   bindsym $mod+Right focus right

  # move focused window
  # bindsym $mod+Shift+h move left
  # bindsym $mod+Shift+j move down
  # bindsym $mod+Shift+k move up
  #bindsym $mod+Shift+l move right

  # alternatively, you can use the cursor keys:
  bindsym $mod+Shift+Left move left
  bindsym $mod+Shift+Down move down
  bindsym $mod+Shift+Up move up
  bindsym $mod+Shift+Right move right

  # split in horizontal orientation
  bindsym $mod+h split h

  # split in vertical orientation
  bindsym $mod+v split v

  # enter fullscreen mode for the focused container
  bindsym $mod+f fullscreen toggle

  # change container layout (stacked, tabbed, toggle split)
  # bindsym $mod+s layout stacking
  # bindsym $mod+w layout tabbed
  # bindsym $mod+e layout toggle split

  # toggle tiling / floating
  # bindsym $mod+Shift+space floating toggle

  # change focus between tiling / floating windows
  # bindsym $mod+space focus mode_toggle

  # focus the parent container
  # bindsym $mod+a focus parent

  # focus the child container
  # bindsym $mod+d focus child

  # switch to workspace
  bindsym $mod+1 workspace 1
  bindsym $mod+2 workspace 2
  bindsym $mod+3 workspace 3
  bindsym $mod+4 workspace 4
  bindsym $mod+5 workspace 5
  bindsym $mod+6 workspace 6
  bindsym $mod+7 workspace 7
  bindsym $mod+8 workspace 8
  bindsym $mod+9 workspace 9
  bindsym $mod+0 workspace 10

  # move focused container to workspace
  bindsym $mod+Shift+1 move container to workspace 1
  bindsym $mod+Shift+2 move container to workspace 2
  bindsym $mod+Shift+3 move container to workspace 3
  bindsym $mod+Shift+4 move container to workspace 4
  bindsym $mod+Shift+5 move container to workspace 5
  bindsym $mod+Shift+6 move container to workspace 6
  bindsym $mod+Shift+7 move container to workspace 7
  bindsym $mod+Shift+8 move container to workspace 8
  bindsym $mod+Shift+9 move container to workspace 9
  bindsym $mod+Shift+0 move container to workspace 10

  # Pulse Audio controls
  # run pactl list sinks
  bindsym XF86AudioRaiseVolume exec --no-startup-id amixer set Master 5%+ #increase sound volume
  bindsym XF86AudioLowerVolume exec --no-startup-id amixer set Master 5%- #decrease sound volume
  bindsym XF86AudioMute exec --no-startup-id amixer set Master toggle # mute sound

  # Sreen brightness controls
  bindsym XF86MonBrightnessUp exec brightnessctl set 5%+ # increase screen brightness
  bindsym XF86MonBrightnessDown exec brightnessctl set 5%- # decrease screen brightness

  # multimedia keys
  #bindsym XF86AudioPlay  exec "mpc toggle"
  #bindsym XF86AudioStop  exec "mpc stop"
  #bindsym XF86AudioNext  exec "mpc next"
  #bindsym XF86AudioPrev  exec "mpc prev"
  #bindsym XF86AudioPause exec "mpc pause"

  # reload the configuration file
  bindsym $mod+Shift+c reload
  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  bindsym $mod+Shift+r restart
  # exit i3 (logs you out of your X session)


  # resize window (you can also use the mouse for that)
  mode "resize" {
          # These bindings trigger as soon as you enter the resize mode

          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height.
          bindsym h resize shrink width 10 px or 10 ppt
          bindsym j resize grow height 10 px or 10 ppt
          bindsym k resize shrink height 10 px or 10 ppt
          bindsym l resize grow width 10 px or 10 ppt

          # same bindings, but for the arrow keys
          bindsym Left resize shrink width 10 px or 10 ppt
          bindsym Down resize grow height 10 px or 10 ppt
          bindsym Up resize shrink height 10 px or 10 ppt
          bindsym Right resize grow width 10 px or 10 ppt

          # back to normal: Enter or Escape
          bindsym Return mode "default"
          bindsym Escape mode "default"
  }

  bindsym $mod+r mode "resize"

  # Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)

  gaps inner 10
  gaps outer 5

  exec_always ${pkgs.feh}/bin/feh --bg-scale ${background}
  exec_always ${pkgs.polybar}/bin/polybar-msg cmd quit || ${pkgs.polybar}/bin/polybar -c /etc/polybar/config.ini work
  #exec --no-startup-id i3-msg "workspace 2; exec ${mail}"
  exec --no-startup-id ${mail_tray}
  exec --no-startup-id ${pkgs.protonmail-bridge}/bin/protonmail-bridge
  exec --no-startup-id ${pkgs.spotify-tray}/bin/spotify-tray -m
  exec_always --no-startup-id i3-msg workspace 1
''
