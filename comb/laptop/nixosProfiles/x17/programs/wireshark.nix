let
  inherit (config._module.args) pkgs;
in {
  enable = true;
  package = pkgs.wireshark;
}
