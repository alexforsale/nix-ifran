{
  pkgs,
  ...
}:
let
  writeMbsyncScript =
    name:
    pkgs.writeShellScript "mbsync-${name}-script" ''
      # Ensure necessary environment variables/paths are available if needed
      export PATH=${pkgs.isync}/bin:$PATH
      exec mbsync --quiet ${name}
    '';
in
{
  programs.msmtp.enable = true;
  programs.mbsync.enable = true;
  programs.notmuch = {
    enable = true;
    new.tags = [
      "unread"
      "inbox"
    ];
    new.ignore = [
      "/.*[.](json|lock|bak)$/"
    ];
    hooks = {
      postNew = "${pkgs.notmuch}/bin/notmuch tag -inbox +Archive2026 -- 'tag:inbox and not tag:Archive2026 and date:2026 and date:..30D'";
    };
    maildir.synchronizeFlags = true;
  };

  programs.astroid = {
    enable = true;
    pollScript = "${pkgs.isync}/bin/mbsync --all";
    externalEditor = "${pkgs.emacs-pgtk}/bin/emacsclient -a 'emacs' -q -c %1";
    extraConfig = {
      editor.attachment_directory = "~/Downloads";
    };
  };

  programs.vdirsyncer = {
    enable = true;
  };

  services.vdirsyncer = {
    enable = true;
    frequency = "*:0/30";
  };

  programs.khal = {
    enable = true;
    settings = {
      default = {
        highlight_event_days = true;
        timedelta = "7d";
      };
    };
  };

  accounts = {
    contact = {
      basePath = ".contact";
      accounts = {
        "google" = {
          remote = {
            type = "google_contacts";
          };
          vdirsyncer = {
            enable = true;
            tokenFile = "~/.local/share/vdirsyncer-card.token";
            clientSecretCommand = [
              "${pkgs.pass}/bin/pass"
              "vdirsyncer/client_secret"
            ];
            clientIdCommand = [
              "${pkgs.pass}/bin/pass"
              "vdirsyncer/client_id"
            ];
            collections = [
              "from a"
              "from b"
            ];
          };
          khard = {
            enable = true;
            type = "vdir";
          };
        };
      };
    };
    calendar = {
      basePath = ".calendar";
      accounts = {
        "google" = {
          remote = {
            type = "google_calendar";
          };
          vdirsyncer = {
            enable = true;
            tokenFile = "~/.local/share/vdirsyncer-cal.token";
            clientSecretCommand = [
              "${pkgs.pass}/bin/pass"
              "vdirsyncer/client_secret"
            ];
            clientIdCommand = [
              "${pkgs.pass}/bin/pass"
              "vdirsyncer/client_id"
            ];
            metadata = [
              "color"
              "displayname"
              "description"
              "order"
            ];
            collections = [
              "from a"
              "from b"
            ];
          };
          khal = {
            enable = true;
            type = "discover";
            glob = "*";
          };
        };
      };
    };
    email = {
      maildirBasePath = ".mail";
      accounts = {
        "gmail" = {
          enable = true;
          userName = "alexarians@gmail.com";
          address = "alexarians@gmail.com";
          realName = "Kristian Alexander P";
          flavor = "gmail.com";
          primary = true;
          folders = {
            drafts = "Drafts";
            inbox = "Inbox";
            sent = "Sent";
            trash = "Trash";
          };
          imap = {
            host = "imap.gmail.com";
            port = 993;
          };
          smtp = {
            host = "smtp.gmail.com";
            port = 465;
          };
          mbsync = {
            enable = true;
            create = "maildir";
            expunge = "both";
            groups = {
              "googlemail" = {
                channels = {
                  "default" = {
                    patterns = [
                      "INBOX"
                    ];
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "drafts" = {
                    nearPattern = "drafts";
                    farPattern = "[Gmail]/Drafts";
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "sent" = {
                    nearPattern = "sent";
                    farPattern = "[Gmail]/Sent Mail";
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "trash" = {
                    nearPattern = "trash";
                    farPattern = "[Gmail]/Trash";
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "spam" = {
                    nearPattern = "spam";
                    farPattern = "[Gmail]/Spam";
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "archive2026" = {
                    patterns = [
                      "Archive2026"
                    ];
                    extraConfig = {
                      Create = "near";
                    };
                  };
                  "archive-old" = {
                    patterns = [
                      "Archive*"
                      "!Archive2026"
                    ];
                    extraConfig = {
                      Create = "near";
                    };
                  };
                };
              };
            };
            subFolders = "Verbatim";
          };
          msmtp = {
            enable = true;
          };
          notmuch = {
            enable = true;
          };
          astroid = {
            enable = true;
          };
          passwordCommand = "${pkgs.pass}/bin/pass show google.com/app_pass/alexarians@gmail.com";
        };
      };
    };
  };
  systemd.user.services = {
    "mbsync-googlemail-default" = {
      Unit.Description = "Mbsync default channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-default"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-sent" = {
      Unit.Description = "Mbsync sent channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-sent"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-drafts" = {
      Unit.Description = "Mbsync drafts channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-drafts"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-trash" = {
      Unit.Description = "Mbsync trash channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-trash"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-spam" = {
      Unit.Description = "Mbsync spam channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-spam"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-archive2026" = {
      Unit.Description = "Mbsync archive2026 channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-archive2026"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };

    "mbsync-googlemail-archive-old" = {
      Unit.Description = "Mbsync old archive channel";
      Service = {
        Type = "oneshot";
        ExecStart = "${writeMbsyncScript "googlemail-archive-old"}";
        ExecStartPost = "${pkgs.notmuch}/bin/notmuch new";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {
    "mbsync-googlemail-default" = {
      Unit.Description = "Timer for Mbsync default channel";
      Timer = {
        OnUnitInactiveSec = "5m";
        Persistent = true;
        Unit = "mbsync-googlemail-default.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-sent" = {
      Unit.Description = "Timer for Mbsync sent channel";
      Timer = {
        OnUnitInactiveSec = "10m";
        Persistent = true;
        Unit = "mbsync-googlemail-sent.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-trash" = {
      Unit.Description = "Timer for Mbsync trash channel";
      Timer = {
        OnUnitInactiveSec = "20m";
        Persistent = true;
        Unit = "mbsync-googlemail-trash.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-drafts" = {
      Unit.Description = "Timer for Mbsync drafts channel";
      Timer = {
        OnUnitInactiveSec = "5m";
        Persistent = true;
        Unit = "mbsync-googlemail-drafts.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-spam" = {
      Unit.Description = "Timer for Mbsync spam channel";
      Timer = {
        OnUnitActiveSec = "1h";
        Persistent = true;
        Unit = "mbsync-googlemail-spam.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-archive2026" = {
      Unit.Description = "Timer for Mbsync archive2026 channel";
      Timer = {
        OnUnitActiveSec = "2h";
        Persistent = true;
        Unit = "mbsync-googlemail-archive2026.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };

    "mbsync-googlemail-archive-old" = {
      Unit.Description = "Timer for Mbsync old archive channel";
      Timer = {
        OnUnitActiveSec = "3h";
        Persistent = true;
        Unit = "mbsync-googlemail-archive-old.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
