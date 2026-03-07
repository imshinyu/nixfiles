{
  description = "My super duper awesome flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    # millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
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
  outputs = { self, nixpkgs, aagl, home-manager, ... }@inputs:
        let
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree =
        path:
        toList (fileFilter (file: file.hasExt "nix" && !(inputs.nixpkgs.lib.hasPrefix "_" file.name)) path);
    in
   {
      nixosConfigurations = {
	    sapphire = nixpkgs.lib.nixosSystem {
	      specialArgs = {
	        inherit inputs;
	        inherit aagl;
	      };
	      modules = 
	        (import-tree ./modules/system)
	       ++ (import-tree ./hosts/sapphire)
	       ++ [
	        ./hosts/common.nix
          ./users/shinyu/default.nix
          ./users/biscuit/default.nix
          ./users/family/default.nix
	        inputs.home-manager.nixosModules.default
	        inputs.qtengine.nixosModules.default
	        inputs.mango.nixosModules.mango
	        inputs.spicetify-nix.nixosModules.spicetify
	        inputs.nixcord.nixosModules.nixcord
	        inputs.nix-index.nixosModules.default
	        home-manager.nixosModules.home-manager
	        {
	          home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
	          home-manager.users.shinyu = import ./users/shinyu/home.nix;
	          home-manager.users.biscuit = import ./users/biscuit/home.nix;
	          home-manager.users.family = import ./users/family/home.nix;
	        }
	      ];
	    };
	  };
	};
}
