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
  }: let
    configuration = {pkgs, ...}: {
      system = {
        stateVersion = 5;
        configurationRevision = self.rev or self.dirtyRev or null;
      };

      users.users.pjohnso3.home = "/Users/pjohnso3";
      nixpkgs.hostPlatform = "aarch64-darwin";

      environment.systemPackages = with pkgs; [
        vim
        git
        curl
        wget
      ];

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.fish.enable = true;
    };
  in {
    darwinConfigurations."HQ8968OSX" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
      ];
    };

    darwinPackages = self.darwinConfigurations."HQ8968OSX".pkgs;
  };
}
