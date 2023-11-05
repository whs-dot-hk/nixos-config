let
    inherit (inputs) disko;
    inherit (inputs) home-manager;
    bee-x17 = {
        bee = {
            home = home-manager;
            pkgs = cell.pkgs.x17;
            system = "x86_64-linux";
        };
    };
in

{
    x17 = {
        imports = [
            bee-x17
            cell.diskoConfigurations.x17
            cell.hardwareProfiles.x17
            cell.homeConfigurations.x17
            cell.nixosModules.x17
            cell.nixosProfiles.x17
            disko.nixosModules.disko
        ];
    };
}
