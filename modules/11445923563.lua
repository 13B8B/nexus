if getgenv().nexus then return end 
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local LocalPlayer, localPlayer = Players.LocalPlayer, Players.LocalPlayer
local fileName = "FLORENCE/SETTINGS/" .. game.PlaceId .. '.txt'
local UserInputService = game:GetService("UserInputService")
local Islands = {}
local Interactions = {}
local GettingQuest 
local ChestTeleporting

getgenv().settings = {}
getgenv().nexus = true

if isfile("FLORENCE/SETTINGS/" .. game.PlaceId .. '.txt') then
    local sl, er = pcall(function()
        getgenv().settings = game:GetService('HttpService'):JSONDecode(readfile("FLORENCE/SETTINGS/" .. game.PlaceId .. '.txt'))
    end)
    if er ~= nil then
        forceServerHop()
        return 
    end
end 

writefile("FLORENCE/SETTINGS/" .. game.PlaceId .. '.txt', HttpService:JSONEncode(getgenv().settings))

function forceServerHop()
    local Api = "https://games.roblox.com/v1/games/"
    local placeId, jobId = game.PlaceId, game.JobId
    local serversUrl = Api .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"

    local function ListServers(cursor)
        local raw = game:HttpGet(serversUrl .. (cursor and "&cursor=" .. cursor or ""))
        return HttpService:JSONDecode(raw)
    end

    local nextCursor
    repeat
        local serversData = ListServers(nextCursor)
        for _, server in ipairs(serversData.data) do
            if server.playing < server.maxPlayers and server.id ~= jobId then
                local success, result = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, placeId, server.id, LocalPlayer)
                if success then
                    break
                end
            end
        end
        nextCursor = serversData.nextPageCursor
    until not nextCursor
end

local myEvent = Instance.new("BindableEvent")
local connection = myEvent.Event:Connect(function()
end)

local function createLoop(callback)
    return spawn(function()
        while task.wait() do
            if connection.Connected == true then
                local success, result = pcall(function() 
                    callback()
                end)
            end
        end
    end)
end

createLoop(function()
    for key, value in pairs(getgenv().settings) do
	if connection.Connected == true and getgenv().settings.AutoSave == true then 
        getgenv().settings[key] = value
        writefile(fileName, HttpService:JSONEncode(getgenv().settings))
		end
    end
end)

repeat wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local success, result = pcall(function() 
    while game:GetService("Players").LocalPlayer.PlayerGui.LoadingGui.Frame.Play or game:GetService("Players").LocalPlayer.PlayerGui.LoadingGui.Frame.Play.Visible do wait(1)
        local a = game:GetService("Players").LocalPlayer.PlayerGui.LoadingGui.Frame.Play
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X + a.AbsoluteSize.X/2, a.AbsolutePosition.Y + 50, 0, true, a, 1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X + a.AbsoluteSize.X/2, a.AbsolutePosition.Y + 50, 0, false, a, 1)
    end
end)

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__SpawnLocations"]:GetChildren()) do
	table.insert(Islands, v.Name)
end

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Interactions"]:GetChildren()) do
	if not table.find(Interactions, v.Name) then
		table.insert(Interactions, v.Name)
	end
end

local Fluent = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
--[[
   premium = true
]]

local Window = Fluent:CreateWindow({
    Title = "nexus ", "",
    SubTitle = "",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
})

local Tabs = {
    Main = Window:AddTab({
        Title = "Main",
        Icon = "rbxassetid://10723424505"
    }),
    Misc = Window:AddTab({
        Title = "Misc",
        Icon = "rbxassetid://10709818534"
    }),
    Player = Window:AddTab({
        Title = "Player",
        Icon = "rbxassetid://10747373176"
    }),
    Weapon = Window:AddTab({ 
        Title = "Weapon",
        Icon = "rbxassetid://4335480896"
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    }),
        Premium = premium == "premium" and Window:AddTab({
        Title = "Premium",
        Icon = "rbxassetid://10709819149"
    }),

}

