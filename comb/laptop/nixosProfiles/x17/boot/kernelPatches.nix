[
  {
    name = "selinux-config";
    patch = null;
    extraConfig = ''
      SECURITY_SELINUX y
      SECURITY_SELINUX_BOOTPARAM n
      SECURITY_SELINUX_DEVELOP y
      SECURITY_SELINUX_AVC_STATS y
      DEFAULT_SECURITY_SELINUX n
    '';
  }
]
