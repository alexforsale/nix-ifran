{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../../common
    ./sway
  ];

  home = {
    username = "alexforsale";
    homeDirectory = "/home/alexforsale";
    stateVersion = "25.11";
    packages = with pkgs; [
      pass-git-helper
      playerctl
      mpc
      mpd-notification
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.id_ID
      gruvbox-gtk-theme
    ];
  };

  programs = {
    emacs = {
      enable = true;
      package = pkgs.myEmacs;
    };

    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      settings = {
        core = {
          editor = "nvim";
        };
        commit = {
          gpgsign = true;
        };
        color = {
          ui = true;
        };
        credential = {
          helper = "!pass-git-helper $@";
        };
        difftool = {
          prompt = true;
        };
        diff = {
          tool = "nvimdiff";
        };
        difttool."nvimdiff" = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        merge = {
          tool = "nvim";
        };
        mergetool."nvim" = {
          cmd = "nvim -d -c \"wincmd l\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
          keepBackup = false;
        };
        init = {
          defaultBranch = "main";
        };
        pack = {
          windowMemory = "2g";
          packSizeLimit = "1g";
        };
        pull = {
          rebase = true;
        };
        push = {
          default = "simple";
        };
        tag = {
          gpgSign = true;
        };
        user = {
          name = "alexforsale";
          email = "alexforsale@yahoo.com";
          signingkey = "CDBB05B232787FCC";
        };
      };
    };

    ncmpcpp = {
      enable = true;
      mpdMusicDir = config.xdg.userDirs.music;
      settings = {
        ncmpcpp_directory = "~/.config/ncmpcpp";
        lyrics_directory = "~/.lyrics";
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "Visualizer feed";
        visualizer_in_stereo = "no";
        visualizer_type = "wave";
        visualizer_fps = 60;
        visualizer_autoscale = "yes";
        visualizer_spectrum_smooth_look = "yes";
        message_delay_time = 3;
        playlist_display_mode = "classic";
        browser_display_mode = "columns";
        search_engine_display_mode = "columns";
        playlist_editor_display_mode = "columns";
        seek_time = 5;
        autocenter_mode = "yes";
        centered_cursor = "yes";
        user_interface = "alternative";
        follow_now_playing_lyrics = "yes";
        allow_for_physical_item_deletion = "no";
        lastfm_preferred_language = "en";
        locked_screen_width_part = 60;
        ask_before_clearing_playlists = "yes";
        clock_display_seconds = "yes";
        display_volume_level = "yes";
        display_bitrate = "no";
        mouse_support = "yes";
        mouse_list_scroll_whole_page = "yes";
        lines_scrolled = 1;
        empty_tag_marker = "<empty>";
        tags_separator = " | ";
        enable_window_title = "yes";
        search_engine_default_search_mode = 2;
        external_editor = "emacsclient -t -a emacs";
        use_console_editor = "yes";
        colors_enabled = "yes";
        execute_on_song_change = "${./scripts/mpd-coverart.sh}";
      };

      bindings = [
        { key = "mouse"; command = "mouse_event"; }
        { key = "|"; command = "toggle_mouse"; }
        { key = "up"; command = "scroll_up"; }
        { key = "k"; command = "scroll_up"; }
        { key = "shift-up"; command = [ "select_item" "scroll_up" ]; }
        { key = "down"; command = "scroll_down"; }
        { key = "j"; command = "scroll_down"; }
        { key = "shift-down"; command = [ "select_item" "scroll_down" ]; }
        { key = "shift-j"; command = [ "select_item" "scroll_down"]; }
        { key = "["; command = "scroll_up_album"; }
        { key = "]"; command = "scroll_down_album"; }
        { key = "{"; command = "scroll_up_artist"; }
        { key = "}"; command = "scroll_down_artist"; }
        { key = "page_up"; command = "page_up"; }
        { key = "page_down"; command = "page_down"; }
        { key = "right"; command = ["next_column" "slave_screen"]; }
        { key = "l"; command = ["next_column" "slave_screen"]; }
        { key = "left"; command = ["previous_column" "master_screen"]; }
        { key = "h"; command = ["previous_column" "master_screen"]; }
        { key = "tab"; command = "next_screen"; }
        { key = "shift-tab"; command = "previous_screen"; }
        { key = "ctrl-h"; command = "jump_to_parent_directory"; }
        { key = "backspace"; command = "jump_to_parent_directory"; }

        { key = "+"; command = "volume_up"; }
        { key = "-"; command = "volume_down"; }

        { key = ":"; command = "execute_command"; }
        { key = "f1"; command = "show_help"; }
        { key = "1"; command = "show_playlist"; }
        { key = "2"; command = "show_browser"; }
        { key = "3"; command = [ "show_search_engine" "reset_search_engine" ]; }
        { key = "4"; command = [ "show_media_library" "toggle_media_library_columns_mode" ]; }
        { key = "5"; command = "show_playlist_editor"; }
        { key = "6"; command = "show_tag_editor"; }
        { key = "7"; command = "show_outputs"; }
        { key = "8"; command = "show_visualizer"; }
        { key = "="; command = "show_clock"; }
        { key = "@"; command = "show_server_info"; }
        { key = "G"; command = [ "jump_to_browser" "jump_to_playlist_editor" ]; }
        { key = "~"; command = "jump_to_media_library"; }
        { key = "P"; command = "toggle_display_mode"; }
        { key = "\\\\"; command = "toggle_interface"; }
        { key = "!"; command = "toggle_separators_between_albums"; }
        { key = "ctrl-l"; command = "toggle_screen_lock"; }
        { key = "q"; command = "quit"; }

        { key = "left"; command = "seek_backward"; }
        { key = "b"; command = "seek_backward"; }
        { key = "right"; command = "seek_forward"; }
        { key = "f"; command = "seek_forward"; }
        { key = "s"; command = "stop"; }
        { key = "p"; command = "pause"; }
        { key = ">"; command = "next"; }
        { key = "<"; command = "previous"; }
        { key = "ctrl-h"; command = "replay_song"; }
        { key = "backspace"; command = "play"; }
        { key = "r"; command = "toggle_repeat"; }
        { key = "z"; command = "toggle_random"; }
        { key = "Z"; command = "shuffle"; }
        { key = "x"; command = "toggle_crossfade"; }
        { key = "X"; command = "set_crossfade"; }
        { key = "u"; command = "update_database"; }
        { key = "y"; command = "toggle_single"; }
        { key = "Y"; command = "toggle_replay_gain_mode"; }
        { key = "#"; command = "toggle_bitrate_visibility"; }
        { key = "i"; command = "show_song_info"; }
        { key = "I"; command = "show_artist_info"; }
        { key = "g"; command = "jump_to_position_in_song"; }
        { key = "o"; command = "jump_to_playing_song"; }
        { key = "U"; command = "toggle_playing_song_centering"; }

        { key = "y"; command = "save_tag_changes"; }
        { key = "e"; command = "edit_library_tag"; }
        { key = "E"; command = "jump_to_tag_editor"; }
        { key = "`"; command = "toggle_library_tag_type"; }

        { key = "y"; command = "start_searching"; }
        { key = "ctrl-_"; command = "select_found_items"; }
        { key = "/"; command = ["find" "find_item_forward"]; }
        { key = "?"; command = ["find" "find_item_backward"]; }
        { key = "."; command = "next_found_item"; }
        { key = ","; command = "previous_found_item"; }
        { key = "w"; command = "toggle_find_mode"; }
        { key = "ctrl-f"; command = "apply_filter"; }
        { key = "ctrl-v"; command = "select_range"; }
        { key = "ctrl-p"; command = "set_selected_items_priority"; }
        { key = "v"; command = "reverse_selection"; }
        { key = "V"; command = "remove_selection"; }
        { key = "m"; command = ["move_selected_items_up" "move_sort_order_up"]; }
        { key = "n"; command = ["move_selected_items_down" "move_sort_order_down"]; }
        { key = "M"; command = "move_selected_items_to"; }
      ];
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [
        exts.pass-otp
      ]);
    };
  };

  services = {
    mpd = {
      enable = true;
      network = {
        startWhenNeeded = true;
      };
      musicDirectory = "${config.xdg.userDirs.music}";
      playlistDirectory = "${config.xdg.userDirs.music}/Playlist";
      extraConfig = ''
        auto_update     "yes"
        input {
          plugin "curl"
        }

        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }

        audio_output {
          type            "fifo"
          name            "Visualizer feed"
          path            "/tmp/mpd.fifo"
          format          "44100:16:2"
        }

        volume_normalization            "yes"
      '';
    };

    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };

    mpdscribble = {
      enable = true;
      host = "localhost";
      endpoints = {
        "last.fm" = {
          passwordFile = "/var/tmp/mpdscribble.password";
          username = "alexforsale";
        };
      };
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Music";
      videos = "${config.home.homeDirectory}/Videos";
      pictures = "${config.home.homeDirectory}/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      desktop = "${config.home.homeDirectory}/Desktop";
      publicShare = "${config.home.homeDirectory}/Public";
      extraConfig = {
        XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
    };
  };
}
