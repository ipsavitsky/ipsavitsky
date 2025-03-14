build_system host:
    nom build .#nixosConfigurations.{{host}}.config.system.build.toplevel

check_system host: (build_system host)
    nvd diff /run/current-system ./result

switch host: (check_system host)
    sudo ./result/bin/switch-to-configuration switch
