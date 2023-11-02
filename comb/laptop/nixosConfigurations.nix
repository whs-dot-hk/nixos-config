{
  x17 = {
    imports = [
      cell.diskoConfigurations.x17
      cell.hardwareProfiles.x17
      cell.homeConfigurations.x17
      cell.nixosProfiles.x17
      inputs.disko.nixosModules.disko
      {
        bee.home = inputs.home-manager;
        bee.pkgs = cell.pkgs;
        bee.system = "x86_64-linux";
      }
    ];
  };
}
