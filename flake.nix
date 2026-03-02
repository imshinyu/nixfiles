{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nixcord.url = "github:FlameFlag/nixcord";
    nix-index.url = "github:nix-community/nix-index-database";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };  
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.sapphire = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/sapphire/default.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.qtengine.nixosModules.default
        inputs.mango.nixosModules.mango
        inputs.aagl.nixosModules.default
        inputs.nix-index.nixosModules.default
      ];
    };
    nixosConfigurations.ruby = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/ruby/default.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.qtengine.nixosModules.default
        inputs.mango.nixosModules.mango
        inputs.nix-index.nixosModules.default
      ];
    };
    # nixosConfigurations.onyx = nixpkgs.lib.nixosSystem {
    #   specialArgs = {
    #     inherit inputs;
    #   };
    #   modules = [
    #     ./modules/hosts/onyx/default.nix
    #   ];
    # };
  };
}
