{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];

  boot.kernelModules = [ "v4l2loopback" ];

  boot.extraModprobeConfig = ''
    options v4l2loopback card_label="Virtual Camera"
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";

  networking.hostName = "x395-nixos"; # Define your hostname.

  networking = {
    useDHCP = false;
    interfaces.enp3s0f0.useDHCP = true;
    interfaces.wlp1s0.useDHCP = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  programs = {
    fish.enable = true;
    gnupg.agent.enable = true;
  };

  users.users.cwdesroches = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  system.stateVersion = "21.11";

}

