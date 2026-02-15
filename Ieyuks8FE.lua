-- 15th Jan 2026
--Realme C12
--Android
-- 0:09 PM

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Ieyuks8 FE",
    Icon = "star", -- lucide icon
    Author = "by Ieyuks8",
    Folder = "FESrc",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
  
    
    KeySystem = {                                                   
        Note = "FE Ieyuks8 Key System. With platoboost.",              
        API = {                                                     
            { -- PlatoBoost
                Type = "platoboost",                                
                ServiceId = 20829, -- service id
                Secret = "c26c506b-738d-4437-8d88-884a3bd27066", -- platoboost secret
            },                                                      
        },                                                          
    },                                                              
})

local Tab1 = Window:Tab({
    Title = "Server",
    Icon = "server", -- optional
    Locked = false,
})


local Tab2 = Window:Tab({
    Title = "Player",
    Icon = "person-standing", -- optional
    Locked = false,
})

local Tab3 = Window:Tab({
    Title = "Scripts",
    Icon = "scroll", -- optional
    Locked = false,
})

local Tab4 = Window:Tab({
    Title = "Executor",
    Icon = "code", -- optional
    Locked = true,
})

local Tab5 = Window:Tab({
    Title = "Settings",
    Icon = "settings", -- optional
    Locked = false,
})

-----------------
--Setting / service

local Lighting = game:GetService("Lighting")
local CurrentSkyID = "123456" 
local CurrentDecalID = "123456" 
local CurrentParticleID = "123456" 









-- Input Skybox ID
local SkyID = Tab5:Input({
    Title = "Skybox ID",
    Desc = "",
    Value = "107133173539182",
    InputIcon = "",
    Type = "Input",
    Placeholder = "-- Id",
    Callback = function(input)
        CurrentSkyID = input
        print("Skybox ID set to: " .. input)
    end
})


local Skybox = Tab1:Button({
    Title = "Set Skybox",
    Desc = "Set skybox with id from Settings tab",
    Locked = false,
    Callback = function()

        if not CurrentSkyID or CurrentSkyID == "" then
            warn("Skybox ID is empty!")
            return
        end

        -- Xóa sky cũ nếu có
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end

        -- Tạo sky mới
        local Sky = Instance.new("Sky")
        Sky.Parent = Lighting

        local id = "rbxassetid://" .. CurrentSkyID

        Sky.SkyboxBk = id
        Sky.SkyboxDn = id
        Sky.SkyboxFt = id
        Sky.SkyboxLf = id
        Sky.SkyboxRt = id
        Sky.SkyboxUp = id

        print("Skybox applied!")
    end
})





---------------------------
-------settings

local DecalID = Tab5:Input({
    Title = "Decal ID",
    Desc = "",
    Value = "107133173539182",
    InputIcon = "",
    Type = "Input",
    Placeholder = "-- Id",
    Callback = function(input)
        CurrentDecalID = input
        print("Decal ID set to: " .. input)
    end
})


local Decal = Tab1:Button({
    Title = "Spam Decal",
    Desc = "Spam Decal with id from Settings tab",
    Locked = false,
    Callback = function()

        if not CurrentDecalID or CurrentDecalID == "" then
            warn("Decal ID is empty!")
            return
        end
        

        decalID = CurrentDecalID
function exPro(root)
	for _, v in pairs(root:GetChildren()) do
		if v:IsA("Decal") and v.Texture ~= "http://www.roblox.com/asset/?id="..decalID then
			v.Parent = nil
		elseif v:IsA("BasePart") then
			v.Material = "Plastic"
			v.Transparency = 0

			local faces = {"Front", "Back", "Right", "Left", "Top", "Bottom"}
			for _, face in ipairs(faces) do
				local decal = Instance.new("Decal", v)
				decal.Texture = "http://www.roblox.com/asset/?id="..decalID
				decal.Face = face
			end
		end
		exPro(v)
	end
end

function asdf(root)
	for _, v in pairs(root:GetChildren()) do
		asdf(v)
	end
end

exPro(game.Workspace)
asdf(game.Workspace)
    end
})









local ParticleID = Tab5:Input({
    Title = "Particle ID",
    Desc = "",
    Value = "107133173539182",
    InputIcon = "",
    Type = "Input",
    Placeholder = "-- Id",
    Callback = function(input)
        CurrentParticleID = input
        print("Particle ID set to: " .. input)
    end
})






