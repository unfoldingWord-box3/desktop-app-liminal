# desktop-app-liminal
A Pankosmia App

## Ecosystem setup and configuration
This repo pulls together several libraries and projects into a single app. The projects are spread across several repos to allow modular reuse. The sanest way to get this working is to install the repos with the following structure:

```
pankosmia
-- pithekos (currently we borrow its templates, webfonts and setup)
-- pankosmia_web
-- desktop-app-liminal
-- core-client-dashboard repository
-- core-client-settings repository
-- core-client-workspace repository 
-- core-client-remote-repos repository
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
```text
cargo build
```

## Installing the builder
**This is at the root of the repo**
```text
npm install
```

## Building for Linux
```text
cd linux/build/scripts
node build.js
```

You can bundle up the built linux project as a tgz file with the following incantation from the `build` directory.
```text
tar cfz ../../releases/linux/liminal.tgz .
```

## Building for Windows (untested and almost certainly broken)
```text
cd windows/build/scripts
node build.js
```

We need a Windows equivalent to a linux tgz file for bundling (zip?).