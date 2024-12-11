{ config, pkgs, nix-index-database, username, ... }: 

{
  # TODO please change the username & home directory to your own
  home = {
    username = "jason";
    homeDirectory = "/home/jason";
    sessionVariables.EDITOR = "nvim";
    # sessionVariables.SHELL = "/etc/profiles/per-user/jason/bin/fish";
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file."config/i3/wallpaper.jpg"./source = ./wallpaper.jpg;

  # link all files in ./scripts to ~/.config/i3/scripts
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true; # link recursively
  #   executable = true; # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #  xresources.properties = {
  #    "Xcursor.size" = 16;
  #    "Xft.dpi" = 172;
  #  };

  # font configuration
  fonts.fontconfig.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    # here is some command line tools that are useful
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager
    git
    git-crypt
    libgcc
    clang
    gdb

    # web browsers
    firefox-devedition
    brave
    tor
    chromium

    # core languages
    rustup
    rustc
    python3Full
    ruby
    crystal_1_9
    elixir_1_15
    erlang
    nodejs_22
    go
    jdk22

    # treesitter
    tree-sitter

    # text-editors
    vim
    neovim
    lunarvim
    vscode

    # shells
    zsh
    fish

    # language servers
    nodePackages.vscode-langservers-extracted # html, css, json, eslint
    nodePackages.yaml-language-server
    nil # nix

    # formatters and linters
    alejandra
    deadnix
    nodePackages.prettier
    shellcheck
    shfmt
    statix 

    # security tools
    burpsuite
    zap
    ghidra-bin
    nmap
    # wireshark
    tshark
    volatility3
    elasticsearch
    imhex
    hashcat
    metasploit
    rizin
    powersploit
    maltego

    # containers
    docker_27
    devbox

    # rust-stuff
    cargo-cache
    cargo-expand

    # terminals
    hyper
    alacritty
    kitty
    warp-terminal

    # fonts & prompts
    (pkgs.nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "Iosevka"
        "IosevkaTerm"
        "FiraCode"
        "0xProto"
        "Hack"
        "JetBrainsMono"
        "Meslo"
        "Ubuntu"
        "ZedMono"
      ];
    })
    oh-my-zsh
    oh-my-posh
    oh-my-git
    oh-my-fish
    
    # archives
    zip
    xz
    unzip
    p7zip
    gnutar

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for 'ls'
    fzf # Command-line fuzzy finder
    httpie
    mkcert
    gh
    just
    killall
    tmux
    zellij
    zip
    coreutils
    du-dust
    fd
    broot
    direnv
    mosh
    procs
    sl
    rustcat
    doggo
    rclone
    tree
    fx
    zoxide
    lsd
    lazygit

    # networking tools
    mtr # network diagnostic tool
    iperf3
    dnsutils # 'dig' + 'nslookup'
    ldns # replacement for 'dig', it provides the command 'drill'
    aria2 # lightweight multi-protocol # multi-source command-line downloader tool
    socat # replacement of openbsd-netcat
    nmap # Utility for network discovery and security auditing
    ipcalc # calculator for the IPv4/v6 addresses
    dig
    termshark
    wget
    curl
    rustscan

    # misc
    cowsay
    file
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    lolcat
    cgdb
    ffmpeg_7-full
    blender
    cava

    
    # nix related
    #
    # it provides the command 'nom' works just like 'nix'
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    obsidian 


    btop # replacement for htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for 'sensors' command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    coreutils
  ];

  # programs.nix-index-enable = true;
  # programs.nix-index-database.comma.enable = true;
  # programs.nix-index.enableFishIntegration = true;

  # fzf.enable = true;
  # fzf.enableFishIntegration = true;
  # lsd.enable = true;
  # lsd.enableAliases = true;
  # zoxide.enable = true;
  # zoxide.enableFishIntegration = true;
  # zoxide.options = ["--cmd cd"];
  # broot.enable = true;
  # broot.enableFishIntegration = true;
  # direnv.enable = true;
  # direnv.nix-direnv.enable = true;

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "trop3n";
    userEmail = "jasonkimm12@gmail.com";
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    extraConfig = {
    #  url = {
    #    "https://oauth2:${secrets.github_token}"@github.com" = {
    #      insteadOf = "https://github.com"
    #    };
    #  };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };

  # fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

      ${pkgs.lib.strings.fileContents (pkgs.fetchFromGitHub {
          owner = "rebelot";
          repo = "kanagawa.nvim";
          rev = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92";
          sha256 = "sha256-f/CUR0vhMJ1sZgztmVTPvmsAgp0kjFov843Mabdzvqo=";
        }
        + "/extras/kanagawa.fish")}

      set -U fish_greeting
    '';
  };

  # zellij
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = "fish";
      theme = "gruvbox-dark";
    };
  };

  # starship
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      git_branch.style = "242";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
    #  hostname.style = "bold green";
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      shell = {
        program = "fish";
        args = [ "--login" ];
      };
      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold"; 
        };
        italic = {
          family = "Hack Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Hack Nerd Font Mono";
          style = "Bold Italic";
        };
        size = 10;
        # draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.kitty = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home manager release that your configuration
  # is compatible with. This helps avoid breakage When a new home manager
  # release introduces backwards incompatible changes.
  # 
  # You can update home manager without changing this value. See
  # the home manager release notes for a list of state version 
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home manage install and manage itself.
  programs.home-manager.enable = true;
}