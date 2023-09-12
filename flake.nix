{
  inputs."user.js".url = "github:arkenfox/user.js";
  inputs.disko.url = "github:nix-community/disko";
  inputs.hive.url = "github:whs-dot-hk/hive/test4";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.nur.url = "github:nix-community/nur";
  inputs.std.url = "github:divnix/std";

  inputs."user.js".flake = false;

  outputs = {
    hive,
    self,
    std,
    ...
  } @ inputs:
    hive.growOn {
      inherit inputs;
      cellsFrom = ./comb;
      cellBlocks =
        #
        with hive.blockTypes;
        with std.blockTypes;
        #
          [
            (functions "hardwareProfiles")
            (functions "homeProfiles")
            (functions "nixosProfiles")
            (pkgs "pkgs")
            diskoConfigurations
            homeConfigurations
            nixosConfigurations
          ];
    }
    {
      diskoConfigurations = hive.collect self "diskoConfigurations";
      nixosConfigurations = hive.collect self "nixosConfigurations";
    };
}
