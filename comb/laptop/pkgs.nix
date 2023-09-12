import inputs.nixpkgs {
  inherit (inputs.nixpkgs) system;
  config.allowUnfree = true;
  overlays = [
    inputs.nixpkgs-mozilla.overlay
  ];
}
