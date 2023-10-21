{
  x17 = {
    home-manager.users.whs = {
      imports = [
        cell.homeProfiles.smplayer
        cell.homeProfiles.x17
        inputs.nur.hmModules.nur
      ];

      home.stateVersion = "23.05";
    };
  };
}
