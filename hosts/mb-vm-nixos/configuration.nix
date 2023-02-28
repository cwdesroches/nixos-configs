{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "mb-vm-nixos";

  networking = {
    useDHCP = true;
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

  services = {
    openssh.enable = true;

    pipewire = {
      enable = true;
    };

    xserver = {
      enable = true;
    };
  };

  programs = {
    fish.enable = true;
    gnupg.agent.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
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

  system.stateVersion = "22.11";

}
