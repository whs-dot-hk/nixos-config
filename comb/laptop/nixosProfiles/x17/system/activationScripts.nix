{
  flatpak.text = ''
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    ${pkgs.flatpak}/bin/flatpak install -y flathub com.gitlab.davem.ClamTk
    ${pkgs.flatpak}/bin/flatpak install -y flathub org.filezillaproject.Filezilla
    ${pkgs.flatpak}/bin/flatpak install -y flathub org.keepassxc.KeePassXC

    ${pkgs.flatpak}/bin/flatpak update -y
  '';
}
