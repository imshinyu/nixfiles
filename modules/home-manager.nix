{ config, pkgs, inputs, ...}:
let
  hostname = config.networking.hostName;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    
    users = (if hostname == "sapphire" then {
      shinyu = ../users/shinyu/home.nix;
      biscuit = ../users/biscuit/home.nix;
      family = ../users/family/home.nix;
    } else if hostname == "ruby" then {
      shinyu = ../users/shinyu/home.nix;
      biscuit = ../users/biscuit/home.nix;
      heisenberg = ../users/heisenberg/home.nix;
    } else {});

    extraSpecialArgs = {
      inherit inputs;
      system = pkgs.stdenv.hostPlatform.system;
    };
  };
}
