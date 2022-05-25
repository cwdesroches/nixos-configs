{
  description = "nixos-configs";
  
  outputs = { self, nixpkgs }: let

    # users = {
    #   cwdesroches = user.mkUser {
    #     username = "cwdesroches";
    #     groups = [ "wheel" ];
    #     shell = pkgs.fish;
    #     packages = with pkgs;
    #       [
    #         emacs
    #         nmap
    #         ripgrep
    #         tailscale
    #         wally-cli
    #         brave
    #         discord
    #       ];
    #   };
    # };
    
  in {
    
    nixosConfigurations = {

      # Thinkpad x395
      x395-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./x395-nixos/configuration.nix ];
      };
      
    };
    
  };
}
