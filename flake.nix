{
  description = "Dijk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
	    proxmox  = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
	    modules = [ 
		    ./configuration.nix
		    home-manager.nixosModules.home-manager
		    {
		      home-manager.useGlobalPkgs = true;
		      home-manager.useUserPackages = true;
		      home-manager.users.edward = import ./home.nix;
		    }
	      ];
      };
    };
  };
}
