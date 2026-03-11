{ config, pkgs, ... }:

{
  home.username = "tom-blk";
  home.homeDirectory = "/home/tom-blk";

  # REQUIRED: stateVersion
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Packages
  home.packages = with pkgs; [
    # Free
    hyprland
    waybar
    wl-clipboard
    nerd-fonts.droid-sans-mono
    shotcut
    gimp
    shutter
    opencode
    tree-sitter
    ripgrep
    gcc
    fzf
    jq
    swaybg
    fd
    ast-grep
    python3
    lazygit
    curl
    unzip
    gzip
    nixd
    nodejs_24
    go
    signal-desktop
    telegram-desktop
    libreoffice
    grimblast

    #Unfree
    spotify
    antigravity
    obsidian
    brave
    code-cursor
  ];

  programs.claude-code = {
   enable = true;
   agentsDir = /home/tom-blk/code/agency-agents;
  };

  # Dotfiles

  ## Hyprland
  xdg.configFile."hypr/hyprland.conf".source = ./dotfiles/hypr/hyprland.conf;

  ## Rofi
  xdg.configFile."rofi/theme.rasi".source = ./dotfiles/rofi/theme.rasi;

  ## Alacritty
  xdg.configFile."alacritty".source = ./dotfiles/alacritty;

  ## Neovim
  xdg.configFile."nvim".source = ./dotfiles/nvim;

  # Fonts
  fonts.fontconfig.enable = true;

  # Bash
  programs.bash = {
    enable = true;
    initExtra = ''
      PS1="\[\033[1;32m\][\u@\h:\w]\\$\[\033[0m\] "
      .. () { cd ..; }
      :q () { exit; }
      ,, () { clear; }
    '';
    shellAliases = {
      la = "ls -la";
      d = "mkdir";
      f = "touch";
      gaa = "git add .";
      gcm = "git commit -m";
      gp = "git push";
      gpu = "git pull";
      gco = "git checkout";
      gcb = "git checkout -b";
      nixclean = "sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage -d";
    };
  };

  # SSH
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/github/github";
      };
      "oxlo-dev" = {
        hostname = "52.158.46.180";
        user = "cyborg";
        identityFile = "~/.ssh/cyborg/cyborg_alpha_key";
      };
      "oxlo-backend" = {
        hostname = "40.81.231.55";
        user = "oxlo";
        identityFile = "~/.ssh/cyborg/oxkey.pem";
      };
    };
  };

  # Tmux
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    prefix = "f5";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      tokyo-night-tmux
    ];
  };

  # Dropbox
  services.dropbox.enable = true;

  # Theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Default Apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "brave" ];
      "x-scheme-handler/http" = [ "brave" ];
      "x-scheme-handler/https" = [ "brave" ];
    };	
  };

  # Scripts
  home.file.".local/bin/work" = {
    source = ./dotfiles/scripts/work.sh;
    executable = true;
  };
  home.file.".local/bin/personal" = {
    source = ./dotfiles/scripts/personal.sh;
    executable = true;
  };
}
