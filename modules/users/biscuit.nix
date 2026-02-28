{ config, pkgs, inputs, ...}:

{
  users.users.biscuit = {
    isNormalUser = true;
    description = "biscuit";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "users"];
    packages = with pkgs; [
     # thunderbird
    ];
  };
  security.pam.services.biscuit.kwallet.enable = true;
  hjem.users.biscuit = {
    user = "biscuit";
    directory = "/home/biscuit";
  };
}
