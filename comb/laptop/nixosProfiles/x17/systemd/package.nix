let
  inherit (config._module.args) pkgs;
in
  pkgs.systemd.override {withSelinux = true;}