local islandData = {
    ["Starter Island"] = {
        options = {"Bandit", "Strong Bandit", "Bandit Leader"},
        mapping = CFrame.new(3388, 145, 1728),
        point = "Starter Island"
    },
    ["Jungle Island"] = {
        options = {"Monkey", "Gorilla", "King Gorilla"},
        mapping = CFrame.new(1986, 140, 598),
        point = "JunglePoint"
    },
    ["Clown Island"] = {
        options = {"Clown", "Killer Clown", "Clown King"},
        mapping = CFrame.new(3007, 150, -587),
        point = "BuggyPoint"
    },
    ["Marine Island"] = {
        options = {"Marine", "Marine Official", "Lorgan"},
        mapping = CFrame.new(4941, 145, 56),
        point = "MarinePoint"
    },
    ["Lier Island"] = {
        options = {"Cat Pirate", "Mansion Guard", "Buros"},
        mapping = CFrame.new(5557, 150, 2040),
        point = "UsoppPoint"
    },
    ["Baratie"] = {
        options = {"Don Pirate", "Perolado", "Gimbo", "Don Zig"},
        mapping = CFrame.new(1363, 180, 2680),
        point = "BaratiePoint"
    },
    ["AR Park"] = {
        options = {"Marine Soldier", "Captain Rat", "Fishman", "Chewing", "Kolobi"},
        mapping = CFrame.new(-672, 160, 631),
        point = "ArlongPoint"
    },
    ["Lulue Town"] = {
        options = {"Logue Bandit", "Bashigs", "White", "Alvarida", "Logue Marine"},
        mapping = CFrame.new(5791, 140, -3231),
        point = "LoguePoint"
    }
}

local SelectedMobs = {getgenv().settings.SelectedEnemy}

local function moveToPosition(position, duration)
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character

    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local LocalHumanoidRootPart = Character.HumanoidRootPart

        local success, err = pcall(function()
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad)
            local tween = game:GetService("TweenService"):Create(LocalHumanoidRootPart, tweenInfo, {CFrame = position})
            tween:Play()
            wait(duration)
        end)
    end 
end

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Auto Farm",
    Default = getgenv().settings.AutoFarm,
    Callback = function(value)
        getgenv().settings.AutoFarm = value
    end
})

local Dropdownn = Tabs.Main:AddDropdown("Dropdown", {
    Title = "Select Mob", 
    Values = {},
    Multi = false, 
    Default = getgenv().settings.SelectedEnemy, 
    Callback = function(value)
        getgenv().settings.SelectedEnemy = value
        if not table.find(SelectedMobs, value) then
            table.insert(SelectedMobs, value)
        end
    end
})
local Dropdownnn = Tabs.Main:AddDropdown("Dropdownnn", {
    Title = "Select World",
    Values = {"Starter Island", "Jungle Island", "Clown Island", "Marine Island", "Lier Island", "Baratie", "AR Park", "Lulue Town"},
    Multi = false,
    Default = getgenv().settings.selectedIsland,
    Callback = function(value)
        getgenv().settings.selectedIsland = value

        local island = islandData[getgenv().settings.selectedIsland]
        
        local PointOutput = island.point
        if PointOutput then
            local ohTable1 = {
                [1] = {
                    [1] = utf8.char(3),
                    [2] = "ChangeSpawnPoint",
                    [3] = PointOutput
                }
            }
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
        end
        
        local output = island.mapping
        if output then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = output
        end

        Dropdownn:SetValues(island.options)
    end
})
local selectedIslandData = islandData[getgenv().settings.selectedIsland]

if selectedIslandData and selectedIslandData.options then
    Dropdownn:SetValues(selectedIslandData.options)
end

local Players = game:GetService("Players")
local Mobs = workspace["__GAME"]["__Mobs"]
local Player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() and Players.LocalPlayer
local function TP(position, time)
    local humanoidRootPart = LocalPlayer.Character.HumanoidRootPart
    local info = TweenInfo.new(time, Enum.EasingStyle.Quad)
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, info, {CFrame = CFrame.new(position)})
    tween:Play()
end

