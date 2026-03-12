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
  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "qbittorrent-nox";
      paths = [ pkgs.qbittorrent-nox ];
    })
  ];
  services.qbittorrent = {
    enable = true;
    webuiPort = 8081;
    serverConfig = {
      Preferences = {
        WebUI = {
          Username = "shinyu";
          Password_PBKDF2 = "@ByteArray(r2109kTQQfhmc2TIQnABuA==:+5WCNJoWvymFLkjgoWu1CsaLcfIRBnt49YatqkFUmnpu6+bo4qJesDpxhUv5nRKz29HkSY52sVSXKeJ569V+ZA==)";
          AlternativeUIEnabled = false;
          BypassLocalAuth = true;
          BypassAuthSubnetWhitelist = "192.168.1.0/24";
          BypassAuthSubnetWhitelistEnabled = true;
        };
      };
    };
  };
}
