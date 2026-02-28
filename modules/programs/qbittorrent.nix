{ config, lib, pkgs, inputs, ... }:
{
  users.users.qbittorrent = {
    extraGroups = [ "users" ];
  };
  systemd.tmpfiles.rules = [
    "d /mnt/hdd/Others/Torrents 2775 shinyu users - -"
  ];
  systemd.services.qbittorrent.serviceConfig = {
    UMask = "0002";
  };
  services.qbittorrent = {
    enable = true;
    webuiPort = 8081;
    serverConfig = {
      Preferences = {
        WebUI = {
          AlternativeUIEnabled = false;
          BypassLocalAuth = true;
          BypassAuthSubnetWhitelist = "192.168.1.0/24";
          BypassAuthSubnetWhitelistEnabled = true;
        };
      };
    };
  };
}