local function getClosestMob(name)
	local closest, maxDist = nil, 9e9
	for _, v in pairs(Mobs:GetChildren()) do
		for _, mob in pairs(v:GetChildren()) do
			if mob:FindFirstChild("NpcConfiguration") and mob.NpcConfiguration:GetAttribute("Health") > 0 then
				if mob.NpcConfiguration:GetAttribute("Name") == name then
					local dist = (mob.PrimaryPart.Position - Player.Character.PrimaryPart.Position).magnitude
					if dist < maxDist then
						maxDist = dist
						closest = mob
					end
				end
			end
		end
	end
	return closest
end
createLoop(function()  
    if #SelectedMobs > 0 and not ChestTeleporting and not GettingQuest and getgenv().settings.AutoFarm then
        local tool = Player.Backpack:FindFirstChild("Combat")
        Player.Character.Humanoid:EquipTool(tool)
        local enemy = getClosestMob(getgenv().settings.SelectedEnemy)

        moveToPosition(enemy.PrimaryPart.CFrame, .03)

        local ohTable1 = {
            [1] = {
                [1] = utf8.char(4),
                [2] = "Combat",
                [3] = 1,
                [4] = false,
                [5] = workspace.__GAME.__Players[Player.Name].Combat,
                [6] = "Melee"
            },
            [2] = {
                [1] = "	",
                [2] = enemy,
                [3] = workspace.__GAME.__Players[Player.Name].Combat
            }
        }
        if ohTable1 then
            game:GetService("ReplicatedStorage").RemoteEvent:FireServer(ohTable1)
  
        end
    end
end)

local areaFolder = game.Workspace.__GAME.__Quests

local function populateDropdown()
    local dropdownValues = {}
    if areaFolder and areaFolder:IsA("Folder") then
        for _, item in ipairs(areaFolder:GetChildren()) do
            if item:IsA("Model") and item:FindFirstChild("HumanoidRootPart") then
                local labelText = item.Head.Icon.TextLabel.Text
                if labelText ~= "" then
                    table.insert(dropdownValues, labelText)
                end
            end
        end
    end 

    table.sort(dropdownValues, function(a, b)
        local numA = tonumber(a:match("(%d+)"))
        local numB = tonumber(b:match("(%d+)"))
        return numA < numB
    end)
    
    return dropdownValues
end


local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Auto Start Quest",
    Default = getgenv().settings.AutoQuest,
    Callback = function(value)
        getgenv().settings.AutoQuest = value
    end
})

local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
    Title = "Select Quest",
    Values = populateDropdown(), 
    Multi = false,
    Default = getgenv().settings.selectedQuest,
    Callback = function(value)
        getgenv().settings.selectedQuest = value 
    end
})

createLoop(function()
    local questName = getgenv().settings.selectedQuest or "nil"
    local questNumberStr = questName:match("(%d+)")
    local questNumber = tonumber(questNumberStr)
    local currentPosition = game:GetService("Players").LocalPlayer.PlayerGui.Quests.CurrentQuestContainer.AbsolutePosition  

    if currentPosition == Vector2.new(2880, 348.968) and getgenv().settings.AutoQuest and getgenv().settings.selectedQuest and not ChestTeleporting then
        GettingQuest = true 
        for _, item in ipairs(areaFolder:GetChildren()) do
            if item:IsA("Model") and item:FindFirstChild("HumanoidRootPart") then
                local itemName = item.Name 
                local itemNumber = itemName:match("(%d+)")  

                itemNumber = tostring(tonumber(itemNumber)) or itemNumber

                local labelText = item.Head.Icon.TextLabel.Text
                if labelText == getgenv().settings.selectedQuest then
                    moveToPosition(item.HumanoidRootPart.CFrame, 0.5) wait(1)
                    game:GetService("ReplicatedStorage").RemoteEvent:FireServer({{utf8.char(3), "GetQuest", itemNumber}})
                    break
                end  
            end
        end
        GettingQuest = false 
    end
end)


areaFolder.ChildAdded:Connect(function()
    Dropdown:SetValues(populateDropdown())
end)

areaFolder.ChildRemoved:Connect(function()
    Dropdown:SetValues(populateDropdown())
end)

local availableTools = {} 

