## Building

### Building MacOS installer from release
1. cd into `macos/install`
3. edit `makeAllInstalls.sh` update URL to latest Liminal build
3. then run from `macos/install`:
```shell
chmod +x ./makeAllInstalls.zsh
./makeAllInstalls.zsh
```

### Building app locally
1. first run build-server script
2. then cd into `macos/install`
3. make sure APP_VERSION environment variable is set. Such as `export APP_VERSION="0.2.7"`
4. then run from `macos/install`:
```shell
chmod +x ./makeInstall.zsh
./makeInstall.zsh
```