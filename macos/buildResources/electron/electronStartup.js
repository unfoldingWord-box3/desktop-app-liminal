const { app, BrowserWindow, Menu, shell} = require('electron');
const { spawn, execSync } = require('child_process');
const path = require('path');

let serverProcess = null;
app.name = 'Liminal';

// Function to check if server is running (on port 8000)
function isServerRunning() {
  try {
    // macOS & Linux: use lsof; Windows would require a different approach
    execSync('lsof -i:8000 | grep LISTEN', { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

function startServer() {
  if (!isServerRunning()) {
    const serverPath = path.join(__dirname, '..', 'bin', 'server.bin');
    const resourcesDir = path.join(__dirname, '..', 'lib');
    console.log('resourcesDir is ' + resourcesDir);
    serverProcess = spawn(serverPath, [], {
      stdio: 'ignore',
      detached: true,
      env: {...process.env, APP_RESOURCES_DIR: resourcesDir}
    });
    serverProcess.unref();
    console.log('Server started.');
  } else {
    console.log('Server already running.');
  }
}

function stopServer() {
  if (serverProcess) {
    // Kill the process we spawned (or use another mechanism if you need gentle shutdown)
    try {
      process.kill(serverProcess.pid);
      console.log('Server stopped.');
    } catch (e) {
      // It may have already exited
    }
  } else {
    // Optionally: kill whatever is listening on port 8000
    try {
      execSync("lsof -t -i:8000 | xargs kill -9");
      console.log('Server stopped forcefully.');
    } catch {
      // ignore if nothing is running
    }
  }
}

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600
  });

  win.loadURL('http://127.0.0.1:8000');
}

app.whenReady().then(() => {
  // Set a custom menu with desired app name
  const isMac = process.platform === 'darwin';
  if (isMac) {
    const template = [
      {
        label: 'Liminal', // <--- This name will show in the macOS app menu
        submenu: [
          {role: 'about'},
          {type: 'separator'},
          {role: 'services'},
          {type: 'separator'},
          {role: 'hide'},
          {role: 'hideothers'},
          {role: 'unhide'},
          {type: 'separator'},
          {role: 'quit'}
        ]
      },
      {
        label: 'Edit',
        submenu: [
          {role: 'undo'},
          {role: 'redo'},
          {type: 'separator'},
          {role: 'cut'},
          {role: 'copy'},
          {role: 'paste'},
          {role: 'pasteAndMatchStyle'},
          {role: 'delete'},
          {role: 'selectAll'}
        ]
      },
      {
        label: 'View',
        submenu: [
          {role: 'reload'},
          {role: 'forcereload'},
          {role: 'toggledevtools'},
          {type: 'separator'},
          {role: 'resetzoom'},
          {role: 'zoomin'},
          {role: 'zoomout'},
          {type: 'separator'},
          {role: 'togglefullscreen'}
        ]
      },
      {
        label: 'Window',
        submenu: [
          {role: 'minimize'},
          {role: 'zoom'},
          {type: 'separator'},
          {role: 'front'},
          {role: 'window'}
        ]
      },
      {
        label: 'Help',
        submenu: [
          {
            label: 'Learn More',
            click: async () => {
              await shell.openExternal('https://electronjs.org');
            }
          }
        ]
      }
    ];
    const menu = Menu.buildFromTemplate(template);
    Menu.setApplicationMenu(menu);
  }
  
  startServer();
  setTimeout(createWindow, 2000); // Wait 2 seconds for server to start (adjust as needed)
});

app.on('window-all-closed', () => {
  // On macOS, apps are expected to stay alive until explicitly quit
  // but we quit anyway so server doesn't remain running
  app.quit();
});

app.on('will-quit', () => {
  stopServer();
});

app.on('before-quit', () => {
  stopServer();
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});