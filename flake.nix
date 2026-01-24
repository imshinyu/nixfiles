{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    niri.url = "github:Naxdy/niri";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # millennium = {
     # url = "git+https://github.com/SteamClientHomebrew/Millennium?ref=next";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.sapphire = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./modules/hosts/sapphire/default.nix
        inputs.hjem.nixosModules.default
        inputs.qtengine.nixosModules.default
        inputs.niri.nixosModules.default
        inputs.mango.nixosModules.mango
        inputs.spicetify-nix.nixosModules.spicetify
      ];
    };
  };
}
