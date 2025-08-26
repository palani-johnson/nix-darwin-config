{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nix-darwin,
    home-manager,
    ...
  }: {
    darwinConfigurations."HQ8968OSX" = nix-darwin.lib.darwinSystem {
      modules = [
        # System
        ./modules/darwin

        # Home
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.pjohnso3 = import ./modules/home;
          home-manager.verbose = true;
        }
      ];
      specialArgs = {
        inherit self;
      };
    };
  };
}
