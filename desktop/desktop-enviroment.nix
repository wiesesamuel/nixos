{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # No display manager, so user manually starts plasma
  services.xserver.displayManager.sddm.enable = true;
}
