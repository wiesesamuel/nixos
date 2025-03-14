{ config, pkgs, ... }:
{
  users.users.desktopUser = {
    isNormalUser = true;
    description  = "Desktop User";
    home         = "/home/desktop";
    extraGroups  = [ "wheel" "storage" ];
    password     = "nixos";
  };
}
