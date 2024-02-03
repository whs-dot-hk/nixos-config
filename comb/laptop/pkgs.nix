{
  x17 = import inputs.nixpkgs {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
    overlays = [
      inputs.nixpkgs-mozilla.overlay
      (
        _: super: {
          linux_testing = super.linuxPackagesFor (super.linux_testing.override {
            argsOverride = {
              kernelPatches = [{patch = inputs.self + /test.patch;}];
            };
          });
        }
      )
    ];
  };
}
