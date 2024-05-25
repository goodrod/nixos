local apps = require('configuration.apps')
local filesystem = require('gears.filesystem')

-- List of apps to start once on start-up
return {
  run_on_start_up = {
    'flameshot',
    'slack',
    'chromium-browser https://teams.microsoft.com/v2/',
    '~/.config/awesome/configuration/autostartonce.sh' -- Spawn "dirty" apps that can linger between sessions
  }
}
