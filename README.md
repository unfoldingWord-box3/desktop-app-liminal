# desktop-app-liminal
A Pankosmia App

## Ecosystem setup and configuration
This repo pulls together several libraries and projects into a single app. The projects are spread across several repos to allow modular reuse. The sanest way to get this working is to install [the repos](https://github.com/pankosmia/repositories) with the following structure:

```
pankosmia
-- pithekos (currently we borrow its templates, webfonts and setup)
-- pankosmia_web
-- desktop-app-liminal
-- core-client-dashboard repository
-- core-client-settings repository
-- core-client-workspace repository
-- core-client-content repository
-- core-client-remote-repos repository
-- xenizo-parallel-gospels
-- core-client-i18n-editor repository
```

*It Should Just Work* if your pankosmia directory is under `repos` under your user directory, ie `/home/myname/repos/pankosmia` in Linux.

Pankosmia_web serves compiled files from the `build` directory of each client, so you need to build each client:
```
# In each client repo, NOT this repo!
npm install
npm run build
```

You also need to build pankosmia_web:
# In pankosmia_web repo, NOT this repo!
Linux or Windows:
```text
cargo build --release
```
MacOS:
```text
OPENSSL_STATIC=yes cargo build --release
```

## Installing the builder (back to _this_ repo!)
**This is at the root of the repo**
```text
npm install
```

## Building
Linux:
```text
cd linux/scripts
node build.js
```
Windows:
```text
cd windows/scripts
node build.js
```
MacOS:
```text
cd macos/scripts
node build.js
```
## Bundling
You can bundle up the built project with the following incantation:

Linux (tgz):
```text
cd ../build
tar cfz ../../releases/linux/liminal-linux.tgz .
```

MacOS (zip):
```text
cd ../build
chmod 755 liminal.zsh
zip -r ../../releases/macos/liminal-macos.zip *
```
Windows Powershell (exe):
1. Install [Inno Setup](https://jrsoftware.org/isdl.php) -tested with v6.4.3
2. In powershell, enter the following where where 0.2.7 is the new version number:
```text
cd ../install
$env:APP_VERSION = "0.2.7"
.\makeInstall.bat
```

Or, if you really want a windows zip file -- Windows Powershell (zip):
```text
cd ../build
Compress-Archive * ../../releases/windows/liminal-windows.zip
```
(Delete /releases/windows/liminal-windows.zip first, if it already exists.)
