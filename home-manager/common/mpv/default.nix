{
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
      gpu-context = "wayland";
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
}
