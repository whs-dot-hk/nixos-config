let
  inherit (config._module.args) pkgs;
in
  with pkgs; [
    (wrapMpv (mpv-unwrapped.override {ffmpeg_5 = ffmpeg_5-full;}) {})
    alacritty
    alejandra
    borgbackup
    borgmatic
    smplayer
  ]
