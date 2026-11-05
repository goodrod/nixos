{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.gaming.curseforge;

  unwrapped = pkgs.stdenvNoCC.mkDerivation {
    pname = "curseforge-unwrapped";
    version = "latest";

    # Overwolf only publishes an unversioned URL, so flake.lock is what pins it.
    # `nix flake update curseforge` moves to the current release.
    src = inputs.curseforge;

    nativeBuildInputs = [ pkgs.dpkg ];

    unpackPhase = ''
      dpkg-deb -x "$src" .
    '';

    installPhase = ''
      mkdir -p "$out"
      cp -r opt usr/share "$out"/
    '';

    # Curse.Agent.Host is a .NET single-file bundle, which patchelf corrupts.
    # That is why this runs in an FHS env instead of being patched.
    dontFixup = true;

    meta.license = lib.licenses.unfree;
  };

  curseforge = pkgs.buildFHSEnv (
    pkgs.appimageTools.defaultFhsEnvArgs
    // {
      pname = "curseforge";
      version = "latest";

      targetPkgs =
        p:
        pkgs.appimageTools.defaultFhsEnvArgs.targetPkgs p
        ++ (with p; [
          icu # .NET aborts at startup without it
          libnotify
          libappindicator-gtk3
        ]);

      runScript = "${unwrapped}/opt/CurseForge/curseforge";

      extraInstallCommands = ''
        mkdir -p "$out/share/applications"
        cp -r ${unwrapped}/share/icons "$out/share/"
        sed -e "s|^Exec=.*|Exec=$out/bin/curseforge %U|" \
          -e "s|^Categories=.*|Categories=Game;|" \
          ${unwrapped}/share/applications/curseforge.desktop \
          > "$out/share/applications/curseforge.desktop"
      '';
    }
  );
in
{
  options.module.gaming.curseforge = {
    enable = mkEnableOption "the CurseForge mod manager";
  };

  config = mkIf settings.enable {
    environment.systemPackages = [ curseforge ];
  };
}
