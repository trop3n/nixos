# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixvim, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Stylix configuration
  stylix = {
    enable = true;
    image = ./wallhaven-jx2rxw.jpg;
    base16Scheme = {
      base00 = "#1d252c";  # Background
      base01 = "#2a343d";  # Lighter Background
      base02 = "#3a4654";  # Selection Background
      base03 = "#54687a";  # Comments, Invisibles
      base04 = "#6a7a8a";  # Dark Foreground
      base05 = "#a0a8b6";  # Default Foreground
      base06 = "#c0c8d6";  # Light Foreground
      base07 = "#e0e8f6";  # Light Background
      base08 = "#ff5874";  # Red
      base09 = "#ff966c";  # Orange
      base0A = "#ffcc99";  # Yellow
      base0B = "#a8d1a5";  # Green
      base0C = "#9cd1be";  # Cyan
      base0D = "#82aaff";  # Blue
      base0E = "#c792ea";  # Purple
      base0F = "#d6deeb";  # Light Foreground (Alternative)
    };
    homeManagerIntegration.followSystem = true;
    opacity = {
      applications = 0.7;
      terminal = 0.7;
    };
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.karla;
        name = "Karla";
      };
      sansSerif = {
        package = pkgs.karla;
        name = "Karla";
      };
      monospace = {
        package = pkgs.fantasque-sans-mono;
        name = "Fantasque Sans Mono";
      };
    };
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
  };
  stylix.targets = {
    gtk.enable = true;
    # qt.enable = true;
    chromium.enable = true;
    fish.enable = true;
    grub.enable = true;
    nixos-icons.enable = true;
    nixvim.enable = true;
    # nixvim.plugin = "base16-nvim";
  };

  # Set the default editor to vim
  environment.variables.EDITOR = "nvim";

  fonts.fontDir.enable = true;

  # systemd bootloader.
  # boot.loader = {
  #   systemd-boot = {
  #     enable = true;
  #     configurationLimit = 10;
  #     editor = false;
  #     consoleMode = "max";
  #     extraEntries = {
  #       "arch.conf" = ''
  #         title Arch Linux
  #         linux /vmlinuz-linux
  #         initrd /intel-ucode.img
  #         initrd /initramfs-linux.img
  #         options root=UUID=59f9c4f1-16a0-4877-8c6b-23e2e504d4e3 rw
  #        '';
  #       "windows.conf" = ''
  #         title Windows 11
  #         efi /EFI/Microsoft/Boot/bootmgfw.efi
  #        '';
  #     };
  #   };
  #   efi.canTouchEfiVariables = true;
  #   grub.enable = false;
  #   timeout = 20;
  # };

  # GRUB
  boot.loader = {
  efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = 10;
      extraEntries = ''
        menuentry "Arch Linux" {
          set root=(hd3,gpt1)
          linux /vmlinuz-linux root=UUID=59f9c4f1-16a0-4877-8c6b-23e2e504d4e3 rw
          initrd /initramfs-linux.img
        }
     '';
    };
  };


  # Perform garbage collection weelky to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # libvirt
  virtualisation.libvirtd = {
    enable = true;
    package = pkgs.qemu_kvm; # Use the QEMU package with KVM support
  };

  # Optimize Storage
  # You can optimize the store manually via:
  # nix-store --optimize
  # refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # System time
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # /etc/hosts replacement
  # networking.extraHosts = ''
  # ''

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # enable OpenGL
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32bit = true;
  };

  # steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Load local Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required
    modesetting.enable = true;

    # prime activation
    # prime = {
    #   sync.enable = true;
    #   nvidiaBusId = "PCI:1:0:0";
    # };

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if your have graphical corruption issues or application crashes after
    # waking up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the Nvida open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver)/
    # Support is limited to the Turing and later architectures. Full list of supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via 'nvidia-settings'.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # postgresql
#   services.postgresql = {
#     enable = true;
#     ensureDatabases = [ "msf" ];
#     ensureUsers = [
#       {
#         name = "msf";
#         ensurePermissions = {
#           "DATABASE msf" = "ALL PRIVILEGES";
#         };
#       }
#     ];
#   };
#   systemd.services.postgresql = {
#     wantedBy = [ "multi-user.target" ];
#   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jason = {
    isNormalUser = true;
    description = "jason";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
      wireshark
      efibootmgr
      os-prober
      vscodium
    #  thunderbird
    ];

};

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
