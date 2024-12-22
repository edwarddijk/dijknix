{
  description = "Dijk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    stylix.url = "github:danth/stylix";
    };

  outputs = inputs@{ nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations = {
	    bequiet  = inputs.nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
	    modules = [
	    	    inputs.nixos-facter-modules.nixosModules.facter
                    { config.facter.reportPath = ./hosts/bequiet/facter.json; }
	    	    ./hosts/bequiet/bequiet.nix
		    ./hosts/bequiet/configuration.nix
                    stylix.nixosModules.stylix
		    home-manager.nixosModules.home-manager
		    {
		      home-manager.useGlobalPkgs = true;
		      home-manager.useUserPackages = true;
		      home-manager.extraSpecialArgs = {
                        inherit inputs;
                      };
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
