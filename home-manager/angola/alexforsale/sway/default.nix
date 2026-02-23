{
  config,
  lib,
  pkgs,
  ...
}:
let
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
  display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
in
{
  home = {
    packages = with pkgs; [
      libnotify
      upower
      pamixer
      wl-clipboard
      wl-color-picker
      wf-recorder
      grim
      slurp
      sway-contrib.grimshot
      wtype
      libreoffice-fresh
      telegram-desktop
      euphonica
    ];
  };

  programs = {
    chromium = {
      enable = true;
      package = pkgs.brave;
      dictionaries = with pkgs; [
        hunspellDictsChromium.en_US
      ];
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "kekjfbackdeiabghhcdklcdoekaanoel" # mal-sync
      ];
    };

    foot = {
      enable = true;
      settings = {
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };

    fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "alacritty";
        };
      };
    };

    mpv = {
      enable = true;
      config = {
        hwdec = "auto";
      };
      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            #uosc
            sponsorblock
            #youtube-upnext
            #youtube-chat
            #thumbnail
            #mpv-cheatsheet
            mpris
            autosubsync-mpv
            autosub
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
            ffmpeg = pkgs.ffmpeg-full;
          };
        }
      );
    };

    swaylock = {
      enable = true;
    };

    zathura = {
      enable = true;
    };
  };

  services = {
    cliphist.enable = true;

    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    mako = {
      enable = true;
      settings = {
        "app-name=changeVolume" = {
          anchor = "bottom-center";
          margin = 10;
        };
        "app-name=changeBrightness" = {
          anchor = "bottom-center";
          margin = 10;
        };
        on-button-left = "invoke-default-action";
        on-button-right = "dismiss";
        border-size = 0;
        border-radius = 10;
        default-timeout = 2000;
        icon-location = "right";
        max-visible = 3;
      };
    };

    network-manager-applet = {
      enable = true;
    };

    polkit-gnome = {
      enable = true;
    };

    swayidle = {
      enable = true;

      events = [
        { event = "before-sleep"; command = (display "off") + "; " + lock; }
        { event = "after-resume"; command = display "on"; }
        { event = "lock"; command = (display "off") + "; " + lock; }
        { event = "unlock"; command = display "on"; }
      ];

      timeouts = [
        {
          timeout = 300;
          command = lock;
        }
        {
          timeout = 600;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 900;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };

    udiskie = {
      enable = true;
      automount = true;
    };
  };

  wayland = {
    systemd.target = "sway-session.target";
    windowManager.sway = {
      checkConfig = true;

      config = {
        left = "h";
        down = "j";
        up = "k";
        right = "l";

        modifier = "Mod4";

        workspaceAutoBackAndForth = true;

        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
            dwtp = "disabled";
            drag_lock = "disabled";
          };
          "type:keyboard" = {
            repeat_delay = "400";
            repeat_rate = "60";
          };
          "10874:38295:CASUE_USB_KB" = {
            xkb_options = "scrolllock:mod3";
          };
        };

        focus = {
          followMouse = true;
        };

        floating = {
          titlebar = false;
        };

        gaps = {
          bottom = 2;
          horizontal = 3;
          inner = 5;
          outer = 5;
          right = 1;
          left = 1;
          top = 2;
          vertical = 2;
          smartGaps = true;
          smartBorders = "on";
        };

        window = {
          titlebar = false;
          commands = [
            {
              criteria = {
                app_id = ".*";
              };
              command = "inhibit_idle fullscreen";
            }
            {
              criteria = {
                class = ".*";
              };
              command = "inhibit_idle fullscreen";
            }
            {
              criteria = {
                app_id = ".*";
              };
              command = "opacity 0.95";
            }
            {
              criteria = {
                app_id = "mpv";
              };
              command = "opacity 1";
            }
            {
              criteria = {
                window_role= "pop-up";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "(?i)blueman.*";
              };
              command = "floating enable; resize set 512 256";
            }
            {
              criteria = {
                app_id = "ncmpcpp";
              };
              command = "floating enable; move scratchpad";
            }
            {
              criteria = {
                app_id = "vim";
              };
              command = "floating disable";
            }
            {
              criteria = {
                app_id = "nmtui";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "khal";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "Gvim";
              };
              command = "floating disable";
            }
            {
              criteria = {
                app_id = ".*pwvucontrol";
              };
              command = "floating enable; resize set 680 680; move position center";
            }
            {
              criteria = {
                app_id = "org.remmina.Remmina";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = ".*";
                title = "Open File.*";
              };
              command = "floating enable; resize set 600 600";
            }
            {
              criteria = {
                app_id = ".*";
                title = "Select Directories";
              };
              command = "floating enable; resize set 600 600";
            }
            {
              criteria = {
                app_id = "brave-browser";
              };
              command = "floating disable";
            }
            {
              criteria = {
                app_id = "brave-browser";
                title = "(?i)sign in.*";
              };
              command = "floating enable; move position center";
            }
            {
              criteria = {
                app_id = "(?i)fileroller";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "(?i)org.kde.kdeconnect.app";
              };
              command = "floating enable; resize set 680 680; move position center";
            }
            {
              criteria = {
                app_id = "(?i)org.kde.kdeconnect-indicator";
                title = "Open.*KDE.*";
              };
              command = "floating enable; move position center";
            }
            {
              criteria = {
                app_id = "transmission-gtk";
                title = "^Torrent Options$";
              };
              command = "floating enable; move position center";
            }
            {
              criteria = {
                title = "File Operation Progress";
              };
              command = "floating enable; move position center";
            }
            {
              criteria = {
                app_id = "org.telegram.desktop";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "discord";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "localsend_app";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "(?i)transmission.*";
              };
              command = "floating enable";
            }
            {
              criteria = {
                app_id = "zenity";
              };
              command = "floating enable";
            }
          ];
        };
        startup = [
          { command = "emacs --fg-daemon"; always = false; }
          { command = "thunar --daemon"; always = false; }
          { command = "alacritty --app-id ncmpcpp -e ncmpcpp"; always = false; }
          { command = "wl-paste --type text --watch cliphist store &"; always = false; }
          { command = "wl-paste --type image --watch cliphist store &"; always = false; }
        ];

        bars = [
        ];

        keybindings = let
          modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            # apps and other common function.
            "${modifier}+v" = "exec pwvucontrol";
            "${modifier}+d" = "exec fuzzel";
            "${modifier}+e" = "exec thunar";
            "${modifier}+q" = "exec ${scripts/sway-fuzzel-powermenu.sh}";
            "${modifier}+Mod1+n" = "exec emacsclient -c -a emacs";
            "${modifier}+Shift+Return" = "exec alacritty -e tmux new -A -s main";
            "${modifier}+f" = "fullscreen toggle; exec notify-send -t 1500 -u low 'fullscreen toggle'";
            "${modifier}+minus" = "scratchpad show; exec notify-send -t 1500 -u low 'toggle scratchpad'";
            "${modifier}+Mod1+k" = "exec alacritty --app-id khal -e khal interactive";
            "${modifier}+Mod1+b" = "exec brave";
            "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
            "${modifier}+Mod1+q" = "exec swaylock";
            "${modifier}+Mod1+v" = "exec alacritty --app-id vim -e nvim";
            "${modifier}+Shift+t" = "exec ${./scripts/sway-tesseract.sh}";
            "${modifier}+o" = "exec sway-easyfocus focus";
            "${modifier}+Shift+o" = "exec sway-easyfocus swap";
            "${modifier}+Mod1+m" = "exec emacsclient -c -a emacs -e '(notmuch)'";
            "${modifier}+Mod1+w" = "exec alacritty --app-id nmtui -e nmtui";
            "${modifier}+Mod1+p" = "exec wl-color-picker";

            # fuzzel stuff
            "${modifier}+c" = "exec cliphist list |fuzzel --dmenu --anchor top-left | cliphist decode | wl-copy";

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
            "${modifier}+Shift+minus" = "move scratchpad; exec notify-send -t 1500 -u low 'moved to scratchpad'";

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
            "XF86MonBrightnessDown" ="exec ${./scripts/set-brightness.sh} 5%-";

            # notification
            "${modifier}+Mod1+grave" = "exec makoctl dismiss";
            "${modifier}+grave" = "exec makoctl invoke";

          };

      };

      enable = true;

      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export CLUTTER_BACKEND="wayland"
        export QT_AUTO_SCREEN_SCALE_FACTOR="1"
        export GTK_USE_PORTALS=1
        export ELECTRON_OZONE_PLATFORM_HINT="wayland"
      '';

      wrapperFeatures.gtk = true;
      xwayland = true;
      systemd = {
        variables = [ "--all" ];
      };
    };
  };
}
