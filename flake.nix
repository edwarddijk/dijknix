{
  description = "Dijk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
	    bequiet  = inputs.nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
	    modules = [
	    	    inputs.nixos-facter-modules.nixosModules.facter
                    { config.facter.reportPath = ./facter.json; }
	    	    ./hosts/bequiet/bequiet.nix
		    ./hosts/bequiet/configuration.nix
		    home-manager.nixosModules.home-manager
		    {
		      home-manager.useGlobalPkgs = true;
		      home-manager.useUserPackages = true;
		      home-manager.users.edward = import ./home.nix;
		    }
	            ];
            };

	    proxmox  = inputs.nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
	    modules = [ 
	            ./hardware/proxmox.nix
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
