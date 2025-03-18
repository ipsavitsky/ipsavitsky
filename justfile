build_system host:
    nom build .#nixosConfigurations.{{host}}.config.system.build.toplevel

check_system host: (build_system host)
    nvd diff /run/current-system ./result

switch host: (check_system host)
    sudo ./result/bin/switch-to-configuration switch

build_configuration conf:
    nom build .#homeConfigurations.{{conf}}.activationPackage

check_config host: (build_configuration host)
    nvd diff ~/.local/state/home-manager/gcroots/current-home ./result

configure conf: (check_config conf)
   ./result/bin/home-manager-generation switch