local Particle = Tab1:Button({
    Title = "Spam Particle",
    Desc = "Spam Particle with id from Settings tab",
    Locked = false,
    Callback = function()

        if not CurrentDecalID or CurrentDecalID == "" then
            warn("Decal ID is empty!")
            return
        end
        
        local ID = CurrentParticleID
        
        for i,v in pairs (game.Workspace:GetChildren()) do
        if v:IsA("Part") then
        local particle = Instance.new("ParticleEmitter")
              particle.Texture = "http://www.roblox.com/asset/?id=" ..ID
              particle.Parent = v
              particle.Rate = 200
             for i,x in pairs (game.Workspace:GetChildren()) do
                if x:IsA("Model") then
                   for i,z in pairs (x:GetChildren()) do
                      if z:IsA("Part") then
                         local particle2 = Instance.new("ParticleEmitter")
                          particle2.Texture = "http://www.roblox.com/asset/?id=" ..ID
                          particle2.Parent = z
                          particle2.Rate = 200
                    end
                 end
              end
            end
          end
        end
    end
})




local ParticleV = Tab1:Button({
    Title = "Spam Particle V2",
    Desc = "Spam Particle V2 with id from Settings tab",
    Locked = false,
    Callback = function()

        if not CurrentDecalID or CurrentDecalID == "" then
            warn("Particle ID is empty!")
            return
        end
        
        local ID = CurrentParticleID
        
        for i,v in pairs (game.Workspace:GetChildren()) do
        if v:IsA("Part") then
        local particle = Instance.new("ParticleEmitter")
              particle.Texture = "http://www.roblox.com/asset/?id=" ..ID
              particle.Parent = v
              particle.Rate = 200000
            particle.Rotation = NumberRange.new(0,360)
            particle.RotSpeed = NumberRange.new(-360,360)
            particle.Speed = NumberRange.new(20,40)
particle.Lifetime = NumberRange.new(1,2)

particle.SpreadAngle = Vector2.new(180,180)

particle.Acceleration = Vector3.new(0,0,0)

particle.VelocityInheritance = 0
             for i,x in pairs (game.Workspace:GetChildren()) do
                if x:IsA("Model") then
                   for i,z in pairs (x:GetChildren()) do
                      if z:IsA("Part") then
                         local particle2 = Instance.new("ParticleEmitter")
                          particle2.Texture = "http://www.roblox.com/asset/?id=" ..ID
                          particle2.Parent = z
                          particle2.Rate = 200000
                          particle2.Rotation = NumberRange.new(0,360)
                          particle2.RotSpeed = NumberRange.new(-360,360)

particle2.Acceleration = Vector3.new(0,0,0)

particle2.VelocityInheritance = 0
                          particle2.Speed = NumberRange.new(20,40)
particle2.Lifetime = NumberRange.new(1,2)

particle2.SpreadAngle = Vector2.new(180,180)
                    end
                 end
              end
            end
          end
        end
    end
})







