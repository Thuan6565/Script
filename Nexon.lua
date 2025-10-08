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

    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },
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

local Tab5 = Window:Tab({
    Title = "ESP",
    Icon = "box",
    Locked = false,
})

local Tab6 = Window:Tab({
    Title = "Misc",
    Icon = "box",
    Locked = false,
})

local Tab7 = Window:Tab({
    Title = "Mobs",
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
            local tweenInfo = TweenInfo.new(distance / 500, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(15)

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
            local tweenInfo = TweenInfo.new(distance / 500, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(15)

            -- Tween trở về vị trí cũ
            local tweenBack = TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = originalCFrame})
            tweenBack:Play()
        end
    end
})

local Button = Tab:Button({
    Title = "Tween to lost child 3",
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
            local tweenInfo = TweenInfo.new(distance / 500, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(15)

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
            local tweenInfo = TweenInfo.new(distance / 500, Enum.EasingStyle.Linear)
            local tweenTo = TweenService:Create(root, tweenInfo, {CFrame = target.CFrame + Vector3.new(0, 3, 0)})
            tweenTo:Play()
            tweenTo.Completed:Wait()

            -- Đứng yên 10 giây
            wait(15)

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
    Desc = " eat Cooked Morsel when hunger < 90%",
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
        --// Bring All Morsel + Steak to Campfire
        local plr = game.Players.LocalPlayer
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        -- Tìm lửa trại
        local campfire = workspace.Map.Campground:FindFirstChild("MainFire")
        if not campfire or not campfire.PrimaryPart then
            warn("Không tìm thấy lửa trại!")
            return
        end

        -- Loop qua tất cả items
        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:IsA("Model") and item.PrimaryPart and 
               (string.find(item.Name, "Morsel") or string.find(item.Name, "Steak")) then
               
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

local Section = Tab2:Section({ 
    Title = "Tools",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

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

local Section = Tab2:Section({ 
    Title = "Others",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

-- lưu vị trí trước khi bring
_G.SavedPosition = nil

-- mỗi script bring (Log, Coal, Microwave, Steak) khi bật sẽ set:
-- _G.SavedPosition = hrp.CFrame

-- Nút Stop All
local Button = Tab2:Button({
    Title = "Stop All",
    Desc = "",
    Locked = false,
    Callback = function()
        _G.BringLog = false
        _G.BringCoal = false
        _G.BringMicrowave = false
        _G.BringSteak = false
        _G.BringSapling = false

        -- trả về vị trí cũ nếu có lưu
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp and _G.SavedPosition then
            hrp.CFrame = _G.SavedPosition
            _G.SavedPosition = nil -- reset sau khi quay lại
        end
    end
})

_G.BringSapling = false
local savedPosition

local function bringSaplings()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    if not hrp then return end

    savedPosition = hrp.CFrame

    task.spawn(function()
        while _G.BringSapling do
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if not _G.BringSapling then break end
                if item:IsA("Model") and item.PrimaryPart and item.Name == "Sapling" then
                    -- Teleport tới log
                    
                    task.wait(0.2)

                    -- Kéo về
                    requestDrag:FireServer(item)
                    task.wait(0.1)
                    item:PivotTo(savedPosition * CFrame.new(0, 3, 0))
                    task.wait(0.1)
                    stopDrag:FireServer(item)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

  
-- Nút Bring Log
local ButtonOn = Tab2:Button({
    Title = "Bring Sapling",
    Desc = "Bring all Saplings",
    Callback = function()
        if _G.BringSapling then return end
        _G.BringSapling = true
        bringSaplings()
    end
})

_G.bringLog = false
local savedPosition

local function bringLogs()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    if not hrp then return end

    savedPosition = hrp.CFrame

    task.spawn(function()
        while _G.bringLog do
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if not _G.bringLog then break end
                if item:IsA("Model") and item.PrimaryPart and item.Name == "Log" then
                    -- Teleport tới log
                    
                    task.wait(0.2)

                    -- Kéo về
                    requestDrag:FireServer(item)
                    task.wait(0.1)
                    item:PivotTo(savedPosition * CFrame.new(0, 3, 0))
                    task.wait(0.1)
                    stopDrag:FireServer(item)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

  
-- Nút Bring Log
local ButtonOn = Tab2:Button({
    Title = "Bring Log",
    Desc = "Bring all Logs",
    Callback = function()
        if _G.bringLog then return end
        _G.bringLog = true
        bringLogs()
    end
})


_G.BringCoal = false
local savedPosition

local function bringCoal()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    if not hrp then return end

    savedPosition = hrp.CFrame

    task.spawn(function()
        while _G.BringCoal do
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if not _G.BringCoal then break end
                if item:IsA("Model") and item.PrimaryPart and (item.Name == "Log" or item.Name == "Sapling") then
                    -- Teleport tới Coal
                    
                    task.wait(0.2)

                    -- Kéo về
                    requestDrag:FireServer(item)
                    task.wait(0.1)
                    item:PivotTo(savedPosition * CFrame.new(0, 3, 0))
                    task.wait(0.1)
                    stopDrag:FireServer(item)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

-- Nút Bring Coal
local ButtonOn = Tab2:Button({
    Title = "Bring Coal",
    Desc = "Bring all Coal",
    Callback = function()
        if _G.BringCoal then return end
        _G.BringCoal = true
        bringCoal()
    end
})

_G.BringMicrowave = false
local savedPosition

local function bringMicrowave()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    if not hrp then return end

    savedPosition = hrp.CFrame

    task.spawn(function()
        while _G.BringMicrowave do
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if not _G.BringMicrowave then break end
                if item:IsA("Model") and item.PrimaryPart and item.Name == "Broken Microwave" then
                    -- Teleport tới Broken Microwave
                    
                    task.wait(0.2)

                    -- Kéo về
                    requestDrag:FireServer(item)
                    task.wait(0.1)
                    item:PivotTo(savedPosition * CFrame.new(0, 3, 0))
                    task.wait(0.1)
                    stopDrag:FireServer(item)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

-- Nút Bring Broken Microwave
local ButtonOn = Tab2:Button({
    Title = "Bring Broken Microwave",
    Desc = "Bring all Broken Microwaves",
    Callback = function()
        if _G.BringMicrowave then return end
        _G.BringMicrowave = true
        bringMicrowave()
    end
})

_G.BringSteak = false
local savedPosition

local function bringSteak()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    if not hrp then return end

    savedPosition = hrp.CFrame

    task.spawn(function()
        while _G.BringSteak do
            for _, item in ipairs(workspace.Items:GetChildren()) do
                if not _G.BringSteak then break end
                if item:IsA("Model") and item.PrimaryPart and item.Name == "Steak" then
                    -- Teleport tới Steak
                    
                    task.wait(0.2)

                    -- Kéo về
                    requestDrag:FireServer(item)
                    task.wait(0.1)
                    item:PivotTo(savedPosition * CFrame.new(0, 3, 0))
                    task.wait(0.1)
                    stopDrag:FireServer(item)
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

-- Nút Bring Steak
local ButtonOn = Tab2:Button({
    Title = "Bring Steak",
    Desc = "Bring all Steaks",
    Callback = function()
        if _G.BringSteak then return end
        _G.BringSteak = true
        bringSteak()
    end
})



local Section = Tab3:Section({ 
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
local DistanceForKillAura = 70 -- default

-- Slider (dùng Value = {...} như bạn đưa)
local Slider = Tab4:Slider({
    Title = "Kill Aura Distance",
    Step = 1,
    Value = {
        Min = 20,
        Max = 1200,
        Default = 70,
    },
    Callback = function(value)
        DistanceForKillAura = tonumber(value) or 70
    end
})

-- Hàm kill aura
local function runKillAura()
    task.spawn(function()
        while ActiveKillAura do
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            local weapon = player.Inventory:FindFirstChild("Old Axe")
                or player.Inventory:FindFirstChild("Good Axe")
                or player.Inventory:FindFirstChild("Strong Axe")
                or player.Inventory:FindFirstChild("Chainsaw")

            if weapon then
                for _, mob in pairs(workspace.Characters:GetChildren()) do
                    if mob:IsA("Model") and mob.PrimaryPart and mob ~= character then
                        local distance = (mob.PrimaryPart.Position - hrp.Position).Magnitude
                        if distance <= DistanceForKillAura then
                            game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(
                                mob, weapon, 999, hrp.CFrame
                            )
                        end
                    end
                end
            end

            task.wait(0.1)
        end
    end)
end

-- Toggle
local Toggle = Tab4:Toggle({
    Title = "Kill Aura",
    Default = false,
    Callback = function(state)
        ActiveKillAura = state
        if state then
            runKillAura()
        end
    end
})

local Section = Tab4:Section({ 
    Title = "Tree Aura",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local player = game.Players.LocalPlayer
local ActiveAutoChopTree = false
local DistanceForAutoChopTree = 1000

-- Hàm chính
local function runAutoChopTree()
    task.spawn(function()
        while ActiveAutoChopTree do
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local weapon = player.Inventory:FindFirstChild("Old Axe") 
                or player.Inventory:FindFirstChild("Good Axe") 
                or player.Inventory:FindFirstChild("Strong Axe") 
                or player.Inventory:FindFirstChild("Chainsaw")

            if weapon then
                local function chop(folder)
                    for _, tree in pairs(folder:GetChildren()) do
                        if tree:IsA("Model") and (tree.Name == "Small Tree" or tree.Name == "TreeBig1" or tree.Name == "TreeBig2") and tree.PrimaryPart then
                            local distance = (tree.PrimaryPart.Position - hrp.Position).Magnitude
                            if distance <= DistanceForAutoChopTree then
                                game:GetService("ReplicatedStorage").RemoteEvents.ToolDamageObject:InvokeServer(
                                    tree, weapon, 999, hrp.CFrame
                                )
                            end
                        end
                    end
                end

                chop(workspace.Map.Foliage)
                chop(workspace.Map.Landmarks)
            end
            task.wait(0.1)
        end
    end)
end

-- Slider trong library
local AutoChopTreeSlider = Tab4:Slider({
    Title = "Distance For Auto Chop Tree",
    Step = 1,
    Value = {
        Min = 20,
        Max = 100,
        Default = 100,
    },
    Callback = function(value)
        DistanceForAutoChopTree = tonumber(value) or 1000
        print("Distance set to:", DistanceForAutoChopTree)
    end
})

-- Toggle trong library
local AutoChopTreeToggle = Tab4:Toggle({
    Title = "Auto Chop Tree",
    Desc = "Tree Aura",
    Icon = "bird",
    Type = "Toggle",
    Default = false,
    Callback = function(state)
        ActiveAutoChopTree = state
        if ActiveAutoChopTree then
            runAutoChopTree()
        end
    end
})






local Section = Tab5:Section({ 
    Title = "Fuel",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

-- danh sách item cần highlight + tên
local itemsFuel = {
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

local ActiveFuelESP = false
local connections = {}

-- thêm highlight
local function addHighlight(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("FuelHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "FuelHighlight"
        hl.FillColor = Color3.fromRGB(255, 215, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Adornee = item
        hl.Parent = item.PrimaryPart
    end
end

-- thêm billboard tên
local function addBillboard(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("FuelBillboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FuelBillboard"
        billboard.Adornee = item.PrimaryPart
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = item

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = item.Name
        text.TextColor3 = Color3.fromRGB(255, 255, 0) -- chữ đỏ
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- viền đen
        text.TextStrokeTransparency = 0 -- 0 = hiện rõ
        text.TextSize = 14 -- cỡ chữ cố định
        text.Font = Enum.Font.SourceSansBold
        text.Parent = billboard
    end
end

-- xử lý 1 item
local function handleItem(item)
    if itemsFuel[item.Name] then
        addHighlight(item)
        addBillboard(item)
    end
end

-- bật/tắt ESP fuel
local function setFuelESP(state)
    ActiveFuelESP = state
    if state then
        -- quét tất cả item hiện tại
        for _, item in ipairs(workspace.Items:GetChildren()) do
            handleItem(item)
        end
        -- theo dõi item mới
        connections["childAdded"] = workspace.Items.ChildAdded:Connect(function(item)
            task.wait(0.2)
            handleItem(item)
        end)
    else
        -- tắt: xóa highlight + billboard khỏi item
        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:FindFirstChild("FuelHighlight") then
                item.FuelHighlight:Destroy()
            end
            if item:FindFirstChild("FuelBillboard") then
                item.FuelBillboard:Destroy()
            end
        end
        -- ngắt kết nối
        if connections["childAdded"] then
            connections["childAdded"]:Disconnect()
            connections["childAdded"] = nil
        end
    end
end

-- Toggle trong library
local Toggle = Tab5:Toggle({
    Title = "Fuel ESP",
    Description = "",
    Default = false,
    Callback = function(state)
        setFuelESP(state)
        print("Fuel ESP:", state)
    end
})

local Section = Tab5:Section({ 
    Title = "Metal",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local ItemsMetal = {
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

local ActiveMetalESP = false
local connections = {}

-- thêm highlight
local function addHighlight(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("MetalHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "MetalHighlight"
        hl.FillColor = Color3.fromRGB(255, 215, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Adornee = item
        hl.Parent = item
    end
end

-- thêm billboard tên
local function addBillboard(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("MetalBillboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "MetalBillboard"
        billboard.Adornee = item.PrimaryPart
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = item

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = item.Name
        text.TextColor3 = Color3.fromRGB(255, 0, 0) -- chữ đỏ
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- viền đen
        text.TextStrokeTransparency = 0 -- 0 = hiện rõ
        text.TextSize = 14 -- cỡ chữ cố định
        text.Font = Enum.Font.SourceSansBold
        text.Parent = billboard
        text.TextScaled = false
    end
end

-- xử lý 1 item
local function handleItem(item)
    if ItemsMetal[item.Name] then
        addHighlight(item)
        addBillboard(item)
    end
end

-- bật/tắt ESP
local function setMetalESP(state)
    ActiveMetalESP = state
    if state then
        -- quét tất cả item hiện tại
        for _, item in ipairs(workspace.Items:GetChildren()) do
            handleItem(item)
        end
        -- theo dõi item mới
        connections["childAdded"] = workspace.Items.ChildAdded:Connect(function(item)
            task.wait(0.2)
            handleItem(item)
        end)
    else
        -- tắt: xóa highlight + billboard
        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:FindFirstChild("MetalHighlight") then
                item.MetalHighlight:Destroy()
            end
            if item:FindFirstChild("MetalBillboard") then
                item.MetalBillboard:Destroy()
            end
        end
        -- ngắt kết nối
        if connections["childAdded"] then
            connections["childAdded"]:Disconnect()
            connections["childAdded"] = nil
        end
    end
end

-- Toggle trong library
local Toggle = Tab5:Toggle({
    Title = "Metal ESP",
    Description = "Highlight + tên cho ItemsMetal",
    Default = false,
    Callback = function(state)
        setMetalESP(state)
        print("Metal ESP:", state)
    end
})


local Section = Tab5:Section({ 
    Title = "Food",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

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
    ["Mackerel"] = true,
    ["Salmon"] = true,
    ["Clownfish"] = true,
}

local ActiveFoodESP = false
local connections = {}

-- Highlight
local function addHighlight(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("FoodHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "FoodHighlight"
        hl.FillColor = Color3.fromRGB(0, 255, 0) -- xanh lá
        hl.OutlineColor = Color3.fromRGB(0, 0, 0)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Adornee = item
        hl.Parent = item.PrimaryPart
    end
end

-- Billboard
local function addBillboard(item)
    if not item:IsA("Model") or not item.PrimaryPart then return end
    if not item:FindFirstChild("FoodBillboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FoodBillboard"
        billboard.Adornee = item.PrimaryPart
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = item

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Text = item.Name
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- viền đen
        text.TextStrokeTransparency = 0 -- viền hiện rõ
        text.TextSize = 14 -- chữ cố định, không phóng to
        text.Font = Enum.Font.SourceSansBold
        text.Parent = billboard
    end
end

-- Xử lý item
local function handleItem(item)
    if targetFood[item.Name] then
        addHighlight(item)
        addBillboard(item)
    end
end

-- Bật/tắt ESP
local function setFoodESP(state)
    ActiveFoodESP = state
    if state then
        for _, item in ipairs(workspace.Items:GetChildren()) do
            handleItem(item)
        end
        connections["childAdded"] = workspace.Items.ChildAdded:Connect(function(item)
            task.wait(0.2)
            handleItem(item)
        end)
    else
        for _, item in ipairs(workspace.Items:GetChildren()) do
            if item:FindFirstChild("FoodHighlight") then
                item.FoodHighlight:Destroy()
            end
            if item:FindFirstChild("FoodBillboard") then
                item.FoodBillboard:Destroy()
            end
        end
        if connections["childAdded"] then
            connections["childAdded"]:Disconnect()
            connections["childAdded"] = nil
        end
    end
end

-- Toggle trong library
local Toggle = Tab5:Toggle({
    Title = "Food ESP",
    Description = "",
    Default = false,
    Callback = function(state)
        setFoodESP(state)
        print("Food ESP:", state)
    end
})


local Lighting = game:GetService("Lighting")
local FullBrightConnection

local Toggle = Tab6:Toggle({
    Title = "Full Bright",
    Description = "",
    Default = false,
    Callback = function(state)
        if state then
            -- bật sáng
            FullBrightConnection = game:GetService("RunService").RenderStepped:Connect(function()
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
                Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 1e6
            end)
        else
            -- tắt: trả về mặc định
            if FullBrightConnection then
                FullBrightConnection:Disconnect()
                FullBrightConnection = nil
            end
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
            Lighting.ColorShift_Top = Color3.fromRGB(127, 127, 127)
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 1000
        end
    end
})

local Button = Tab6:Button({
    Title = "Teleport to Campfire",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local campfire = workspace:FindFirstChild("Map")
            and workspace.Map:FindFirstChild("Campground")
            and workspace.Map.Campground:FindFirstChild("MainFire")

        if hrp and campfire and campfire:IsA("Model") and campfire.PrimaryPart then
            hrp.CFrame = campfire.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
})

local Button = Tab7:Button({
    Title = "Anti-Wolf Gui",
    Desc = "",
    Locked = false,
    Callback = function()
         -- AntiWolfBring.lua
-- LocalScript: quét workspace.Characters, "bring" mọi Wolf tới (0,10,0) hoặc phía trên player và giữ cố định.
-- Đặt trong StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Cấu hình
local CHARACTERS_FOLDER = "Characters" -- folder chứa các NPC/player models; nếu khác, đổi tên
local WOLF_NAME = {"wolf", "Bear"}-- tìm model có tên chứa chuỗi này (case-insensitive)
local HOLD_ABOVE_PLAYER = true        -- nếu true: giữ sói phía trên player; nếu false: giữ ở COORD_HOLD
local COORD_HOLD = Vector3.new(0, 10, 0) -- vị trí mặc định khi HOLD_ABOVE_PLAYER = false
local MAINTAIN_RATE = 0.03           -- thời gian giữa lần ép CFrame (giữ chặt) (giây)

-- internal storage để restore
local tracked = {} -- map: model -> {parts = {part -> {Anchored,CanCollide,CFrame}}, moved = true/false}

local enabled = false

-- helper: kiểm tra model là wolf
local function isWolfModel(m)
    if not m or not m:IsA("Model") then return false end
    local name = tostring(m.Name):lower()
    if string.find(name, WOLF_NAME, 1, true) then
        return true
    end
    return false
end

-- helper: collect all baseparts of model
local function collectParts(model)
    local parts = {}
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("BasePart") then
            table.insert(parts, d)
        end
    end
    return parts
end

-- lưu trạng thái gốc cho model (chỉ lưu lần đầu)
local function saveOriginalState(model)
    if tracked[model] then return end
    local info = {parts = {}, model = model, primaryCFrame = nil}
    local parts = collectParts(model)
    for _, p in ipairs(parts) do
        info.parts[p] = {
            Anchored = p.Anchored,
            CanCollide = p.CanCollide,
            CFrame = p.CFrame
        }
    end
    -- try store model primary cframe as convenience
    if model.PrimaryPart then
        info.primaryCFrame = model:GetPrimaryPartCFrame()
    else
        info.primaryCFrame = nil
    end
    tracked[model] = info
end

-- restore original state for single model
local function restoreModel(model)
    local info = tracked[model]
    if not info then return end
    pcall(function()
        for part, props in pairs(info.parts) do
            if part and part.Parent then
                if props.CFrame then
                    -- try restore position (pcall to avoid errors if server denies)
                    pcall(function() part.CFrame = props.CFrame end)
                end
                part.Anchored = props.Anchored
                part.CanCollide = props.CanCollide
            end
        end
        -- if we saved primaryCFrame, try to set back
        if info.primaryCFrame and model.PrimaryPart then
            pcall(function() model:SetPrimaryPartCFrame(info.primaryCFrame) end)
        end
    end)
    tracked[model] = nil
end

-- bring model to targetCFrame (try PrimaryPart or set each part.CFrame offset)
local function setModelCFrame(model, targetCFrame)
    if not model or not model.Parent then return end
    pcall(function()
        if model.PrimaryPart then
            model:SetPrimaryPartCFrame(targetCFrame)
        else
            -- naive: move each part relative to model's primary bounding center
            local parts = collectParts(model)
            -- compute model center average
            local center = Vector3.new(0,0,0)
            local n = 0
            for _, p in ipairs(parts) do
                center = center + p.Position
                n = n + 1
            end
            if n == 0 then return end
            center = center / n
            for _, p in ipairs(parts) do
                -- keep relative offset
                local offset = p.Position - center
                p.CFrame = CFrame.new(targetCFrame.Position + offset) * (p.CFrame - p.CFrame.Position) -- preserve rotation
            end
        end
    end)
end

-- neutralize physics for model (anchor parts, disable collisions)
local function neutralizeModel(model)
    saveOriginalState(model)
    for part, _ in pairs(tracked[model].parts) do
        if part and part.Parent then
            pcall(function()
                part.Anchored = true
                part.CanCollide = false
            end)
        end
    end
end

-- bring all wolves to target location or above player and keep them there
local function bringAndHoldAll()
    -- choose target base position
    local targetPos
    if HOLD_ABOVE_PLAYER and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        targetPos = hrp.Position + Vector3.new(0, 10, 0)
    else
        targetPos = COORD_HOLD
    end
    local charsFolder = Workspace:FindFirstChild(CHARACTERS_FOLDER) or Workspace
    for _, m in ipairs(charsFolder:GetChildren()) do
        if isWolfModel(m) then
            saveOriginalState(m)
            neutralizeModel(m)
            -- set initial position (we use model primary or parts)
            local targetCFrame = CFrame.new(targetPos)
            setModelCFrame(m, targetCFrame)
            -- mark moved
            if tracked[m] then tracked[m].moved = true end
        end
    end
end

-- continuously enforce position while enabled (loop)
local holdConnection
local function startHoldLoop()
    if holdConnection then return end
    holdConnection = RunService.Heartbeat:Connect(function(dt)
        if not enabled then return end
        local basePos
        if HOLD_ABOVE_PLAYER and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            basePos = player.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
        else
            basePos = COORD_HOLD
        end
        local charsFolder = Workspace:FindFirstChild(CHARACTERS_FOLDER) or Workspace
        for _, m in ipairs(charsFolder:GetChildren()) do
            if isWolfModel(m) then
                -- ensure neutralized
                if not tracked[m] then
                    saveOriginalState(m)
                    for part, _ in pairs(tracked[m].parts) do
                        pcall(function()
                            part.Anchored = true
                            part.CanCollide = false
                        end)
                    end
                    tracked[m].moved = true
                end
                -- compute target with spacing (so multiple wolves don't overlap exactly)
                local offsetIndex = 0
                -- simple offset based on instance id to reduce overlap
                local hash = math.abs(tonumber(tostring(m:GetDebugId())) or 0)
                offsetIndex = (hash % 6) - 3
                local target = CFrame.new(basePos + Vector3.new(offsetIndex*2, 0, 0))
                -- push model there
                pcall(function() setModelCFrame(m, target) end)
            end
        end
    end)
end

local function stopHoldLoop()
    if holdConnection then
        holdConnection:Disconnect()
        holdConnection = nil
    end
end

-- release all wolves (restore original states)
local function releaseAll()
    for model, _ in pairs(tracked) do
        pcall(function() restoreModel(model) end)
    end
    tracked = {}
end

-- scan once: bring + neutralize any wolves discovered
local function scanOnce()
    bringAndHoldAll()
end

-- ========== GUI ==========

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AntiWolfBringGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local main = Instance.new("Frame", screenGui)
    main.Size = UDim2.new(0, 300, 0, 140)
    main.Position = UDim2.new(0, 12, 0, 12)
    main.BackgroundColor3 = Color3.fromRGB(30,30,30)
    main.BackgroundTransparency = 0.12
    main.BorderSizePixel = 0
    main.Draggable = true

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -12, 0, 28)
    title.Position = UDim2.new(0, 6, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = "Nexon Anti-Wolf: Bring & Hold"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Draggable = true

    local toggleBtn = Instance.new("TextButton", main)
    toggleBtn.Size = UDim2.new(0, 140, 0, 34)
    toggleBtn.Position = UDim2.new(0, 6, 0, 40)
    toggleBtn.Text = "Enable"
    toggleBtn.Font = Enum.Font.SourceSans
    toggleBtn.TextSize = 16
    toggleBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    toggleBtn.TextColor3 = Color3.new(1,1,1)

    local modeBtn = Instance.new("TextButton", main)
    modeBtn.Size = UDim2.new(0, 140, 0, 34)
    modeBtn.Position = UDim2.new(0, 156, 0, 40)
    modeBtn.Text = HOLD_ABOVE_PLAYER and "Mode: Above Player" or ("Mode: "..tostring(COORD_HOLD))
    modeBtn.Font = Enum.Font.SourceSans
    modeBtn.TextSize = 14
    modeBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    modeBtn.TextColor3 = Color3.new(1,1,1)

    local scanBtn = Instance.new("TextButton", main)
    scanBtn.Size = UDim2.new(0, 140, 0, 28)
    scanBtn.Position = UDim2.new(0, 6, 0, 84)
    scanBtn.Text = "Scan Now"
    scanBtn.Font = Enum.Font.SourceSans
    scanBtn.TextSize = 14
    scanBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    scanBtn.TextColor3 = Color3.new(1,1,1)

    local releaseBtn = Instance.new("TextButton", main)
    releaseBtn.Size = UDim2.new(0, 140, 0, 28)
    releaseBtn.Position = UDim2.new(0, 156, 0, 84)
    releaseBtn.Text = "Release All"
    releaseBtn.Font = Enum.Font.SourceSans
    releaseBtn.TextSize = 14
    releaseBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    releaseBtn.TextColor3 = Color3.new(1,1,1)

    local infoLabel = Instance.new("TextLabel", main)
    infoLabel.Size = UDim2.new(1, -12, 0, 18)
    infoLabel.Position = UDim2.new(0, 6, 1, -24)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Font = Enum.Font.SourceSans
    infoLabel.TextSize = 12
    infoLabel.TextColor3 = Color3.fromRGB(200,200,200)
    infoLabel.Text = "Note: client-side only. Server may correct positions."

    -- handlers
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            toggleBtn.Text = "Disable"
            -- perform initial scan/bring
            scanOnce()
            -- start hold loop
            startHoldLoop()
            StarterGui:SetCore("SendNotification", {Title="Anti-Wolf", Text="Bring & Hold ENABLED", Duration=2})
        else
            toggleBtn.Text = "Enable"
            -- stop hold and restore
            stopHoldLoop()
            releaseAll()
            StarterGui:SetCore("SendNotification", {Title="Anti-Wolf", Text="Bring & Hold DISABLED", Duration=2})
        end
    end)

    modeBtn.MouseButton1Click:Connect(function()
        HOLD_ABOVE_PLAYER = not HOLD_ABOVE_PLAYER
        modeBtn.Text = HOLD_ABOVE_PLAYER and "Mode: Above Player" or ("Mode: "..tostring(COORD_HOLD))
    end)

    scanBtn.MouseButton1Click:Connect(function()
        scanOnce()
        StarterGui:SetCore("SendNotification", {Title="Anti-Wolf", Text="Manual scan executed", Duration=1.6})
    end)

    releaseBtn.MouseButton1Click:Connect(function()
        stopHoldLoop()
        releaseAll()
        enabled = false
        toggleBtn.Text = "Enable"
        StarterGui:SetCore("SendNotification", {Title="Anti-Wolf", Text="Released all and disabled", Duration=2})
    end)
end

-- initialize GUI
createGUI()

-- auto-scan new wolves added (so we can auto-neutralize them even if not holding)
local charsFolder = Workspace:FindFirstChild(CHARACTERS_FOLDER) or Workspace
charsFolder.DescendantAdded:Connect(function(desc)
    if not enabled then return end
    local m = desc
    -- if a model added or a model containing "wolf" was created
    if desc:IsA("Model") and isWolfModel(desc) then
        saveOriginalState(desc)
        neutralizeModel(desc)
    else
        -- if a descendant added under a wolf model
        local parent = desc.Parent
        while parent and parent ~= Workspace and parent ~= charsFolder do
            if isWolfModel(parent) then
                saveOriginalState(parent)
                neutralizeModel(parent)
                break
            end
            parent = parent.Parent
        end
    end
end)

-- cleanup on script stop / player leaving (best effort)
player.AncestryChanged:Connect(function(_, parent)
    if not parent then
        stopHoldLoop()
        releaseAll()
    end
end)

print("[AntiWolfBring] Loaded. Use GUI to enable/disable. Client-side only.")
        end
    })



















