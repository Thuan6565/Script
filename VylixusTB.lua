--Ieyuks8

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Black X | Espace Tsunami of Brainrot ",
    SubTitle = "by Ieyuks8",
    TabWidth = 160,
    Size = UDim2.fromOffset(450, 400),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Light",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Options = Fluent.Options



local Tabs = {
    Main = Window:AddTab({ Title = "Main"}),
    Player = Window:AddTab({ Title = "Player"}),
    Automatic = Window:AddTab({ Title = "Automatic"}),
    Visual = Window:AddTab({ Title = "Visual"})
}

--Main 

local Section = Tabs.Main:AddSection("Brainrot")

local slcbrn = Tabs.Main:AddDropdown("selectbrn", {
    Title = "Select slot",
    Description = "",
    Values = {
        "1","2","3","4","5","6","7",
        "8","9","10","11","12","13","14"
    },
    Multi = false,
    Default = "1"
})


_G.PlayerBase = nil

local function DetectPlayerBase()
    local player = game:GetService("Players").LocalPlayer
    local basesF = workspace:WaitForChild("Bases")

    -- Respawn để đứng đúng Spawn của mình
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end

    local character = player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    task.wait(0.3)

    -- Raycast xuống dưới chân
    local origin = hrp.Position
    local direction = Vector3.new(0, -10, 0)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local result = workspace:Raycast(origin, direction, raycastParams)

    if result and result.Instance and result.Instance.Name == "Spawn" then
        local base = result.Instance
        while base and base.Parent ~= basesF do
            base = base.Parent
        end

        if base then
            _G.PlayerBase = base.Name
            print("✅ Base detected:", _G.PlayerBase)
            return
        end
    end

    warn("❌ Could not detect base")
end

Tabs.Main:AddButton({
    Title = "Detect My Base",
    Description = "Respawn and detect your real base",
    Callback = function()
        DetectPlayerBase()
    end
})

function DetectNotifi()
    Fluent:Notify({
        Title = "Black X",
        Content = "Please click detect my base to use this button",
        SubContent = "", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
})
end

function SlotNotofi()
    Fluent:Notify({
        Title = "Black X",
        Content = "Please select you slot",
        SubContent = "", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
})
end

Tabs.Main:AddButton({
    Title = "Pick Up",
    Description = "Pick brainrot from selected slot",
    Callback = function()

        local base = _G.PlayerBase
        local slot = tostring(slcbrn.Value)

        if not base then
            warn("❌ Base not detected. Click 'Detect My Base' first.")
            DetectNotifi()
            return
        end

        if not slot then
            warn("❌ No slot selected.")
            SlotNotofi()
            return
        end

        game:GetService("ReplicatedStorage")
            :WaitForChild("Packages")
            :WaitForChild("Net")
            :WaitForChild("RF/Plot.PlotAction")
            :InvokeServer(
                "Pick Up Brainrot",
                base,
                slot
            )

        print("✅ Picked slot:", slot)
    end
})


Tabs.Main:AddButton({
    Title = "Place",
    Description = "Place brainrot from selected slot",
    Callback = function()

        local base = _G.PlayerBase
        local slot = tostring(slcbrn.Value)

        if not base then
            warn("❌ Base not detected. Click 'Detect My Base' first.")
            DetectNotifi()
            return
        end

        if not slot then
            warn("❌ No slot selected.")
            SlotNotofi()
            return
        end

        game:GetService("ReplicatedStorage")
            :WaitForChild("Packages")
            :WaitForChild("Net")
            :WaitForChild("RF/Plot.PlotAction")
            :InvokeServer(
                "Place Brainrot",
                base,
                slot
            )

        print("✅ place slot:", slot)
    end
})





_G.infinjump = false

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

_G.PlayerBoost = false
_G.SpeedValue = 50
_G.JumpValue = 70

-- Function áp dụng boost
local function ApplyBoost()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.WalkSpeed = _G.SpeedValue
            humanoid.JumpPower = _G.JumpValue
        end
    end
end