local Dropdown = Tabs.Weapon:AddDropdown("Dropdown", {
    Title = "Weapon",
    Values = {},  
    Multi = false,
    Default = "Select",
    Callback = function(value)
        getgenv().settings.SelectedWeapon = value
    end
})
local function updateDropdownValues()
    local dropdownValues = {}

    for toolName, _ in pairs(availableTools) do
        table.insert(dropdownValues, toolName)
    end

    local equippedTool = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if equippedTool then
        table.insert(dropdownValues, equippedTool.Name)
    end

    Dropdown:SetValues(dropdownValues)
end

game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
    if tool:IsA("Tool") then
        availableTools[tool.Name] = true
        updateDropdownValues()
    end
end)

game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(function(tool)
    if tool:IsA("Tool") then
        availableTools[tool.Name] = nil
        updateDropdownValues()
    end
end)

for _, tool in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") then
        availableTools[tool.Name] = true
    end
end
updateDropdownValues()
local Toggle = Tabs.Weapon:AddToggle("Toggle", {
    Title = "Auto Lv Weapon",
    Default = getgenv().settings.AutoWeaponLv,
    Callback = function(value)
        getgenv().settings.AutoWeaponLv = value
    end
})
local function equipSelectedTool()
    local selectedToolName = getgenv().settings.SelectedWeapon
    local player = game:GetService("Players").LocalPlayer

    if player.Character then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        local selectedTool = player.Backpack:FindFirstChild(selectedToolName)

        if selectedTool and (not equippedTool or equippedTool.Name ~= selectedToolName) then
            equippedTool = equippedTool or player.Character:FindFirstChildOfClass("Tool")

            if equippedTool then
                equippedTool.Parent = player.Backpack
            end

            selectedTool.Parent = player.Character
        end
    end
end

createLoop(function()
    if getgenv().settings.AutoWeaponLv then
        task.wait()
        equipSelectedTool()
        require(game:GetService("ReplicatedStorage").SharedModules.Controllers.ToolController).UseTool("Combat", Enum.UserInputState.Begin)
    end
end)

local Toggle = Tabs.Weapon:AddToggle("Toggle", {
    Title = "Auto Lv All Weapons",
    Default = getgenv().settings.AutoLvWeapons,
    Callback = function(value)
        getgenv().settings.AutoLvWeapons = value
    end
})
createLoop(function()
    if getgenv().settings.AutoLvWeapons then
		local Player = game:GetService("Players").LocalPlayer
        Player.Character.Humanoid:UnequipTools()
        for i, Tool in pairs(Player.Backpack:GetChildren()) do
            if Tool:IsA("Tool") then
                Tool.Parent = Player.Character
                require(game:GetService("ReplicatedStorage").SharedModules.Controllers.ToolController).UseTool("Combat", Enum.UserInputState.Begin)
                task.wait(.3)
                Tool.Parent = Player.Backpack
            end
        end  
    end
end)
local Toggle = Tabs.Weapon:AddToggle("Toggle", {
    Title = "Auto Skill",
    Default = getgenv().settings.AutoSkill,
    Callback = function(value)
        getgenv().settings.AutoSkill = value
    end
})
createLoop(function()
    if getgenv().settings.AutoSkill then
        local virtualInput = game:GetService("VirtualInputManager")
        local Player = game:GetService("Players").LocalPlayer
            
        for _,r in pairs(Player.Character:GetChildren()) do
            if r:IsA("Tool") and r.Name ~= "Defence" then
                for i,v in pairs({"Z", "X", "C", "V", "B"}) do
                    if Player.Character:FindFirstChild("HumanoidRootPart") then
                        virtualInput:SendKeyEvent(true, v, false, nil)
                        virtualInput:SendKeyEvent(false, v, false, nil)
                        task.wait(.1)
                    end
                end
            end
        end  
    end
end)

local Toggle = Tabs.Misc:AddToggle("Toggle", {
    Title = "Auto Chest [ Server - Hop ]",
    Default = getgenv().settings.AutoChest1,
    Callback = function(value)
    if value == true then 
        Fluent:Notify({Title = 'Notification', Content = 'Down until Synapse X back', Duration = 5 })
     end 
     -- getgenv().settings.AutoChest1 = value
    end
})

