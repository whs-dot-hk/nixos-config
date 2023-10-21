{
  x17 = {
    bee.system = "x86_64-linux";
    bee.pkgs = cell.pkgs;
    bee.home = inputs.home-manager;

    imports = [
      cell.diskoConfigurations.x17
      cell.hardwareProfiles.x17
      cell.homeConfigurations.x17
      cell.nixosProfiles.x17
      inputs.disko.nixosModules.disko
    ];

    system.stateVersion = "23.05";
  };
}
