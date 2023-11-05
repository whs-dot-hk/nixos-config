let
  inherit (config._module.args) pkgs;
  inherit (inputs) fenix;
in
  with pkgs; [
    (wrapMpv (mpv-unwrapped.override {ffmpeg = ffmpeg_6-full;}) {})
    alejandra
    borgbackup
    borgmatic
    cargo-expand
    fenix.packages.default.toolchain
    gcc
    smplayer
    wezterm
  ]