--[[local function interactWithChests1()
    if getgenv().settings.AutoChest1 then
        local SavedPosition
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:FindFirstChild("ChestInteract") or v.Name == "GiftModel" then
                local character = Player.Character
                if character then
                    SavedPosition = character:WaitForChild("HumanoidRootPart").CFrame
                    ChestTeleporting = true

                    character:WaitForChild("HumanoidRootPart").CFrame = v.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                    wait(5)
                    fireproximityprompt(v.ChestInteract)
                    wait(0.5)
                    character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
                    wait(1)
                end
            else 
                forceServerHop()
            end
        end 

        if SavedPosition then
            Player.Character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
        end
        
        ChestTeleporting = false
    end
end

createLoop(interactWithChests1)]]


local Toggle = Tabs.Misc:AddToggle("Toggle", {
    Title = "Auto Chest",
    Default = getgenv().settings.AutoChest,
    Callback = function(value)
        getgenv().settings.AutoChest = value
    end
})

local function interactWithChests()
    if getgenv().settings.AutoChest then
        local SavedPosition
        for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v:FindFirstChild("ChestInteract") or v.Name == "GiftModel" then
                local character = Player.Character
                if character then
                    SavedPosition = character:WaitForChild("HumanoidRootPart").CFrame
                    ChestTeleporting = true

                    character:WaitForChild("HumanoidRootPart").CFrame = v.PrimaryPart.CFrame * CFrame.new(0, 3, 0)
                    wait(5)
                    fireproximityprompt(v.ChestInteract)
                    wait(0.5)
                    character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
                    wait(1)
                end
            end
        end

        if SavedPosition then
            Player.Character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
        end
        
        ChestTeleporting = false
    end
end

createLoop(interactWithChests)

local Dropdown = Tabs.Misc:AddDropdown("Dropdown", {
    Title = "Teleport to Interaction",
    Values = Interactions,
    Multi = false,
    Default = "",
	Callback = function(Option)
        moveToPosition(game:GetService("Workspace")["__GAME"]["__Interactions"]:FindFirstChild(Option).PrimaryPart.CFrame, .1)
    end
})
local Dropdown = Tabs.Misc:AddDropdown("Dropdown", {
    Title = "Teleport to Island",
    Values = Islands,
    Multi = false,
    Default = "",
    Callback = function(Option)
        moveToPosition(game:GetService("Workspace")["__GAME"]["__SpawnLocations"]:FindFirstChild(Option).CFrame, .1)
    end  
})

local function RedeemCodes()
local Url = "https://tryhardguides.com/one-fruit-simulator-codes/"
local Response = game:HttpGet(Url)
local Codes = {}

for ul in string.gmatch(Response, "<ul>(.-)</ul>") do
    for li in string.gmatch(ul, "<li>(.-)</li>") do
        for Code in string.gmatch(li, "<strong>([^<]+)</strong>") do
            table.insert(Codes, Code)
        end
    end
end


for _, Code in ipairs(Codes) do
    local args = {
        [1] = {
            [1] = {
                [1] = "\3",
                [2] = "UseCode",
                [3] = Code
            }
        }
    }
    game:GetService("ReplicatedStorage").RemoteEvent:FireServer(unpack(args))

    end
end  

Tabs.Misc:AddButton({
    Title = "Redeem Codes",
    Callback = function()
        RedeemCodes()
    end 
})

local Toggle = Tabs.Player:AddToggle("Toggle", {
    Title = "Walkspeed",
    Default = getgenv().settings.Walkspeed or false,
    Callback = function(value)
        getgenv().settings.Walkspeed = value
    end
})

local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "Walk Speed",
    Default = getgenv().settings.WS or 50,
    Min = 50,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        getgenv().settings.WS = Value
    end
})

local function setWalkSpeed(walkSpeed)

   local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
   if humanoid then
       humanoid.WalkSpeed = walkSpeed
   end
end

createLoop(function()
    if getgenv().settings.Walkspeed then task.wait(.1)
        setWalkSpeed(getgenv().settings.WS)  
    else 
        setWalkSpeed(16)  
        repeat task.wait() until getgenv().settings.Walkspeed 
    end
end)  

