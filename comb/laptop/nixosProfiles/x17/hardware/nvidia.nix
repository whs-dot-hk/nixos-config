{
  modesetting.enable = true;
  nvidiaSettings = true;
  open = true;
  package = config.boot.kernelPackages.nvidiaPackages.beta.overrideAttrs (finalAttrs: previousAttrs: {
    passthru = previousAttrs.passthru // {
      open = previousAttrs.passthru.open.overrideAttrs (finalAttrs: previousAttrs: {
        patches = [(inputs.self + /test.patch)];
      });
    };
  });
}
