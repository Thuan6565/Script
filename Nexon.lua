--By Rip_IKASI
--Sybau
--UI

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Nexon hub",
    Icon = "star",
    Author = "Rip_IKASI",
    Folder = "NEXON99",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(450, 390),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
})
--Tabs
local Tab = Window:Tab({
    Title = "Fram",
    Icon = "bird",
    Locked = false,
})

local Tab2 = Window:Tab({
    Title = "Brings",
    Icon = "box",
    Locked = false,
})


local Tab3 = Window:Tab({
    Title = "Player",
    Icon = "box",
    Locked = false,
})

local Tab4 = Window:Tab({
    Title = "Combat",
    Icon = "box",
    Locked = false,
})
--Windows
Window:Tag({
    Title = "v1.0.0",
    Color = Color3.fromHex("#30ff6a")
})
--All Change
local Section = Tab:Section({ 
    Title = "Days",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

--// Dùng toggle trong Tab
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")

-- Config
local flying = false
local radius = 150 -- bán kính vòng tròn
local height = 100 -- độ cao
local speed = 1 -- tốc độ xoay

-- Biến
local angle = 0

-- Toggle trong GUI
local Toggle = Tab:Toggle({
    Title = "Auto Days",
    Desc = "Circle Tween map",
    Icon = "star",
    Type = "Toggle",
    Default = false,
    Callback = function(state) 
        flying = state
    end
})

-- Vòng lặp di chuyển
RunService.RenderStepped:Connect(function(dt)
    if flying and hrp then
        angle = angle + speed * dt
        local x = math.cos(angle) * radius
        local z = math.sin(angle) * radius
        local newPos = Vector3.new(x, height, z)
        hrp.CFrame = CFrame.new(newPos, Vector3.new(0, height, 0))
    end
end)

local Section = Tab:Section({ 
    Title = "Fram",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Paragraph = Tab:Paragraph({
    Title = "Note",
    Desc = "Fram bunny is so Beta, Ts will get camera error, but script still work",
    Color = "White",
    Image = "",
    ImageSize = 0,
    Thumbnail = "",
    ThumbnailSize = 0,
    Locked = false,
})

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local vu = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local autoKill = false
local savedPosition
local bunny
local lastBunnyCheck = 0
local connection

-- Hàm tìm Bunny
local function findBunny()
    local characters = workspace:FindFirstChild("Characters")
    if characters then
        bunny = characters:FindFirstChild("Bunny")
    else
        bunny = nil
    end
end

-- Main loop, luôn chạy nhưng chỉ hoạt động khi autoKill = true
connection = RunService.RenderStepped:Connect(function(dt)
    if autoKill then
        -- 10 giây quét lại Bunny
        lastBunnyCheck = lastBunnyCheck + dt
        if lastBunnyCheck >= 10 then
            findBunny()
            lastBunnyCheck = 0
        end

        if bunny and bunny.PrimaryPart then
            -- Di chuyển mượt theo Bunny
            hrp.CFrame = hrp.CFrame:Lerp(bunny.PrimaryPart.CFrame * CFrame.new(0,0,-2), 0.3)
            -- Auto click attack
            vu:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            vu:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
end)

-- Toggle GUI
local Toggle = Tab:Toggle({
    Title = "Auto Kill Bunny",
    Desc = " attack Bunny",
    Icon = "bird",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        autoKill = state
        if autoKill then
            savedPosition = hrp.CFrame -- Lưu vị trí ban đầu khi bật
            findBunny()
        else
            -- Khi tắt, quay về chỗ cũ
            if savedPosition then
                hrp.CFrame = savedPosition
            end
        end
    end
})

local Section = Tab:Section({ 
    Title = "Child",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Button = Tab:Button({
    Title = "Tween to lost child",
    Desc = "Carry lost child to campire",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local originalCFrame = root.CFrame -- Lưu vị trí ban đầu

        -- Hàm tìm Lost Child trong Characters
        local function findLostChild()
            local charactersFolder = workspace:WaitForChild("Characters")
            for _, child in pairs(charactersFolder:GetChildren()) do
                if child.Name == "Lost Child" then
                    local hrp = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        return hrp
                    end
                end
            end
            return nil
        end

        local target = findLostChild()

        if not target then
            WindUI:Notify({
    Title = "Error",
    Content = "CANNOT FIND LOST CHILD, OR YOUR CAMPIRE LEVEL IS LOW",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})
        else
            -- Tween đến Lost Child
            local distance = (root.Position - target.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(10)

            -- Tween trở về vị trí cũ
            local tweenBack = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = originalCFrame})
            tweenBack:Play()
        end
    end
})

local Button = Tab:Button({
    Title = "Tween to lost child 2",
    Desc = "Carry lost child 2 to campire",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local originalCFrame = root.CFrame -- Lưu vị trí ban đầu

        -- Hàm tìm Lost Child trong Characters
        local function findLostChild()
            local charactersFolder = workspace:WaitForChild("Characters")
            for _, child in pairs(charactersFolder:GetChildren()) do
                if child.Name == "Lost Child2" then
                    local hrp = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        return hrp
                    end
                end
            end
            return nil
        end

        local target = findLostChild()

        if not target then
            WindUI:Notify({
    Title = "Error",
    Content = "CANNOT FIND LOST CHILD, OR YOUR CAMPIRE LEVEL IS LOW",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})
        else
            -- Tween đến Lost Child
            local distance = (root.Position - target.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(10)

            -- Tween trở về vị trí cũ
            local tweenBack = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = originalCFrame})
            tweenBack:Play()
        end
    end
})

local Button = Tab:Button({
    Title = "Tween to lost child e",
    Desc = "Carry lost child 3 to campire",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local originalCFrame = root.CFrame -- Lưu vị trí ban đầu

        -- Hàm tìm Lost Child trong Characters
        local function findLostChild()
            local charactersFolder = workspace:WaitForChild("Characters")
            for _, child in pairs(charactersFolder:GetChildren()) do
                if child.Name == "Lost Child3" then
                    local hrp = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        return hrp
                    end
                end
            end
            return nil
        end

        local target = findLostChild()

        if not target then
            WindUI:Notify({
    Title = "Error",
    Content = "CANNOT FIND LOST CHILD, OR YOUR CAMPIRE LEVEL IS LOW",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})
        else
            -- Tween đến Lost Child
            local distance = (root.Position - target.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(10)

            -- Tween trở về vị trí cũ
            local tweenBack = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = originalCFrame})
            tweenBack:Play()
        end
    end
})

local Button = Tab:Button({
    Title = "Tween to lost child 4",
    Desc = "Carry lost child 4 to campire",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local originalCFrame = root.CFrame -- Lưu vị trí ban đầu

        -- Hàm tìm Lost Child trong Characters
        local function findLostChild()
            local charactersFolder = workspace:WaitForChild("Characters")
            for _, child in pairs(charactersFolder:GetChildren()) do
                if child.Name == "Lost Child4" then
                    local hrp = child:FindFirstChild("HumanoidRootPart") or child:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        return hrp
                    end
                end
            end
            return nil
        end

        local target = findLostChild()

        if not target then
            WindUI:Notify({
    Title = "Error",
    Content = "CANNOT FIND LOST CHILD, OR YOUR CAMPIRE LEVEL IS LOW",
    Duration = 3, -- 3 seconds
    Icon = "bird",
})
        else
            -- Tween đến Lost Child
            local distance = (root.Position - target.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / 50, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(10)

            -- Tween trở về vị trí cũ
            local tweenBack = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = originalCFrame})
            tweenBack:Play()
        end
    end
})

local Section = Tab:Section({ 
    Title = "Cook & Eat",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Button = Tab:Button({
    Title = "Eat",
    Desc = " eat Cooked Morsel when hunger < 30%",
    Locked = false,
    Callback = function()
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local player = Players.LocalPlayer

        -- RemoteFunction
        local requestConsume = ReplicatedStorage.RemoteEvents:WaitForChild("RequestConsumeItem")

        -- Thanh đói
        local hungryBar = player:WaitForChild("PlayerGui"):WaitForChild("Interface")
            :WaitForChild("StatBars"):WaitForChild("HungerBar"):WaitForChild("Bar")

        -- Hàm ăn thức ăn
        local function eatFood()
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if item.Name == "Cooked Morsel" then
                    requestConsume:InvokeServer(item)
                    print("Đã ăn 1 Cooked Morsel")
                    break
                end
            end
        end

        -- Theo dõi thanh đói
        hungryBar:GetPropertyChangedSignal("Size"):Connect(function()
            if hungryBar.Size.X.Scale < 0.9 then  -- đói < 30%
                eatFood()
            end
        end)

        print("Auto Eat đã bật")
    end
})

local Button = Tab:Button({
    Title = "Cook Foods",
    Desc = "",
    Locked = false,
    Callback = function()
        --// Bring All Morsel to Campfire
local plr = game.Players.LocalPlayer
local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return end

-- Tìm lửa trại
local campfire = Workspace.Map.Campground:FindFirstChild("MainFire")  -- hoặc đổi tên nếu trong game khác
if not campfire or not campfire.PrimaryPart then
    warn("Không tìm thấy lửa trại!")
    return
end

-- Loop qua tất cả items
for _, item in ipairs(workspace.Items:GetChildren()) do
    if item:IsA("Model") and item.PrimaryPart and string.find(item.Name, "Morsel") then
        -- Start dragging
        game.ReplicatedStorage.RemoteEvents.RequestStartDraggingItem:FireServer(item)

        -- Đặt item phía trên lửa trại (2 studs trên)
        local targetCFrame = campfire.PrimaryPart.CFrame * CFrame.new(0, 8, 0)
        item:PivotTo(targetCFrame)

        -- Stop dragging
        game.ReplicatedStorage.RemoteEvents.StopDraggingItem:FireServer(item)
    end
end
    end
})

-- Tabs 2

local Section = Tab2:Section({ 
    Title = "Fuel",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local rs = game:GetService("ReplicatedStorage")
local requestDrag = rs.RemoteEvents.RequestStartDraggingItem
local stopDrag = rs.RemoteEvents.StopDraggingItem

-- =======================
-- Fuel
-- =======================
local targetFuel = {
    ["Log"] = true,
    ["Coal"] = true,
    ["Oil Barrel"] = true,
    ["Fuel Canister"] = true,
    ["Cultist"] = true,
    ["Bear Corpse"] = true,
    ["Alpha Wolf Corpse"] = true,
    ["Wolf Corpse"] = true,
    ["Crossbow Cultist"] = true
}
_G.BringFuel = false
local savedPositionFuel

-- Fuel ON
local FuelOn = Tab2:Button({
    Title = "Bring Fuel",
    Desc = "Bring all Fuel",
    Locked = false,
    Callback = function()
        if _G.BringFuel then return end
        _G.BringFuel = true
        savedPositionFuel = hrp.CFrame

        task.spawn(function()
            while _G.BringFuel do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not _G.BringFuel then break end
                    if item:IsA("Model") and item.PrimaryPart and targetFuel[item.Name] then
                        hrp.CFrame = item.PrimaryPart.CFrame + Vector3.new(0,3,0)
                        task.wait(0.2)
                        requestDrag:FireServer(item)
                        task.wait(0.1)
                        item:PivotTo(savedPositionFuel * CFrame.new(0,3,0))
                        task.wait(0.1)
                        stopDrag:FireServer(item)
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- Fuel OFF
local FuelOff = Tab2:Button({
    Title = "Stop Fuel",
    Desc = "Stop bring Fuel",
    Locked = false,
    Callback = function()
        _G.BringFuel = false
        if savedPositionFuel then
            hrp.CFrame = savedPositionFuel
        end
    end
})

local Section = Tab2:Section({ 
    Title = "Metal",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

-- =======================
-- Metal
-- =======================
local targetMetal = {
    ["Bolt"] = true,
    ["Sheet Metal"] = true,
    ["UFO Junk"] = true,
    ["UFO Component"] = true,
    ["Broken Fan"] = true,
    ["Broken Radio"] = true,
    ["Broken Microwave"] = true,
    ["Tyre"] = true,
    ["Metal Chair"] = true,
    ["Old Car Engine"] = true,
    ["Cultist Experiment"] = true,
    ["Washing Machine"] = true,
    ["Cultist Prototype"] = true,
    ["UFO Scrap"] = true
}
_G.BringMetal = false
local savedPositionMetal

-- Metal ON
local MetalOn = Tab2:Button({
    Title = "Bring Metal",
    Desc = "Bring all Metal",
    Locked = false,
    Callback = function()
        if _G.BringMetal then return end
        _G.BringMetal = true
        savedPositionMetal = hrp.CFrame

        task.spawn(function()
            while _G.BringMetal do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not _G.BringMetal then break end
                    if item:IsA("Model") and item.PrimaryPart and targetMetal[item.Name] then
                        hrp.CFrame = item.PrimaryPart.CFrame + Vector3.new(0,3,0)
                        task.wait(0.2)
                        requestDrag:FireServer(item)
                        task.wait(0.1)
                        item:PivotTo(savedPositionMetal * CFrame.new(0,3,0))
                        task.wait(0.1)
                        stopDrag:FireServer(item)
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- Metal OFF
local MetalOff = Tab2:Button({
    Title = "Stop Metal",
    Desc = "Stop bring Metal",
    Locked = false,
    Callback = function()
        _G.BringMetal = false
        if savedPositionMetal then
            hrp.CFrame = savedPositionMetal
        end
    end
})

local Section = Tab2:Section({ 
    Title = "Food",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

-- =======================
-- Food
-- =======================
local targetFood = {
    ["Steak"] = true,
    ["Carrot"] = true,
    ["Berry"] = true,
    ["Chili"] = true,
    ["Morsel"] = true,
    ["Stew"] = true,
    ["Corn"] = true,
    ["Pumpkin"] = true,
    ["Apple"] = true,
    ["Ribs"] = true,
    ["Cake"] = true,
    ["Hearty Stew"] = true,
    ["Shark"] = true,
    ["Swordfish"] = true,
    ["Eel"] = true,
    ["Char"] = true,
    ["Swordfish"] = true,
    ["Mackerel"] = true,
    ["Salmon"] = true,
    ["Clownfish"] = true
}

_G.BringFood = false
local savedPositionFood

-- Food ON
local FoodOn = Tab2:Button({
    Title = "Bring Food",
    Desc = "Bring all Food",
    Locked = false,
    Callback = function()
        if _G.BringFood then return end
        _G.BringFood = true
        savedPositionFood = hrp.CFrame

        task.spawn(function()
            while _G.BringFood do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not _G.BringFood then break end -- kiểm tra đúng biến
                    if item:IsA("Model") and item.PrimaryPart and targetFood[item.Name] then
                        -- Tele player tới item
                        hrp.CFrame = item.PrimaryPart.CFrame + Vector3.new(0,3,0)
                        task.wait(0.2)

                        -- Bring item về chỗ player lúc bật
                        requestDrag:FireServer(item)
                        task.wait(0.1)
                        item:PivotTo(savedPositionFood * CFrame.new(0,3,0))
                        task.wait(0.1)
                        stopDrag:FireServer(item)
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- Food OFF
local FoodOff = Tab2:Button({
    Title = "Stop Food",
    Desc = "Stop bring Food",
    Locked = false,
    Callback = function()
        _G.BringFood = false
        if savedPositionFood then
            hrp.CFrame = savedPositionFood
        end
    end
})

local Section = Tab2:Section({ 
    Title = "Ammo",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})
-- =======================
-- Ammo
-- =======================
local targetAmmo = {
    ["Revolver Ammo"] = true,
    ["Rifle Ammo"] = true,
    ["Shotgun Ammo"] = true
}

_G.BringAmmo = false
local savedPositionAmmo

-- Ammo ON
local AmmoOn = Tab2:Button({
    Title = "Bring Ammo",
    Desc = "Bring all Ammo",
    Locked = false,
    Callback = function()
        if _G.BringAmmo then return end
        _G.BringAmmo = true
        savedPositionAmmo = hrp.CFrame

        task.spawn(function()
            while _G.BringAmmo do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not _G.BringAmmo then break end
                    if item:IsA("Model") and item.PrimaryPart and targetAmmo[item.Name] then
                        hrp.CFrame = item.PrimaryPart.CFrame + Vector3.new(0,3,0)
                        task.wait(0.2)
                        requestDrag:FireServer(item)
                        task.wait(0.1)
                        item:PivotTo(savedPositionAmmo * CFrame.new(0,3,0))
                        task.wait(0.1)
                        stopDrag:FireServer(item)
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- Ammo OFF
local AmmoOff = Tab2:Button({
    Title = "Stop Ammo",
    Desc = "Stop bring Ammo",
    Locked = false,
    Callback = function()
        _G.BringAmmo = false
        if savedPositionAmmo then
            hrp.CFrame = savedPositionAmmo
        end
    end
})

-- =======================
-- Tools & Weapons
-- =======================
local targetTools = {
    ["Bandage"] = true,
    ["Rifle"] = true,
    ["Revolver"] = true,
    ["Laser Cannon"] = true,
    ["Ray Gun"] = true,
    ["Laser Sword"] = true,
    ["Katana"] = true,
    ["Strong Flashlight"] = true,
    ["Old Flashlight"] = true
}

_G.BringTools = false
local savedPositionTools

-- Tools ON
local ToolsOn = Tab2:Button({
    Title = "Bring Tools",
    Desc = "Bring all Tools/Weapons",
    Locked = false,
    Callback = function()
        if _G.BringTools then return end
        _G.BringTools = true
        savedPositionTools = hrp.CFrame

        task.spawn(function()
            while _G.BringTools do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not _G.BringTools then break end
                    if (item:IsA("Tool") or item:IsA("Model")) and item.PrimaryPart and targetTools[item.Name] then
                        hrp.CFrame = item.PrimaryPart.CFrame + Vector3.new(0,3,0)
                        task.wait(0.2)
                        requestDrag:FireServer(item)
                        task.wait(0.1)
                        item:PivotTo(savedPositionTools * CFrame.new(0,3,0))
                        task.wait(0.1)
                        stopDrag:FireServer(item)
                        task.wait(0.2)
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- Tools OFF
local ToolsOff = Tab2:Button({
    Title = "Stop Tools",
    Desc = "Stop bring Tools/Weapons",
    Locked = false,
    Callback = function()
        _G.BringTools = false
        if savedPositionTools then
            hrp.CFrame = savedPositionTools
        end
    end
})


local Section = Tab:Section({ 
    Title = "Speed",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

-- Lấy player & humanoid
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Biến lưu
local speedEnabled = false
local selectedSpeed = 70 -- mặc định từ slider
local defaultSpeed = 16 -- tốc độ chuẩn Roblox

-- Slider chỉnh tốc độ
local Slider = Tab3:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = {
        Min = 20,
        Max = 1200,
        Default = 70,
    },
    Callback = function(value)
        selectedSpeed = value
        if speedEnabled then
            humanoid.WalkSpeed = selectedSpeed
        end
    end
})

-- Toggle bật/tắt
local Toggle = Tab3:Toggle({
    Title = "Toggle Speed",
    Desc = "On/Off Speed",
    Icon = "bird",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        speedEnabled = state
        if speedEnabled then
            humanoid.WalkSpeed = selectedSpeed
        else
            humanoid.WalkSpeed = defaultSpeed
        end
    end
})

local Section = Tab3:Section({ 
    Title = "Others",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Section = Tab4:Section({ 
    Title = "Kill Aura",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local ActiveKillAura = false
local DistanceForKillAura = 70
local KillAuraThread

-- Slider
local player = game.Players.LocalPlayer
local ActiveKillAura = false
local DistanceForKillAura = 70
local KillAuraThread

-- Slider chỉnh khoảng cách
local Slider = Tab3:Slider({
    Title = "Distance",
    Step = 1,
    Value = {
        Min = 20,
        Max = 1200,
        Default = 70,
    },
    Callback = function(value)
       DistanceForKillAura = tonumber(value)
       print("Distance set to:", DistanceForKillAura)
    end
})

-- Hàm Kill Aura
local function runKillAura()
    if KillAuraThread then return end -- tránh tạo nhiều thread
    KillAuraThread = task.spawn(function()
        while ActiveKillAura do
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local weapon = player.Inventory:FindFirstChild("Old Axe") 
                or player.Inventory:FindFirstChild("Good Axe") 
                or player.Inventory:FindFirstChild("Strong Axe") 
                or player.Inventory:FindFirstChild("Chainsaw")

            if weapon then
                for _, bunny in pairs(workspace.Characters:GetChildren()) do
                    if bunny:IsA("Model") and bunny.PrimaryPart then
                        local distance = (bunny.PrimaryPart.Position - hrp.Position).Magnitude
                        if distance <= DistanceForKillAura then
                            game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(
                                bunny, weapon, 999, hrp.CFrame
                            )
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        KillAuraThread = nil
    end)
end

-- Toggle Kill Aura (hoạt động như GUI thủ công)
local Toggle = Tab3:Toggle({
    Title = "Kill Aura",
    Desc = "Tự động đánh mob",
    Icon = "bird",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        if state then
            ActiveKillAura = true
            runKillAura()
            print("Kill Aura: ON") -- debug
        else
            ActiveKillAura = false
            print("Kill Aura: OFF") -- debug
        end
    end
})

