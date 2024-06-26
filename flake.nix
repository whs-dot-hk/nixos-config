{
  inputs."user.js".url = "github:arkenfox/user.js";
  inputs.disko.url = "github:nix-community/disko";
  inputs.fenix.url = "github:nix-community/fenix/main";
  inputs.hive.url = "github:divnix/hive";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.nixos-generators.url = "github:nix-community/nixos-generators";
  inputs.nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.nur.url = "github:nix-community/nur";
  inputs.std.url = "github:divnix/std";

  inputs."user.js".flake = false;

  outputs = {
    hive,
    nixos-generators,
    nixpkgs,
    self,
    std,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    inherit (std.inputs) haumea;
    load = {
      inputs,
      cell,
      src,
    }: {
      pkgs,
      mytest,
      ...
    } @ args: let
      cr = cell.__cr ++ [(baseNameOf src)];
      file = "${self.outPath}#${lib.concatStringsSep "/" cr}";

      inputs' = args // {inherit inputs cell;};
      defaultWith = import (haumea + /src/loaders/__defaultWith.nix) {inherit lib;};
      loader = defaultWith (scopedImport inputs') inputs';
    in
      if lib.pathIsDirectory src
      then
        lib.setDefaultModuleLocation file (haumea.lib.load {
          inherit src;
          loader = haumea.lib.loaders.scoped;
          transformer = with haumea.lib.transformers; [
            liftDefault
            #(hoistLists "_imports" "imports")
          ];
          inputs = inputs';
        })
      else lib.setDefaultModuleLocation file (loader src);

    findLoad = {
      inputs,
      cell,
      block,
    }:
      with builtins;
        lib.mapAttrs'
        (n: _:
          lib.nameValuePair
          (lib.removeSuffix ".nix" n)
          (load {
            inherit inputs cell;
            src = block + /${n};
          }))
        (removeAttrs (readDir block) ["default.nix"]);

    inputs' = lib.recursiveUpdate inputs {hive.findLoad = findLoad;};
  in
    hive.growOn {
      inputs = inputs';
      cellsFrom = ./comb;
      cellBlocks =
        #
        with hive.blockTypes;
        with std.blockTypes;
        #
          [
            (functions "hardwareProfiles")
            (functions "homeProfiles")
            (functions "nixosModules")
            (functions "nixosProfiles")
            (pkgs "pkgs")
            diskoConfigurations
            homeConfigurations
            nixosConfigurations
          ];
    }
    {
      nixosConfigurations = hive.collect self "nixosConfigurations";
    }
    {
      packages.x86_64-linux = {
        qcow = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "qcow";
          modules = [
            ({
              config,
              pkgs,
              ...
            }: {
              imports = [
                # Include the results of the hardware scan.
                #./hardware-configuration.nix
                nixos-generators.nixosModules.qcow
              ];

              nix.settings.experimental-features = [
                "flakes"
                "nix-command"
              ];

              # Use the systemd-boot EFI boot loader.
              #boot.loader.systemd-boot.enable = true;
              #boot.loader.efi.canTouchEfiVariables = true;

              # networking.hostName = "nixos"; # Define your hostname.
              # Pick only one of the below networking options.
              # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
              # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

              # Set your time zone.
              # time.timeZone = "Europe/Amsterdam";

              # Configure network proxy if necessary
              # networking.proxy.default = "http://user:password@proxy:port/";
              # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

              # Select internationalisation properties.
              # i18n.defaultLocale = "en_US.UTF-8";
              # console = {
              #   font = "Lat2-Terminus16";
              #   keyMap = "us";
              #   useXkbConfig = true; # use xkbOptions in tty.
              # };

              # Enable the X11 windowing system.
              # services.xserver.enable = true;

              # Configure keymap in X11
              # services.xserver.layout = "us";
              # services.xserver.xkbOptions = "eurosign:e,caps:escape";

              # Enable CUPS to print documents.
              # services.printing.enable = true;

              # Enable sound.
              # sound.enable = true;
              # hardware.pulseaudio.enable = true;

              # Enable touchpad support (enabled default in most desktopManager).
              # services.xserver.libinput.enable = true;

              # Define a user account. Don't forget to set a password with ‘passwd’.
              # users.users.alice = {
              #   isNormalUser = true;
              #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
              #   packages = with pkgs; [
              #     firefox
              #     tree
              #   ];
              # };
              users.users.nixos = {
                extraGroups = ["wheel"];
                initialPassword = "nixos";
                isNormalUser = true;
              };

              users.extraGroups.docker.members = ["nixos"];

              # List packages installed in system profile. To search, run:
              # $ nix search wget
              # environment.systemPackages = with pkgs; [
              #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
              #   wget
              # ];
              environment.systemPackages = with pkgs; [
                cilium-cli
                git
                kind
                kubectl
                vim
              ];

              # Some programs need SUID wrappers, can be configured further or are
              # started in user sessions.
              # programs.mtr.enable = true;
              # programs.gnupg.agent = {
              #   enable = true;
              #   enableSSHSupport = true;
              # };

              # List services that you want to enable:
              virtualisation.docker.enable = true;

              # Enable the OpenSSH daemon.
              services.openssh.enable = true;

              # Open ports in the firewall.
              # networking.firewall.allowedTCPPorts = [ ... ];
              # networking.firewall.allowedUDPPorts = [ ... ];
              # Or disable the firewall altogether.
              # networking.firewall.enable = false;

              # Copy the NixOS configuration file and link it from the resulting system
              # (/run/current-system/configuration.nix). This is useful in case you
              # accidentally delete configuration.nix.
              # system.copySystemConfiguration = true;

              # This value determines the NixOS release from which the default
              # settings for stateful data, like file locations and database versions
              # on your system were taken. It's perfectly fine and recommended to leave
              # this value at the release version of the first install of this system.
              # Before changing this value read the documentation for this option
              # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
              system.stateVersion = "23.05"; # Did you read the comment?
            })
          ];
        };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
