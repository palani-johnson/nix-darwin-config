{
  description = "Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nix-darwin,
    ...
  }: {
    darwinConfigurations."HQ8968OSX" = nix-darwin.lib.darwinSystem {
      modules = [
        ./modules/darwin
      ];
      specialArgs = {
        inherit self;
      };
    };
  };
}
