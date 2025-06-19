build_system host:
    nom build .#nixosConfigurations.{{ host }}.config.system.build.toplevel

switch host: (build_system host)
    sudo ./result/bin/switch-to-configuration switch

build_configuration conf:
    nom build .#homeConfigurations.{{ conf }}.activationPackage

build_sd_image host:
    nom build .#nixosConfigurations.{{ host }}.config.system.build.sdImage
