#USAGE

To upgrade:

1. Backup `~/panksomia_working/repos` where "~" is the OS user home directory.
2. Delete `~/panksomia_working/`
3. Move liminal-macos.zip to your Desktop.
4. Double-click liminal-macos-[type]-[version number].zip to expand its contents into a 'liminal-macos-[type]-[version number]' folder.
5. Open a terminal -- Launchpad (Application) > Utilities > Terminal
6. Type the following then enter:
     cd Desktop/liminal-macos-[type]-[version number]
          Use the values of [type] and [version number] from the folder expanded on your Desktop in step 4 above.
7. Type the following then enter:
     ./liminal.zsh
8. This will lead to a message saying "server.bin" Not Opened
9. Click either "Done" or "Cancel", depending on which of those options you have.
10. Go to Apple menu > System Preference >  Privacy and Security > General > and at the bottom, after "server.bin" was blocked, click "Allow Anyway" .
11. Wait until the "server.bin was blocked" message disappears from the settings page.
12. In the terminal type the following again then enter:
     ./liminal.zsh
13. Watch following load in the terminal window:
     OS = 'macos'
     Rocket has launched from http://127.0.0.1:8000
14. Restore backup from step 1 to `~/panksomia_working/repos`
15. Launch Firefox (or an alternate web browser), then direct it to the address above, or to:
     http://localhost:8000

First time use (not an upgrade):

1. Move liminal-macos.zip to your Desktop.
2. Double-click liminal-macos-[type]-[version number].zip to expand its contents into a 'liminal-macos-[type]-[version number]' folder.
3. Open a terminal -- Launchpad (Application) > Utilities > Terminal
4. Type the following then enter:
     cd Desktop/liminal-macos-[type]-[version number]
          Use the values of [type] and [version number] from the folder expanded on your Desktop in step 2 above.
5. Type the following then enter:
     ./liminal.zsh
6. This will lead to a message saying "server.bin" Not Opened
7. Click either "Done" or "Cancel", depending on which of those options you have.
8. Go to Apple menu > System Preference >  Privacy and Security > General > and at the bottom, after "server.bin" was blocked, click "Allow Anyway" .
9. Wait until the "server.bin was blocked" message disappears from the settings page.
10. In the terminal type the following again then enter:
     ./liminal.zsh
11. Watch following load in the terminal window:
     OS = 'macos'
     Rocket has launched from http://127.0.0.1:8000
12. Launch Firefox (or an alternate web browser), then direct it to the address above, or to:
     http://localhost:8000

Best viewed with a Graphite-enabled browser such as Firefox.