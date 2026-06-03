{
  description = "My super duper awesome flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    helix.url = "github:helix-editor/helix/master";
    xboxdrv.url = "github:xboxdrv/xboxdrv";
    nixcord.url = "github:FlameFlag/nixcord";
    nix-index.url = "github:nix-community/nix-index-database";
    # millennium = {
    #   url = "path:/home/shinyu/nixfiles/programs/millennium";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    content-manager = {
      url = "path:/home/shinyu/nixfiles/programs/content-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    online-fix-launcher = {
      url = "path:/home/shinyu/nixfiles/programs/ofll";
    };
    elysia = {
      url = "git+https://dawn.wine/foxtrottt/elysia-on-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprism = {
      url = "path:/home/shinyu/nixfiles/programs/hyprism";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      # these are only required for internal tests,
      # hence you can set em to nothing
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };
  };  
  outputs = { self, nixpkgs, ... }@inputs:
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
	      };
	      modules = 
	        (import-tree ./modules)
	       ++ (import-tree ./hosts/sapphire)
	       ++ [
	        ./hosts/common.nix
          ./users/shinyu/default.nix
          ./users/biscuit/default.nix
          ./users/family/default.nix
	        # inputs.qtengine.nixosModules.default
	        inputs.mango.nixosModules.mango
	        inputs.hjem.nixosModules.default
	        inputs.nix-index.nixosModules.default
	      ];
	    };
	  };
	};
}
