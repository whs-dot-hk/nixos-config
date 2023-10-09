let
  inherit (config._module.args) pkgs;
in
  with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ]