-- Giữ giá trị nếu game reset
RunService.Heartbeat:Connect(function()
    if _G.PlayerBoost then
        ApplyBoost()
    end
end)

-- Khi respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    if _G.PlayerBoost then
        ApplyBoost()
    end
end)

-- TOGGLE
Tabs.Player:AddToggle("PlayerBoost", {
    Title = "Enable Player Boost",
    Default = false,
    Callback = function(state)
        _G.PlayerBoost = state
        
        if not state then
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                end
            end
        end
    end
})

-- SPEED SLIDER
Tabs.Player:AddSlider("SpeedSlider", {
    Title = "Speed",
    Default = 50,
    Min = 16,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        _G.SpeedValue = Value
    end
})

-- JUMP SLIDER
Tabs.Player:AddSlider("JumpSlider", {
    Title = "Jump Power",
    Default = 70,
    Min = 50,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        _G.JumpValue = Value
    end
})

-- SPEED SLIDER

-- INFINITE JUMP SYSTEM (chỉ chạy 1 lần)
if not _G.InfJumpStarted then
    _G.InfJumpStarted = true
    
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.infinjump then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end


_G.InfJump = false

local InfJumpToggle = Tabs.Player:AddToggle("InfJumpToggle", {
    Title = "Infinite Jump",
    Default = false,
    Callback = function(state)
        _G.InfJump = state
    end
})

-- Chạy 1 lần duy nhất
if not _G.InfJumpLoaded then
    _G.InfJumpLoaded = true
    
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end



--// Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

--------------------------------------------------
-- LẤY HRP MỚI (FIX SAU KHI CHẾT)
--------------------------------------------------

local function getHRP()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart")
end

--------------------------------------------------
-- GAP LIST
--------------------------------------------------

local gapList = {
    "Common","Uncommon","Rare","Legendary",
    "Mythical","Cosmic","Secret","Celestial","Divine"
}

--------------------------------------------------
-- DROPDOWN (FLUENT)
--------------------------------------------------

local Dropdown = Tabs.Main:AddDropdown("GapSelect", {
    Title = "Select Gap",
    Values = gapList,
    Multi = false,
    Default = 1
})

--------------------------------------------------
-- FIND GAP FOLDER
--------------------------------------------------

local function getGapFolder()

    local defaultMap = workspace:FindFirstChild("DefaultMap_SharedInstances")
    if defaultMap and defaultMap:FindFirstChild("Gaps") then
        return defaultMap.Gaps
    end

    local arcadeMap = workspace:FindFirstChild("ArcadeMap_SharedInstances")
    if arcadeMap and arcadeMap:FindFirstChild("Gaps") then
        return arcadeMap.Gaps
    end

    return nil
end

--------------------------------------------------
-- DANGER CHECK (CHỈNH THEO GAME)
--------------------------------------------------

local function isDanger(pos)
    return pos.Y < -15
end

--------------------------------------------------
-- TWEEN SYSTEM
--------------------------------------------------

local tweening = false
local currentTween
local heartbeatConnection

local function StopTween()

    tweening = false

    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end

    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

local function StartTween()

    if tweening then return end
    tweening = true

    task.spawn(function()

        local hrp = getHRP()
        local gapsFolder = getGapFolder()
        if not gapsFolder then
            tweening = false
            return
        end

        local selectedName = Dropdown.Value
        local selectedGapIndex = 1

        for i,v in ipairs(gapList) do
            if v == selectedName then
                selectedGapIndex = i
                break
            end
        end

        local currentGap = 1
        local lastSafeGapIndex = 0 -- 🔥 lưu index thay vì CFrame

        while tweening and currentGap <= selectedGapIndex do

            hrp = getHRP()

            local gap = gapsFolder:FindFirstChild("Gap"..currentGap)
            if not gap then break end

            local targetCF = gap:GetPivot() + Vector3.new(0,3,0)

            local tween = TweenService:Create(
                hrp,
                TweenInfo.new(
                    (hrp.Position - targetCF.Position).Magnitude / 150,
                    Enum.EasingStyle.Linear
                ),
                {CFrame = targetCF}
            )

            local cancelled = false

            local hb = RunService.Heartbeat:Connect(function()
                if isDanger(hrp.Position) then
                    cancelled = true
                    tween:Cancel()
                end
            end)

            tween:Play()
            tween.Completed:Wait()
            hb:Disconnect()

            if not tweening then break end

            if cancelled then

                -- 🔥 nếu có gap an toàn trước đó thì quay về đúng gap đó
                if lastSafeGapIndex > 0 then
                    local safeGap = gapsFolder:FindFirstChild("Gap"..lastSafeGapIndex)
                    if safeGap then
                        hrp.CFrame = safeGap:GetPivot() + Vector3.new(0,3,0)
                    end
                end

                task.wait(0.3)

            else
                -- cập nhật gap an toàn
                lastSafeGapIndex = currentGap
                currentGap += 1
                task.wait(0.2)
            end
        end

        tweening = false
    end)
