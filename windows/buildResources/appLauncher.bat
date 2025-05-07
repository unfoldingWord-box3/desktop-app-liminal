SET APP_RESOURCES_DIR=.\lib\
start .\bin\server.exe
SET URL=http://localhost:8000
if exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
	start "" "C:\Program Files\Mozilla Firefox\firefox.exe" %URL%
)
if exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
	start "" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" %URL%
)
if not exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
	if not exist "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
		start "" %URL%
	)
)