local Sheledsky = Tab1:Button({
    Title = "Sheledsky",
    Desc = "",
    Locked = false,
    Callback = function()
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
s = Instance.new("Sky")
s.Name = "SKY"
s.SkyboxBk = "http://www.roblox.com/asset/?id=172423468"
s.SkyboxDn = "http://www.roblox.com/asset/?id=172423468"
s.SkyboxFt = "http://www.roblox.com/asset/?id=172423468"
s.SkyboxLf = "http://www.roblox.com/asset/?id=172423468"
s.SkyboxRt = "http://www.roblox.com/asset/?id=172423468"
s.SkyboxUp = "http://www.roblox.com/asset/?id=172423468"
s.Parent = game.Lighting
local c00lkidd1 = Instance.new("Sound", game.SoundService)
local c00lkidd2 = Instance.new("Sound", game.SoundService)
local c00lkidd3 = Instance.new("Sound", game.SoundService)
local c00lkidd4 = Instance.new("Sound", game.SoundService)
local c00lkidd5 = Instance.new("Sound", game.SoundService)
local c00lkidd6 = Instance.new("Sound", game.SoundService)

Instance.new("DistortionSoundEffect", c00lkidd1)
Instance.new("DistortionSoundEffect", c00lkidd1)
Instance.new("DistortionSoundEffect", c00lkidd1)

Instance.new("DistortionSoundEffect", c00lkidd2)
Instance.new("DistortionSoundEffect", c00lkidd2)
Instance.new("DistortionSoundEffect", c00lkidd2)

Instance.new("DistortionSoundEffect", c00lkidd3)
Instance.new("DistortionSoundEffect", c00lkidd3)
Instance.new("DistortionSoundEffect", c00lkidd3)

Instance.new("DistortionSoundEffect", c00lkidd4)
Instance.new("DistortionSoundEffect", c00lkidd4)
Instance.new("DistortionSoundEffect", c00lkidd4)

Instance.new("DistortionSoundEffect", c00lkidd5)
Instance.new("DistortionSoundEffect", c00lkidd5)
Instance.new("DistortionSoundEffect", c00lkidd5)

c00lkidd1.SoundId = "rbxassetid://82020270111776"
c00lkidd2.SoundId = "rbxassetid://98507417558287"
c00lkidd3.SoundId = "rbxassetid://86474191257848"
c00lkidd4.SoundId = "rbxassetid://84113601885842"
c00lkidd5.SoundId = "rbxassetid://83282320583623"

c00lkidd1.Volume = 10
c00lkidd2.Volume = 10
c00lkidd3.Volume = 10
c00lkidd4.Volume = 10
c00lkidd5.Volume = 10

c00lkidd1.PlaybackSpeed = 1
c00lkidd2.PlaybackSpeed = 1
c00lkidd3.PlaybackSpeed = 1
c00lkidd4.PlaybackSpeed = 1
c00lkidd5.PlaybackSpeed = 1


c00lkidd1:Play()

c00lkidd1.Ended:Connect(function()
c00lkidd2:Play()
end)

c00lkidd2.Ended:Connect(function()
c00lkidd3:Play()
end)

c00lkidd3.Ended:Connect(function()
c00lkidd4:Play()
end)

c00lkidd4.Ended:Connect(function()
c00lkidd5:Play()
end)

c00lkidd5.Ended:Connect(function()
c00lkidd6:Play()
end)
local ID =18889618673 --id here
t1 = "http://www.roblox.com/asset/?id=18343405871"
t2 = "http://www.roblox.com/asset/?id=18343405871"
t3 = "http://www.roblox.com/asset/?id=18343405871"

local p = game.Players:GetChildren()
local w = game.Workspace:GetChildren()

for i,v in pairs(p) do
pe = Instance.new("ParticleEmitter", v.Character.Head)
pe.Texture = t3
pe.VelocitySpread = 5
end
    end
})



local Killall = Tab1:Button({
    Title = "Kill All",
    Desc = "",
    Locked = false,
    Callback = function()
        local player = game:GetService("Players")
        
        for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end
	end
    end
})


local flingall = Tab1:Button({
    Title = "Fling All",
    Desc = "",
    Locked = false,
    Callback = function()
        local Targets = {"All"} -- "All", "Target Name", "arian_was_here"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return print("hddb")
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return print("ueh")
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return print("hed")
    end
end

if not Welcome then print("flibg") end
getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            
        end
    elseif not GetPlayer(x) and not AllBool then
        
    end
end
        
        
    end
})


local Players = game:GetService("Players")

local function GetPlayerNames()
	local list = {}
	for _, plr in ipairs(Players:GetPlayers()) do
		table.insert(list, plr.Name)
	end
	return list
end

local playerlist = GetPlayerNames()
local chosePlayer = "pl"

local Dropdown = Tab:Dropdown({
    Title = "Select Player",
    Desc = "Choose player in server",
    Values = playerlist,
    Value = nil,
    Multi = false,
    AllowNone = true,
    Callback = function(option)
        chosePlayer = option
        print("Selected:", table.concat(option, ", "))
    end
})





local fling = Tab1:Button({
    Title = "Fling",
    Desc = "",
    Locked = false,
    Callback = function()
        local Targets = chosePlayer -- "All", "Target Name", "arian_was_here"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return print("hddb")
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return print("ueh")
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return print("hed")
    end
end

if not Welcome then print("flibg") end
getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            
        end
    elseif not GetPlayer(x) and not AllBool then
        
    end
end
        
        
    end
})



