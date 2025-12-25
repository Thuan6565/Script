local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Nexon Blox Fruit ",
    SubTitle = "by Ieyuks8",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

local Tabs = {
      Main = Window:AddTab({ Title = "Framing", Icon = "house" }),

      Main = Window:AddTab({ Title = "Fruit", Icon = "apple" }),
    
      Main = Window:AddTab({ Title = "Visual", Icon = "eye" }),
      
      Main = Window:AddTab({ Title = "Automatic", Icon = "omega" }),

      Main = Window:AddTab({ Title = "Event", Icon = "calendars" }),
    
}

local function CheckQuest()

end