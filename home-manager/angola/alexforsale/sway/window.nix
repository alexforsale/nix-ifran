{
  ...
}:
{
  wayland.windowManager.sway = {
    config = {
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
              app_id = "swayimg";
            };
            command = "floating enable";
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
          {
            criteria = {
              app_id = "thunar";
              title = "Rename.*";
            };
            command = "floating enable; resize set 600 200";
          }
        ];
      };
    };
  };
}
