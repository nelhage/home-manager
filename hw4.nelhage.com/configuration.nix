{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOj/9YTjI5Pr3TrzFMr9ADLTw7yeJZ6jCejXRL9N0rku nelhage@mythique"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZA2k+GfubMI9WPc9tyX0Vw3xXvUOuaDcrdyNeAzfgf nelhage@pedagogique"
  ];

  system.stateVersion = "23.11";
}
