{
  pkgs,
  self,
  ...
}: {
  # Basic system configuration
  system = {
    primaryUser = "pjohnso3";
    stateVersion = 5;
    configurationRevision = self.rev or self.dirtyRev or null;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.pjohnso3.home = "/Users/pjohnso3";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Packages
  programs.fish.enable = true;
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
    pkgs.curl
    pkgs.wget
  ];

  # Nix settings
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.warn-dirty = false;

  nix.gc.automatic = true;
  nix.gc.interval.Hour = 2;

  nix.optimise.automatic = true;
  nix.optimise.interval.Hour = 2;

  # Services
  # services.skhd.enable = true;
}
