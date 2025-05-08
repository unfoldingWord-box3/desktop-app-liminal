Steps to run makeInstall.zsh:
1. first run build-server script
2. then cd into `macos/install`
3. make sure APP_VERSION environment variable is set. Such as `export APP_VERSION="0.2.7"`
4. then run:
```shell
chmod +x ./makeInstall.zsh
./makeInstall.zsh
```