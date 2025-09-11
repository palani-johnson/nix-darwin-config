{pkgs, ...}: let
  me = "pjohnso3";
  homeDir = "/Users/${me}";
  configDir = "${homeDir}/.config";

  sessionVariables = {
    EDITOR = "code";

    # XDG fixes
    GOPATH = "$XDG_DATA_HOME/go";
    GOMODCACHE = "$XDG_CACHE_HOME/go/mod";

    # Bitwarden SSH Agent
    SSH_AUTH_SOCK = "/Users/pjohnso3/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
  };
in {
  home = {
    username = me;
    homeDirectory = homeDir;
    stateVersion = "24.11";

    # make sure these are not gui programs
    packages = [
      # nix
      pkgs.nil
      pkgs.alejandra
      pkgs.devenv

      # docker
      pkgs.docker
      pkgs.docker-credential-helpers
      pkgs.colima
      pkgs.kubectl

      # python
      (pkgs.python3.withPackages (p: [
        p.ipykernel
        p.nbconvert
      ]))
      pkgs.ruff

      # just
      pkgs.just

      # node
      pkgs.nodejs
      pkgs.nodePackages.prettier
      pkgs.pnpm

      # terraform
      pkgs.terraform

      # azure
      (pkgs.azure-cli.withExtensions [pkgs.azure-cli.extensions.containerapp])
    ];

    sessionVariables = sessionVariables;
    preferXdgDirectories = true;

    file.".config/colima" = {
      source = ./colima;
      force = true;
      recursive = true;
    };

    shell.enableShellIntegration = true;
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    carapace.enable = true;

    zsh = {
      enable = true;
      sessionVariables = sessionVariables;
      dotDir = "${configDir}/zsh";
      history.path = "$HOME/.cache/zsh/history";
      initContent = builtins.readFile ./zsh/initExtra.zsh;
      enableCompletion = true;
      prezto.enable = true;
    };

    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/extraConfig.nu;
      environmentVariables = sessionVariables;
    };

    git = {
      enable = true;
      userName = "Palani Johnson";
      userEmail = "palanijohnson@gmail.com";
      extraConfig.init.defaultBranch = "main";
      extraConfig.core.pager = "cat";
    };

    starship = {
      enable = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        format = "$username$hostname$directory$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$sudo$status$shell$character";

        fill.disabled = false;
        fill.symbol = " ";
        shell.disabled = false;
        cmd_duration.format = "[$duration]($style) ";
        git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
        nix_shell.format = "[ $name]($style) ";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      config = {
        global.warn_timeout = "1m";
        whitelist.prefix = [
          "~/Projects"
        ];
      };
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "Default";
        theme_background = false;
        proc_tree = true;
        proc_left = true;
      };
    };
  };
}
