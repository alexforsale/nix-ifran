{
  config,
  lib,
  ...
}:
{
  wayland.windowManager.sway = {
    config = {
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          # apps and other common function.
          "${modifier}+v" = "exec pwvucontrol";
          "${modifier}+d" = "exec fuzzel";
          "${modifier}+e" = "exec thunar";
          "${modifier}+q" = "exec ${scripts/sway-fuzzel-powermenu.sh}";
          "${modifier}+Mod1+n" = "exec emacsclient -c -a emacs";
          "${modifier}+Shift+Return" = "exec foot -e tmux new -A -s main";
          "${modifier}+f" = "fullscreen toggle; exec notify-send -t 1500 -u low 'fullscreen toggle'";
          "${modifier}+minus" = "scratchpad show; exec notify-send -t 1500 -u low 'toggle scratchpad'";
          "${modifier}+Mod1+k" = "exec foot --app-id khal -e khal interactive";
          "${modifier}+Mod1+b" = "exec brave";
          "${modifier}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          "${modifier}+Mod1+q" = "exec swaylock-fancy";
          "${modifier}+Mod1+v" = "exec foot --app-id vim -e nvim";
          "${modifier}+Shift+t" = "exec ${./scripts/sway-tesseract.sh}";
          "${modifier}+o" = "exec sway-easyfocus focus";
          "${modifier}+Shift+o" = "exec sway-easyfocus swap";
          "${modifier}+Mod1+m" = "exec emacsclient -c -a emacs -e '(notmuch)'";
          "${modifier}+Mod1+w" = "exec foot --app-id nmtui -e nmtui";
          "${modifier}+Mod1+p" = "exec wl-color-picker";

          # kill
          "${modifier}+Shift+q" = "kill";

          # fuzzel stuff
          "${modifier}+c" =
            "exec cliphist list |fuzzel --dmenu --anchor top-left | cliphist decode | wl-copy";

          # screenshot
          "Print" = "exec bash ${./scripts/sway-grimshot.sh} screen";
          "Control+Print" = "exec bash ${./scripts/sway-grimshot.sh} active";
          "Mod1+Print" = "exec bash ${./scripts/sway-grimshot.sh} area";
          "${modifier}+Shift+s" = "exec bash ${./scripts/sway-grimshot.sh} area";

          # screen-record
          "${modifier}+Print" = "exec bash ${./scripts/sway-screen-record.sh}";

          # movement keys
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Left" = "focus left";
          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Right" = "focus right";

          # moving container
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Right" = "move right";

          # move  to output
          "${modifier}+Mod1+l" = "move workspace to output right";
          "${modifier}+Mod1+h" = "move workspace to output left";

          # layout
          "${modifier}+Control+h" = "split h; exec notify-send -t 1500 -u low 'horizontal split'";
          "${modifier}+Control+v" = "split v; exec notify-send -t 1500 -u low 'vertical split'";
          "${modifier}+Control+s" = "layout stacking; exec notify-send -t 1500 -u low 'layout stacking'";
          "${modifier}+Control+w" = "layout tabbed; exec notifiy-send -t 1500 -u low 'layout tabbed'";
          "${modifier}+Control+e" = "layout toggle split; exec notify-send -t 1500 -u low 'split toggle'";
          "${modifier}+space" = "focus mode_toggle; exec notify-send -t 1500 -u low 'window focus toggle'";
          "${modifier}+Control+a" = "focus parent; exec notify-send -t 1500 -u low 'focus parent container'";
          "${modifier}+Control+d" = "focus child; exec notify-send -t 1500 -u low 'focus child container'";
          "${modifier}+Shift+minus" =
            "move scratchpad; exec notify-send -t 1500 -u low 'moved to scratchpad'";

          # workspace
          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+6" = "workspace 6";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";
          "${modifier}+0" = "workspace 10";
          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";
          "${modifier}+Shift+6" = "move container to workspace 6";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";
          "${modifier}+Shift+0" = "move container to workspace 10";

          "${modifier}+bracketleft" = "workspace prev";
          "${modifier}+bracketright" = "workspace next";
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+Shift+Tab" = "move container3 to workspace back_and_forth";
          "${modifier}+Shift+r" = "restart";

          # media keys
          "${modifier}+F11" = "exec playerctl play-pause";
          "${modifier}+F12" = "exec playerctl next";
          "${modifier}+F10" = "exec playerctl previous";
          "${modifier}+F7" = "exec --no-startup-id ${./scripts/set-volume.sh} -t";
          "${modifier}+F8" = "exec --no-startup-id ${./scripts/set-volume.sh} -d 5";
          "${modifier}+F9" = "exec --no-startup-id ${./scripts/set-volume.sh} -i 5";

          "XF86AudioLowerVolume" = "exec ${./scripts/set-volume.sh} -d 5";
          "XF86AudioRaiseVolume" = "exec ${./scripts/set-volume.sh} -i 5";
          "XF86AudioMute" = "exec ${./scripts/set-volume.sh} -t";
          "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86MonBrightnessUp" = "exec ${./scripts/set-brightness.sh} +5%";
          "XF86MonBrightnessDown" = "exec ${./scripts/set-brightness.sh} 5%-";

          # notification
          "${modifier}+Mod1+grave" = "exec makoctl dismiss";
          "${modifier}+grave" = "exec makoctl invoke";

        };
    };
  };
}
