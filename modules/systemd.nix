{ config, pkgs, inputs, ... }:
{
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  systemd.user.units."app-org.fcitx.Fcitx5@autostart.service".enable = false;
  systemd.user.services.plasma-xdg-desktop-portal-kde = {
    serviceConfig = {
      Environment = "QT_QPA_PLATFORMTHEME=qtengine";
    };
  };
  # systemd.user.services.mango-reload = {
  #   enable = true;
  #   description = "Reload mangowc";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${inputs.mango.packages.${pkgs.system}.default}/bin/mmsg -d reload_config";
  #   };
  # };
  # systemd.user.paths.mango-reload = {
  #   enable = true;
  #   description = "Watch Mango config file for changes";
  #   pathConfig = {
  #     # Provide a list of absolute paths to monitor
  #     PathChanged = [
  #       "%h/.config/mango/config.conf"
  #       "%h/.config/mango/colors.conf"
  #       "%h/.config/mango/env.conf"
  #       "%h/.config/mango/keybinds.conf"
  #       "%h/.config/mango/rules.conf"
  #       "%h/.config/mango/shinyu.conf"
  #     ];
  #     };
  #   wantedBy = ["default.target"];
  #   wants = ["mango-reload.service"];
  # };

  systemd.services.drbd = {
    path = with pkgs; [ drbd coreutils util-linux systemd ];
    serviceConfig = {
      Type = "oneshot";
      Restart = "on-failure";
      RemainAfterExit = "true";
    };
  };
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };
}
