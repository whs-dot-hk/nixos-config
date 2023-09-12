{
  x17 = {
    bee.system = "x86_64-linux";
    bee.pkgs = cell.pkgs;
    bee.home = inputs.home-manager;

    imports = [
      cell.hardwareProfiles.x17
      cell.nixosProfiles.x17
      inputs.disko.nixosModules.disko
      {disko.devices = cell.diskoConfigurations.x17;}
      {home-manager.users.whs = cell.homeConfigurations.x17;}
    ];

    system.stateVersion = "23.05";
  };
}
