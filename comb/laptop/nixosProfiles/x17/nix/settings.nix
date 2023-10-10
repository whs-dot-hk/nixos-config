{
  auto-optimise-store = true;
  experimental-features = [
    "flakes"
    "nix-command"
  ];
  trusted-users = [
    "@wheel"
    "root"
  ];
}
