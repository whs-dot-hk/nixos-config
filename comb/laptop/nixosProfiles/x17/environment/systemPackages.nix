let
  inherit (config._module.args) pkgs;
in
  with pkgs; [
    virt-manager
    virtiofsd
  ]