local Toggle = Tabs.Player:AddToggle("Toggle", {
   Title = "Jump Power",
   Default = getgenv().settings.JumpPower or false,
   Callback = function(value)
   getgenv().settings.JumpPower = value
   end
})

local Slider = Tabs.Player:AddSlider("Slider", {
    Title = "Jump Power",
    Default = getgenv().settings.JP or 50,
    Min = 50,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        getgenv().settings.JP = Value
    end
})

local function setJumpPower(jumpPower)
   local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
   if humanoid then
    humanoid.JumpPower = jumpPower
end
   
end

createLoop(function()
    if getgenv().settings.JumpPower then task.wait(.3)
        setJumpPower(getgenv().settings.JP)  
    else   
        setJumpPower(50)  
        repeat task.wait() until getgenv().settings.JumpPower 
    end
end)   

local Toggle = Tabs.Player:AddToggle("Toggle", {
   Title = "Infinite Jump",
   Default = getgenv().settings.InfiJump or false,
   Callback = function(value)
       getgenv().settings.InfiJump = value
   end
})

local infJumpConnection
createLoop(function()
    if getgenv().settings.InfiJump then wait()
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            if connection.Connected then 
                localPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end 
        end)
        repeat task.wait() until getgenv().settings.InfiJump == false or connection.Connected == false
    else 
        infJumpConnection:Disconnect()
        repeat task.wait() until getgenv().settings.InfiJump == true or connection.Connected == false
    end
end)  

local KeyBindName = getgenv().settings.KeyBind or ""

local Keybind = Tabs.Settings:AddKeybind("Keybind", {
    Title = "KeyBind",
    Mode = "Toggle",
    Default = KeyBindName,
    ChangedCallback = function(New)
        KeyBindName = New.Name
        getgenv().settings.KeyBind = New.Name  
    end
})

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    local settingsKeyBind = getgenv().settings.KeyBind

    if input.KeyCode == Enum.KeyCode.Home or settingsKeyBind == input.KeyCode.Name then
        if game:GetService("Players").LocalPlayer.PlayerGui.nexus.Frame.Visible then
            Fluent:Notify({Title = 'Window Minimized', Content = 'Press ' .. settingsKeyBind .. ' to Open the UI', Duration = 5 })
        end
        Window:Minimize() 
    end
end)

local Toggle = Tabs.Settings:AddToggle("Toggle", {
    Title = "Auto Save Settings",
    Default = getgenv().settings.AutoSave,
    Callback = function(value)
        getgenv().settings.AutoSave = value
        writefile(fileName, HttpService:JSONEncode(getgenv().settings))
    end
})

local Toggle = Tabs.Settings:AddToggle("Toggle", {
   Title = "Auto Rejoin",
   Default = getgenv().settings.AutoRejoin,
   Callback = function(value)
      getgenv().settings.AutoRejoin = value
      if getgenv().settings.AutoRejoin then
          Fluent:Notify({Title = 'Auto Rejoin', Content = 'You will rejoin if you are kicked or disconnected from the game', Duration = 5 })
          repeat task.wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
          local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
          po.ChildAdded:connect(function(a)
              if a.Name == 'ErrorPrompt' then
                  while true do
                      ts:Teleport(game.PlaceId)
                      task.wait(2)
                  end
              end
          end)
      end
  end
})

