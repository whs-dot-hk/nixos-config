let
    inherit (inputs) disko;
    inherit (inputs) home-manager;
    bee = {
        home = home-manager;
        pkgs = cell.pkgs;
        system = "x86_64-linux";
    };
in

{
    x17 = {
        imports = [
            {inherit bee;}
            cell.diskoConfigurations.x17
            cell.hardwareProfiles.x17
            cell.homeConfigurations.x17
            cell.nixosModules.x17
            cell.nixosProfiles.x17
            disko.nixosModules.disko
        ];
    };
}
