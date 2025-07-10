   [Setup]
   AppName=Liminal
   AppVersion={#GetEnv('APP_VERSION')}
   DefaultDirName={commonpf}\Liminal
   DefaultGroupName=Liminal
   OutputBaseFilename=LiminalSetup_{#GetEnv('APP_VERSION')}
   Compression=lzma
   SolidCompression=yes

   [Files]
   Source: "..\build\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
   Source: "..\buildResources\appLauncherElectron.bat"; DestDir: "{app}"; Flags: ignoreversion
   Source: "..\buildResources\README.txt"; DestDir: "{app}"; Flags: ignoreversion

   [Icons]
   Name: "{group}\Liminal"; Filename: "{app}\appLauncherElectron.bat"
   Name: "{userdesktop}\Liminal"; Filename: "{app}\appLauncherElectron.bat"; Tasks: desktopicon
   Name: "{userdesktop}\Liminal README"; Filename: "{app}\README.txt"; Tasks: desktopicon
   Name: "{group}\Uninstall Liminal (Delete App Files)"; Filename: "{uninstallexe}"; Parameters: "/DELETE /ALLFILES"

   [Run]
   Filename: "{app}\custom_uninstaller.bat"; Parameters: "{app}"

   [Tasks]
   Name: "desktopicon"; Description: "Create a Liminal &desktop icon"; GroupDescription: "Liminal icons:"
