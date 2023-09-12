{
  enable = true;
  package = pkgs.latest.firefox-nightly-bin;
  profiles."0".extraConfig = builtins.readFile (inputs."user.js" + /user.js);
  profiles."0".extensions = with config.nur.repos.rycee.firefox-addons; [
    keepassxc-browser
    multi-account-containers
    ublock-origin
  ];
}
