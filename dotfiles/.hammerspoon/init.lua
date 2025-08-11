hs = hs

-- Function to toggle Arc browser
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "A", function()
	hs.application.launchOrFocus("Arc")
end)

-- Function to toggle Safari browser
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "S", function()
	local appName = "Safari"
	local app = hs.application.get(appName)

	if app then
		local mainWindow = app:mainWindow()
		if mainWindow then
			-- Ensure the app is brought to the front and move to its space
			mainWindow:focus()
		else
			-- If the app has no main window, just activate it
			app:activate()
		end
	else
		-- Launch the app if not running
		hs.application.launchOrFocus(appName)
	end
end)

-- Function to toggle Alacritty terminal
hs.hotkey.bind({ "cmd" }, "return", function()
	local appName = "Alacritty"
	local app = hs.application.get(appName)

	if app then
		local mainWindow = app:mainWindow()
		if mainWindow then
			-- Ensure the app is brought to the front and move to its space
			mainWindow:focus()
		else
			-- If the app has no main window, just activate it
			app:activate()
		end
	else
		-- Launch the app if not running
		hs.application.launchOrFocus(appName)
	end
end)

-- Auto reload hammerspoon config
function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