local Toggle = Tabs.Settings:AddToggle("Toggle", {
    Title = "Auto ReExecute",
    Default = getgenv().settings.AutoExecute,
    Callback = function(value)
    getgenv().settings.AutoExecute = value
     if getgenv().settings.AutoExecute then
            local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
            if queueteleport then
                queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
            end
        end
    end
})
Tabs.Settings:AddButton({
    Title = "Rejoin-Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})
Tabs.Settings:AddButton({
    Title = "Server-Hop", 
    Callback = function()
       local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/"
        local _place,_id = game.PlaceId, game.JobId
        local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
        local function ListServers(cursor)
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
            return Http:JSONDecode(Raw)
        end
        local Next; repeat
            local Servers = ListServers(Next)
            for i,v in next, Servers.data do
                if v.playing < v.maxPlayers and v.id ~= _id then
                    local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
                    if s then break end
                end
            end
            Next = Servers.nextPageCursor
        until not Next
    end
})

task.spawn(function()
    while wait() do 
    if premium == "premium" then
        game.Players:Chat("nexus-premium")
        wait(10)
    else
        game.Players:Chat("nexus-is-back")
        wait(10)
    end
    end
end)

spawn(function()
    while wait() do
       if getgenv().Disconnect == true then wait(1)
           connection:Disconnect()
		    getgenv().Disconnect = false
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
            for i,v in next, game:GetService('Players'):GetPlayers() do
                if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                    pcall(function()
                        v.Character.Highlight:Destroy()
                    end)
                end 
            end
            return
       else  
            myEvent:Fire()
        end
    end
end)  

----------// PREMIUM \\----------
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Kick",
    Callback = function()
        game.Players:Chat(".k " .. getgenv().Selected)
    end 
})
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Kill",
    Callback = function()
        game.Players:Chat(". " .. getgenv().Selected)
    end
})
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Teleport",
    Callback = function()
        game.Players:Chat(".b " .. getgenv().Selected)
    end
})
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Shut Game Down",
    Callback = function()
        game.Players:Chat(".s " .. getgenv().Selected)
    end
})
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Freeze",
    Callback = function()
        game.Players:Chat("- " .. getgenv().Selected)
    end
})
Tab = premium == "premium" and Tabs.Premium:AddButton({
    Title = "Unfreeze",
    Callback = function()
        game.Players:Chat(".u " .. getgenv().Selected)
    end
})

task.spawn(function()
    while task.wait() do 
        local playersService = game:GetService("Players")
        local textChatService = game:GetService("TextChatService")
        local lplr = playersService.LocalPlayer
        local localPlayerNameWithoutUnderscores = lplr.Name:gsub("_", "")
        
        for _, player in ipairs(playersService:GetPlayers()) do
            player.Chatted:Connect(function(msg)
                local success, errorMessage = pcall(function()
                    local processedMsg = msg:gsub("_", "")
                    if processedMsg == ".k " .. localPlayerNameWithoutUnderscores then
                        game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
                    elseif processedMsg == ". " .. localPlayerNameWithoutUnderscores then
                        game.Players.LocalPlayer.Character.Humanoid.Health = 0
                    elseif processedMsg == ".b " .. localPlayerNameWithoutUnderscores then
                        game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[player.Name].Character.HumanoidRootPart.CFrame
                    elseif processedMsg == ".s " .. localPlayerNameWithoutUnderscores then
                        game:Shutdown()
                    elseif processedMsg == "- " .. localPlayerNameWithoutUnderscores then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                    elseif processedMsg == ".u " .. localPlayerNameWithoutUnderscores then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
                    end  
                end)
            end) 
        end
    end 
end)

local nexus = {}
local updatedPlayers = {} 
local Dropdown

local function UpdateDropdownValues()
    if Dropdown then
        Dropdown:SetValues(nexus)
    end
end
local function RemovePlayer(player)
    for i, playerName in ipairs(nexus) do
        if playerName == player.Name then
            table.remove(nexus, i)
            updatedPlayers[player] = nil
            UpdateDropdownValues()
            break
        end
    end
end

game.Players.PlayerRemoving:Connect(function(player)
    RemovePlayer(player)
end)

task.spawn(function()
    while wait() do 
        for _, player in ipairs(game.Players:GetPlayers()) do
            player.Chatted:Connect(function(msg)
                if msg == "nexus-is-back" and not updatedPlayers[player] then
                    if not table.find(nexus, player.Name) and player ~= game.Players.LocalPlayer then
                        local playerNameWithoutUnderscores = player.Name:gsub("_", "")
                        table.insert(nexus, playerNameWithoutUnderscores)
                        print("Detected:", playerNameWithoutUnderscores)
                        updatedPlayers[player] = true  
                        UpdateDropdownValues() 
                    end
                end  
            end) 
        end
    end
end)

Dropdown = premium == "premium" and Tabs.Premium:AddDropdown("Dropdown", {
    Title = "Select Nexus User",
    Values = nexus, 
    Multi = false,
    Default = "",
    Callback = function(value)
        getgenv().Selected = value
    end
})


Window:SelectTab(1)
