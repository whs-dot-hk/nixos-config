let
  inherit (config._module.args) pkgs;
in
  with pkgs; [
    policycoreutils
    virt-manager
    virtiofsd
  ]
