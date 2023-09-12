with pkgs; [
  (wrapMpv (mpv-unwrapped.override {ffmpeg_5 = ffmpeg_5-full;}) {})
  alejandra
  borgbackup
  borgmatic
  smplayer
]
