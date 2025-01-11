{ config, pkgs, lib, nix-index-database, username, inputs, ... }:

{
  # imports = [
  # nixvim.homeManagerModules.nixvim
  # nixvim.nixosModules.nixvim
  # ];

  #colorScheme = nix-colors.colorSchemes.tokyo-night-storm;
  # TODO please change the username & home directory to your own

  home = {
    username = "jason";
    homeDirectory = "/home/jason";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "alacritty";
      LANG = "en_US.UTF-8";
      FZF_CTRL_T_OPTS = "--preview 'bat -n --color=always --theme='Catppuccin Mocha' --line-range :500 {}'";
      FZF_ALT_C_OPTS = "--preview 'eza --tree --color=always {} | head -200'";
    };

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
    fastfetch
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

    # python + packages
    python3Full
    python312Packages.scrapy
    poetry

    # core languages
    rustup
    rustc
    ruby
    crystal_1_9
    erlang
    nodejs_23
    go
    elixir_1_16
    dart
    gleam
    scala
    lua

    # dev environments
    android-studio
    android-studio-tools

    # treesitter
    tree-sitter

    # text-editors
    vim
    neovim
    vscode
    zed-editor
    sublime4
    helix
  
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
    sqlmap

    # containers
    docker_27
    devbox
    qemu
    virtualbox
    virt-manager
    libvirt
    virt-viewer
    bridge-utils

    # rust-stuff
    cargo-cache
    cargo-expand

    # terminals
    # hyper
    alacritty
    kitty
    warp-terminal
    ghostty

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
    karla
    julia-mono
    fantasque-sans-mono
    mononoki

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
    lf

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
    ags

    # gaming
    mangohud
    protonup
    discord
    lutris

    #gamedev
    unityhub
    pixelorama
    godot_4
    krita
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # programs.nix-index-enable = true;
  # programs.nix-index-database.comma.enable = true;
  # programs.nix-index.enableFishIntegration = true;

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;
  programs.lsd.enable = true;
  # programs.lsd.enableAliases = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;
  programs.zoxide.options = ["--cmd cd"];
  programs.broot.enable = true;
  programs.broot.enableFishIntegration = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # nixvim
  # programs.nixvim.enable = true;

  # neovim
  /* programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
    extraLuaConfig = ''
      vim.g.mapleader = " "
      require("lazy").setup({
        performance = {
          reset_packpath = false,
          rtp = {
              reset = false,
            }
          spec = {
            { import = "plugins" },
          },
          },
        dev = {
          path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = {""},
        },
        install = {
          missing = false,
        },
      })
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  }; */

  # basic configuration of git
  programs.git = {
    enable = true;
    userName = "trop3n";
    userEmail = "jasondkimm@proton.me";
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

  # helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai_pro_spectrum";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
    }];
    themes = {
      monokai_pro_spectrum = {
        "inherits" = "monokai_pro";
        "ui.background" = { };
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
    functions = {
        refresh = "source $HOME/.config/fish/config.fish";
        take = ''mkdir -p -- "$1" && cd -- "$1"'';
        ttake = "cd $(mktemp -d)";
        show_path = "echo $PATH | tr ' ' '\n'";
        posix-source = ''
          for i in (cat $argv)
            set arr (echo $i |tr = \n)
            set -gx $arr[1] $arr[2]
          end
        '';
    };
    shellAbbrs =
      {
        gc = "nix-collect-garbage --delete-old";
      }
      # navigation shortcuts
      // {
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
      }
      # git shortcuts
      // {
        ga = "git add'";
        gc = "git commit -m";
        gcl = "git clone --depth 1'";
        gi = "git init";
        gp = "git push origin master";
      };

    shellAliases = {
      lvim = "nvim";
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      ls = "exa --icons";
      l = "exa --icons -lh";
      ll = "exa --icons -lah";
      la = "exa --icons -A";
      lm = "exa --icons -m";
      lr = "exa --icons -R";
      lg = "exa --icons -l --group-directories-first";
      gcl = "git clone --depth 1";
      gi = "git init";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push origin master";
    };
    plugins = [
      {
        inherit (pkgs.fishPlugins.autopair) src;
        name = "autopair";
      }
      {
        inherit (pkgs.fishPlugins.done) src;
        name = "done";
      }
      {
        inherit (pkgs.fishPlugins.sponge) src;
        name = "sponge";
      }
    ];
  };
  
  # zellij
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = "fish";
      theme = "tokyo-night-storm";
    };
  };

  # starship
  programs.starship = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      hostname.style = "bold cyan";
      username = {
        style_user = "bright-green bold";
        style_root = "bright-blue bold";
      };
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      terminal.shell = {
        program = "fish";
        args = [ "--login" ];
      };
      font = {
        normal = {
          family = "Fantasque Sans Mono";
          style = "Regular";
        };
        bold = {
          family = "Fantasque Sans Mono";
          style = "Bold";
        };
        italic = {
          family = "Fantasque Sans Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Fantasque Sans Mono";
          style = "Bold Italic";
        };
        size = 10;
        # draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      # decorations.none = true;
      window.opacity = 0.7;
      window.blur = true;
    };
  };
 
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  programs.kitty = {
    enable = true;
  };

  programs.cava = {
    enable = true;
    settings = {
      general.framerate = 60;
      general.bars = 256;
      general.bar_width = 1;
      general.bar_spacing = 1;
      color = {
        gradient = 1;
        gradient_count = 8;
        gradient_color_1 = "'#ffffff'";
        gradient_color_2 = "'#d95468'";
        gradient_color_3 = "'#ebbf83'";
        gradient_color_4 = "'#8bd49c'";
        gradient_color_5 = "'#539afc'";
        gradient_color_6 = "'#70e1e8'";
        gradient_color_7 = "'#b62d65'";
        gradient_color_8 = "'#b62d65'";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  # environment.pathsToLink = [ "/share/bash-completion" ];
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      ls = "exa --icons";
      l = "exa --icons -lh";
      ll = "exa --icons -lah";
      la = "exa --icons -A";
      lm = "exa --icons -m";
      lr = "exa --icons -R";
      lg = "exa --icons -l --group-directories-first";
      gcl = "git clone --depth 1";
      gi = "git init";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push origin master";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # environment.pathsToLink = [ "/share/zsh" ];
    antidote.enable = true;
    antidote.plugins = [
      "zsh-users/zsh-autosuggestions"
    ];
    autosuggestion.highlight = true;
    autosuggestion.strategy = [
      "history"
    ];
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      ls = "exa --icons";
      l = "exa --icons -lh";
      ll = "exa --icons -lah";
      la = "exa --icons -A";
      lm = "exa --icons -m";
      lr = "exa --icons -R";
      lg = "exa --icons -l --group-directories-first";
      gcl = "git clone --depth 1";
      gi = "git init";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push origin master";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableZshIntegration = true;
    useTheme = "emodipt-extend";
  };
  
  # This value determines the home manager release that your configuration
  # is compatible with. This helps avoid breakage When a new home manager
  # release introduces backwards incompatible changes.
  #
  # You can update home manager without changing this value. See
  # the home manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home manage install and manage itself.
  programs.home-manager.enable = true;
}
