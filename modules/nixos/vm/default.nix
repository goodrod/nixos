{ lib, config, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf mkOption types;
  option = config.module.vm;
in {
  options.module.vm = {
    enable = mkEnableOption "KVM/libvirt VM host (virt-manager compatible)";

    username = mkOption {
      type = types.str;
      default = "goodrod";
      description = "User to grant libvirt/kvm access to.";
    };

    installTools = mkOption {
      type = types.bool;
      default = true;
      description =
        "Install virt-manager and common userspace tools system-wide.";
    };

    enableSpiceUsbRedir = mkOption {
      type = types.bool;
      default = true;
      description = "Enable SPICE USB redirection support.";
    };
  };

  config = mkIf option.enable {
    # Core: provides the daemon + sockets virt-manager connects to (qemu:///system)
    virtualisation.libvirtd.enable = true;

    # Optional quality-of-life
    virtualisation.spiceUSBRedirection.enable = option.enableSpiceUsbRedir;

    # Permissions for /dev/kvm and libvirt socket access
    users.users.${option.username}.extraGroups = [ "kvm" "libvirtd" ];

    # Tools (virt-manager is just a client, but convenient to have system-wide)
    environment.systemPackages = lib.optionals option.installTools (with pkgs; [
      virt-manager
      virt-viewer
      qemu_kvm
      libvirt
      swtpm
      spice-gtk
      gtk-vnc
    ]);
  };
}

