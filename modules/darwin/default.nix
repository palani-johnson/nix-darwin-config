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

  users.users.pjohnso3 = {
    home = "/Users/pjohnso3";
  };
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Packages
  programs.fish.enable = true;
  environment.systemPackages = [
    # Command line tools
    pkgs.vim
    pkgs.git
    pkgs.curl
    pkgs.wget

    # Games
    pkgs.prismlauncher

    # VMs
    pkgs.utm
  ];

  # Nix settings
  nix = {
    settings.experimental-features = "nix-command flakes";
    settings.warn-dirty = false;

    gc = {
      automatic = true;
      interval.Hour = 2;
      options = "--delete-old";
    };

    optimise = {
      automatic = true;
      interval.Hour = 2;
    };
  };

  # Services
  # services.skhd.enable = true;
}