end
--------------------------------------------------
-- RESET KHI CHẾT
--------------------------------------------------

player.CharacterAdded:Connect(function()
    tweening = false
end)

--------------------------------------------------
-- BUTTONS
--------------------------------------------------




Tabs.Main:AddButton({
    Title = "Start Tween",
    Description = "",
    Callback = function()
        StartTween()
    end
})



Tabs.Main:AddButton({
    Title = "Stop Tween",
    Description = "",
    Callback = function()
        StopTween()
    end
})







Tabs.Player:AddButton({
    Title = "Fly tool",
    Description = "",
    Callback = function()

        --// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// Tạo Tool
local tool = Instance.new("Tool")
tool.Name = "Fly Tool"
tool.RequiresHandle = false
tool.Parent = player:WaitForChild("Backpack")

--// Biến fly
local flying = false
local flySpeed = 60
local flyConnection
local bodyVelocity

--// Lấy HumanoidRootPart
local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

--// Bắt đầu bay
local function startFly()
    if flying then return end
    flying = true

    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")

    humanoid:ChangeState(Enum.HumanoidStateType.Physics)

    -- Attachment
    local attachment = Instance.new("Attachment")
    attachment.Parent = hrp

    -- LinearVelocity
    bodyVelocity = Instance.new("LinearVelocity")
    bodyVelocity.Attachment0 = attachment
    bodyVelocity.MaxForce = math.huge
    bodyVelocity.VectorVelocity = Vector3.zero
    bodyVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
    bodyVelocity.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()

        local camera = workspace.CurrentCamera
        local moveDirection = humanoid.MoveDirection

        if moveDirection.Magnitude > 0 then
            
            local camCF = camera.CFrame
            local direction =
                (camCF.LookVector * moveDirection.Z) +
                (camCF.RightVector * moveDirection.X)

            bodyVelocity.VectorVelocity = direction.Unit * flySpeed

        else
            bodyVelocity.VectorVelocity = Vector3.zero
        end

    end)
end

            
--// Tắt bay


--// Khi cầm tool
tool.Equipped:Connect(function()
    startFly()
end)

--// Khi bỏ tool
tool.Unequipped:Connect(function()
    stopFly()
end)
    end
})


_G.AutoSell = false

local function StartAutoSell()
    task.spawn(function()
        while _G.AutoSell do
            game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteFunctions")
                :WaitForChild("SellTool")
                :InvokeServer()

            task.wait(0.5) -- nên để 0.3 - 1 giây cho an toàn
        end
    end)
end



local Toggle = Tabs.Automatic:AddToggle("MyToggle", {
    Title = "Auto Sell brainrot",
    Description = "Auto sell inventory brainrot",
    Default = false,
    Callback = function(state)
        _G.AutoSell = state

        if state then
            StartAutoSell()
        end
    end
})





_G.BrainrotESP = false

local rarity = {
    "Common","Uncommon","Rare","Legendary",
    "Mythical","Cosmic","Secret","Celestial","Divine"
}

