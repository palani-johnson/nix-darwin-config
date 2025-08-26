{
  pkgs,
  self,
  ...
}: {
  system = {
    primaryUser = "pjohnso3";
    stateVersion = 5;
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  users.users.pjohnso3.home = "/Users/pjohnso3";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.curl
    pkgs.wget
    pkgs.home-manager
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.warn-dirty = false;
  programs.fish.enable = true;

  nix.gc.automatic = true;
  nix.gc.interval.Hour = 2;

  nix.optimise.automatic = true;
  nix.optimise.interval.Hour = 2;

  security.pam.services.sudo_local.touchIdAuth = true;
}
