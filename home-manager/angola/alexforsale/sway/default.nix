{
  config,
  lib,
  pkgs,
  ...
}:
let
  lock = "${pkgs.swaylock-fancy}/bin/swaylock-fancy --daemonize";
  display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
  cursor.theme.name = "phinger-cursors-dark";
  cursor.theme.package = pkgs.phinger-cursors;
  iconTheme.name = "Nordzy-green-dark";
  iconTheme.package = pkgs.nordzy-icon-theme;
  gtkTheme.name = "Gruvbox-Dark";
  colors = {
    rgb = {
      base00 = "#282828";
      base01 = "#3c3836";
      base02 = "#504945";
      base03 = "#665c54";
      base04 = "#928374";
      base05 = "#ebdbb2";
      base06 = "#fbf1c7";
      base07 = "#f9f5d7";
      base08 = "#cc241d";
      base09 = "#d65d0e";
      base0A = "#d79921";
      base0B = "#98971a";
      base0C = "#689d6a";
      base0D = "#458588";
      base0E = "#b16286";
      base0F = "#9d0006";
      base10 = "#2a2520";
      base11 = "#1d1d1d";
      base12 = "#fb4934";
      base13 = "#fabd2f";
      base14 = "#b8bb26";
      base15 = "#8ec07c";
      base16 = "#83a598";
      base17 = "#d3869b";
      base18 = "#5f676a";
      base19 = "#484e50";
      base20 = "#a89984";
      base21 = "#292d2e";
      base22 = "#222222";
      base23 = "#2e9ef4";
    };
    rgba = {
      base00 = "282828ff";
      base01 = "3c3836ff";
      base02 = "504945ff";
      base03 = "665c54ff";
      base04 = "928374ff";
      base05 = "ebdbb2ff";
      base06 = "fbf1c7ff";
      base07 = "f9f5d7ff";
      base08 = "cc241dff";
      base09 = "d65d0eff";
      base0A = "d79921ff";
      base0B = "98971aff";
      base0C = "689d6aff";
      base0D = "458588ff";
      base0E = "b16286ff";
      base0F = "9d0006ff";
      base10 = "2a2520ff";
      base11 = "1d1d1dff";
      base12 = "fb4934ff";
      base13 = "fabd2fff";
      base14 = "b8bb26ff";
      base15 = "8ec07cff";
      base16 = "83a598ff";
      base17 = "d3869bff";
      base18 = "5f676aff";
      base19 = "484e50ff";
      base20 = "a89984ff";
      base21 = "292d2eff";
      base22 = "222222ff";
      base23 = "2e9ef4ff";
    };
  };
