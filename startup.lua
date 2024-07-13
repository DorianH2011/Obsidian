local function download(url, path)
    local response = http.get(url)
    if response then
        local file = fs.open(path, "w")
        file.write(response.readAll())
        file.close()
        response.close()
    else
        error("Failed to download " .. url)
    end
end

-- Create /obsidian folder if it doesn't exist
if not fs.exists("/obsidian") then
    fs.makeDir("/obsidian")
end

-- Download Basalt library
local basaltUrl = "https://raw.githubusercontent.com/Pyroxenium/Basalt/main/basalt.lua"
local basaltPath = "/obsidian/basalt.lua"
download(basaltUrl, basaltPath)

-- Create main.lua script in /obsidian folder
local mainScript = [[
local basalt = require("obsidian.basalt")

-- Create main frame
local mainFrame = basalt.createFrame("mainFrame")

-- Create main menu window
local mainMenuWindow = mainFrame:addWindow("mainMenuWindow")
mainMenuWindow:setSize("parent.w", "parent.h")

-- Create buttons for menu
local button1 = mainMenuWindow:addButton("button1")
button1:setPosition(3, 3)
button1:setSize(15, 3)
button1:setText("Option 1")

local button2 = mainMenuWindow:addButton("button2")
button2:setPosition(3, 7)
button2:setSize(15, 3)
button2:setText("Option 2")

local exitButton = mainMenuWindow:addButton("exitButton")
exitButton:setPosition(3, 11)
exitButton:setSize(15, 3)
exitButton:setText("Exit")

-- Create second window for option 1
local option1Window = mainFrame:addWindow("option1Window")
option1Window:setSize("parent.w", "parent.h")
option1Window:setVisible(false)
option1Window:addLabel("label"):setPosition(3, 3):setText("This is option 1")

-- Create second window for option 2
local option2Window = mainFrame:addWindow("option2Window")
option2Window:setSize("parent.w", "parent.h")
option2Window:setVisible(false)
option2Window:addLabel("label"):setPosition(3, 3):setText("This is option 2")

-- Button events
button1:onClick(function()
    mainMenuWindow:setVisible(false)
    option1Window:setVisible(true)
end)

button2:onClick(function()
    mainMenuWindow:setVisible(false)
    option2Window:setVisible(true)
end)

exitButton:onClick(function()
    basalt.stop()
end)

-- Navigation to main menu
option1Window:addButton("backButton1"):setPosition(3, 7):setSize(15, 3):setText("Back")
    :onClick(function()
        option1Window:setVisible(false)
        mainMenuWindow:setVisible(true)
    end)

option2Window:addButton("backButton2"):setPosition(3, 7):setSize(15, 3):setText("Back")
    :onClick(function()
        option2Window:setVisible(false)
        mainMenuWindow:setVisible(true)
    end)

-- Run the Basalt framework
basalt.autoUpdate()
]]

local file = fs.open("/obsidian/main.lua", "w")
file.write(mainScript)
file.close()

print("Setup complete. Run 'obsidian/main.lua' to start the OS.")
