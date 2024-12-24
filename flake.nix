{
  description = "Dijk's Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    };

  outputs = inputs@{ nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations = {
	    bequiet  = inputs.nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
	    specialArgs = { inherit inputs; };
	    modules = [
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
	    framework  = inputs.nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
	    specialArgs = { inherit inputs; };
	    modules = [
	    	    inputs.nixos-facter-modules.nixosModules.facter
                    { config.facter.reportPath = ./hosts/framework/facter.json; }
	    	    ./hosts/framework/framework.nix
		    ./hosts/framework/configuration.nix
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