in
{
  imports = [
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = cursor.theme.name;
      package = cursor.theme.package;
      size = 24;
    };
    iconTheme = {
      name = iconTheme.name;
      package = iconTheme.package;
    };
    theme = {
      name = gtkTheme.name;
    };
  };

  home = {
    pointerCursor = {
      name = cursor.theme.name;
      package = cursor.theme.package;
      size = 24;
      sway.enable = true;
    };

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
      pwvucontrol
      tesseract5
      nerd-fonts.iosevka
      nerd-fonts.dejavu-sans-mono
      twitter-color-emoji
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
          terminal = "${pkgs.foot}/bin/foot";
          font = "Iosevka Nerd Font:size=10";
          match-counter = true;
        };
        colors = {
          background = colors.rgba.base00;
          text = colors.rgba.base07;
          prompt = colors.rgba.base06;
          placeholder = colors.rgba.base05;
          input = colors.rgba.base07;
          match = colors.rgba.base0D;
          selection = colors.rgba.base04;
          selection-text = colors.rgba.base07;
          selection-match = colors.rgba.base09;
          counter = colors.rgba.base04;
          border = colors.rgba.base13;
        };
      };
    };

    i3status-rust = {
      enable = true;
      bars = {
        bottom = {
          theme = "gruvbox-dark";
          icons = "material-nf";
          blocks = [
            {
              block = "cpu";
              info_cpu = 20;
              warning_cpu = 50;
              critical_cpu = 90;
            }
            {
              block = "memory";
              format = " $icon $mem_used_percents.eng(w:1) ";
              format_alt = " $icon_swap $swap_free.eng(w:3,u:B,p:Mi)/$swap_total.eng(w:3,u:B,p:Mi)($swap_used_percents.eng(w:2)) ";
              interval = 30;
              warning_mem = 70;
              critical_mem = 90;
            }
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              alert_unit = "GB";
              interval = 30;
              warning = 20;
              alert = 10;
              format = " $icon root: $available.eng(w:2) ";
            }
            {
              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pwvucontrol";
                }
              ];
            }
            {
              block = "time";
              interval = 60;
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            }
          ];
        };
      };
    };

    swayimg.enable = true;

    swaylock = {
      enable = true;
      package = pkgs.swaylock-fancy;
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
        background-color = colors.rgb.base00;
        text-color = colors.rgb.base05;
        font = "Iosevka Nerd Font 10";
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
        {
          event = "before-sleep";
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
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
      settings = {
        program_options = {
          tray = true;
        };
      };
    };
  };

  wayland = {
    systemd.target = "sway-session.target";
    windowManager.sway = {
      checkConfig = false;

      config = {
        left = "h";
        down = "j";
        up = "k";
        right = "l";

        modifier = "Mod4";

        workspaceAutoBackAndForth = true;

        colors = {
          background = colors.rgb.base00;

          focused = {
            border = colors.rgb.base03;
            background = colors.rgb.base03;
            text = colors.rgb.base05;
            indicator = colors.rgb.base23;
            childBorder = colors.rgb.base03;
          };

          unfocused = {
            border = colors.rgb.base01;
            background = colors.rgb.base01;
            text = colors.rgb.base20;
            indicator = colors.rgb.base21;
            childBorder = colors.rgb.base22;
          };

          focusedInactive = {
            border = colors.rgb.base00;
            background = colors.rgb.base18;
            text = colors.rgb.base07;
            indicator = colors.rgb.base19;
            childBorder = colors.rgb.base18;
          };

          urgent = {
            border = colors.rgb.base08;
            background = colors.rgb.base08;
            text = colors.rgb.base05;
            indicator = colors.rgb.base08;
            childBorder = colors.rgb.base08;
          };

          placeholder = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#0c0c0c";
          };
        };

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

        output = {
          HDMI-A-2 = {
            bg = "~/.local/share/wallpapers/nord/linux-friends-4k.png fill";
          };
          VGA-1 = {
            bg = "~/.local/share/wallpapers/nord/pixelmoon.png fill";
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
                window_role = "pop-up";
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
          {
            command = "emacs --fg-daemon";
            always = false;
          }
          {
            command = "thunar --daemon";
            always = false;
          }
          {
            command = "foot --app-id ncmpcpp -e ncmpcpp";
            always = false;
          }
          {
            command = "wl-paste --type text --watch cliphist store &";
            always = false;
          }
          {
            command = "wl-paste --type image --watch cliphist store &";
            always = false;
          }
        ];

        bars = [
          {
            position = "bottom";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
            colors = {
              background = colors.rgb.base01;
              statusline = colors.rgb.base05;
              separator = colors.rgb.base03;

              focusedWorkspace = {
                border = colors.rgb.base0D;
                background = colors.rgb.base0D;
                text = colors.rgb.base05;
              };

              activeWorkspace = {
                border = colors.rgb.base16;
                background = colors.rgb.base16;
                text = colors.rgb.base05;
              };

              inactiveWorkspace = {
                border = colors.rgb.base02;
                background = colors.rgb.base02;
                text = colors.rgb.base05;
              };

              urgentWorkspace = {
                border = colors.rgb.base08;
                background = colors.rgb.base08;
                text = colors.rgb.base02;
              };
            };
          }
        ];

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
            "${modifier}+Mod1+q" = "exec swaylock";
            "${modifier}+Mod1+v" = "exec foot --app-id vim -e nvim";
            "${modifier}+Shift+t" = "exec ${./scripts/sway-tesseract.sh}";
            "${modifier}+o" = "exec sway-easyfocus focus";
            "${modifier}+Shift+o" = "exec sway-easyfocus swap";
            "${modifier}+Mod1+m" = "exec emacsclient -c -a emacs -e '(notmuch)'";
            "${modifier}+Mod1+w" = "exec foot --app-id nmtui -e nmtui";
            "${modifier}+Mod1+p" = "exec wl-color-picker";

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

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Iosevka Nerd Font Mono"
      ];

      serif = [
        "Dejavu Sans Mono"
      ];

      sansSerif = [
        "Dejavu Sans Mono"
      ];

      emoji = [
        "Twitter Color Emoji"
      ];
    };
  };
}