local rarityColors = {
    Common = Color3.fromRGB(200,200,200),
    Uncommon = Color3.fromRGB(100,255,100),
    Rare = Color3.fromRGB(0,170,255),
    Legendary = Color3.fromRGB(255,170,0),
    Mythical = Color3.fromRGB(255,0,255),
    Cosmic = Color3.fromRGB(0,255,255),
    Secret = Color3.fromRGB(255,0,0),
    Celestial = Color3.fromRGB(255,255,0),
    Divine = Color3.fromRGB(255,255,255)
}

local activeFolder = workspace:WaitForChild("ActiveBrainrots")

local function AddESP()
    for _, rarityName in ipairs(rarity) do
        local rarityFolder = activeFolder:FindFirstChild(rarityName)

        if rarityFolder then
            for _, model in ipairs(rarityFolder:GetChildren()) do
                if model:IsA("Model") then
                    
                    if not model.PrimaryPart then
                        model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
                    end

                    if model.PrimaryPart and not model.PrimaryPart:FindFirstChild("BrainrotESP") then
                        
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "BrainrotESP"
                        billboard.Size = UDim2.new(0,200,0,50)
                        billboard.StudsOffset = Vector3.new(0,3,0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = model.PrimaryPart
                        
                        local text = Instance.new("TextLabel")
                        text.Size = UDim2.new(1,0,1,0)
                        text.BackgroundTransparency = 1
                        text.TextScaled = true
                        text.Font = Enum.Font.GothamBold
                        text.Text = model.Name
                        text.TextColor3 = rarityColors[rarityName] or Color3.new(1,1,1)
                        text.Parent = billboard
                    end
                end
            end
        end
    end
end

local function RemoveESP()
    for _, v in ipairs(activeFolder:GetDescendants()) do
        if v:IsA("BillboardGui") and v.Name == "BrainrotESP" then
            v:Destroy()
        end
    end
end


Tabs.Visual:AddToggle("BrainrotESP", {
    Title = "Brainrot ESP",
    Description = "Show brainrot name + rarity color",
    Default = false,
    Callback = function(state)
        _G.BrainrotESP = state
        
        if state then
            AddESP()
        else
            RemoveESP()
        end
    end
})


--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local espConnections = {}

--------------------------------------------------
-- TẠO ESP CHO 1 PLAYER
--------------------------------------------------

local function AddESP(target)
    if target == player then return end

    local function setup(character)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        if not hrp then return end
        if hrp:FindFirstChild("PlayerESP") then return end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESP"
        billboard.Size = UDim2.new(0,200,0,50)
        billboard.StudsOffset = Vector3.new(0,3,0)
        billboard.AlwaysOnTop = true
        billboard.Parent = hrp

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.TextScaled = true
        text.Font = Enum.Font.GothamBold
        text.TextColor3 = Color3.fromRGB(255,0,0)
        text.Parent = billboard

        espConnections[target] = RunService.RenderStepped:Connect(function()
            if not _G.PlayerESP then return end
            if player.Character and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local distance = math.floor(
                    (player.Character.HumanoidRootPart.Position -
                    target.Character.HumanoidRootPart.Position).Magnitude
                )
                text.Text = target.Name .. " | " .. distance .. "m"
            end
        end)
    end

    if target.Character then
        setup(target.Character)
    end

    target.CharacterAdded:Connect(setup)
end

--------------------------------------------------
-- XÓA ESP
--------------------------------------------------

local function RemoveESP()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BillboardGui") and v.Name == "PlayerESP" then
            v:Destroy()
        end
    end

    for _, conn in pairs(espConnections) do
        conn:Disconnect()
    end

    espConnections = {}
end

--------------------------------------------------
-- TOGGLE FLUENT
--------------------------------------------------

Tabs.Visual:AddToggle("PlayerESP", {
    Title = "Player ESP",
    Description = "Show player name and distance",
    Default = false,
    Callback = function(state)
        _G.PlayerESP = state

        if state then
            for _, plr in ipairs(Players:GetPlayers()) do
                AddESP(plr)
            end

            Players.PlayerAdded:Connect(function(plr)
                AddESP(plr)
            end)
        else
            RemoveESP()
        end
    end
})
