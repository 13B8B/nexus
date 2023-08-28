if getgenv().nexus then return end 
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local virtualUser = game:GetService("VirtualUser")
local LocalPlayer, localPlayer = Players.LocalPlayer, Players.LocalPlayer
local gameID = game.GameId
local fileName = "FLORENCE/SETTINGS/" .. gameID .. '.txt'
local UserInputService = game:GetService("UserInputService")
local highlights = {} 

getgenv().nexus = true
getgenv().settings = {}

if isfile("FLORENCE/SETTINGS/" .. gameID .. '.txt') then
    local sl, er = pcall(function()
        getgenv().settings = game:GetService('HttpService'):JSONDecode(readfile("FLORENCE/SETTINGS/" .. gameID .. '.txt'))
    end)
    if er ~= nil then
        forceServerHop()
        return
    end
end 
writefile("FLORENCE/SETTINGS/" .. gameID .. '.txt', HttpService:JSONEncode(getgenv().settings))

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
    Emotes = Window:AddTab({
        Title = "Emotes",
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

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Auto Farm",
    Default = getgenv().settings.AutoFarm,
    Callback = function(value)
	getgenv().settings.AutoFarm = value
    end
})

local function FindMap()
    for _, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("CoinContainer") then
            return v.CoinContainer
        elseif v:FindFirstChild("Map") then
            if pcall(function() local view = v.Map.CoinContainer end) then
                return v.Map.CoinContainer
            end
        end
    end
    return nil
end

createLoop(function()
    local Map = FindMap()

    if Map and getgenv().settings.AutoFarm then
        local function tween_teleport(TargetFrame)
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                
                local distance = (humanoidRootPart.Position - TargetFrame.p).Magnitude
                local tweenInfo = TweenInfo.new(distance / 70, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
                
                local move = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = TargetFrame})
                move:Play()
                move.Completed:Wait()
                
            end
        end

        if Map and game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game.Timer.Visible == true or game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game.CashBag.Visible == true then 
            
            local minimum_distance = math.huge
            local minimum_object = nil
            
            local player = game.Players.LocalPlayer
            local character = player.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            local playerPosition = humanoidRootPart.Position
            
            for _, v in pairs(Map:GetChildren()) do
                if v.Name == 'Coin_Server' then
                    local coinPosition = v.Coin.Position
                    local distance = (playerPosition - coinPosition).Magnitude
                    
                    if distance < minimum_distance then
                        minimum_distance = distance
                        minimum_object = v
                    end
                end
            end
        
            if minimum_object then
                tween_teleport(CFrame.new(minimum_object.Coin.CFrame.p))
        
                for rotation = 0, 10, 1 do
                    character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(rotation), 0))
                    wait(0.02)
                end
                        
                minimum_object.Name = 'False_Coin'
                
                repeat
                    wait()
                until minimum_object.Name ~= 'Coin_Server'
                wait(1)
            end
        end
    end
end)

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "X-RAY",
    Default = getgenv().settings.CoinChams,
    Callback = function(Value)
        module:xray(Value)
    end
})

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Coin Chams",
    Default = getgenv().settings.CoinChams,
    Callback = function(value)
	getgenv().settings.CoinChams = value
    end
})

createLoop(function()
    local Map = FindMap()

    if Map and getgenv().settings.CoinChams then
        for _, v in pairs(Map:GetChildren()) do
            if v.Name == 'Coin_Server' and not highlights[v] then
                local esp = Instance.new("Highlight")
                esp.Name = "EspPareet"
                esp.FillTransparency = 0.5
                esp.FillColor = Color3.new(94/255, 1, 255/255)
                esp.OutlineColor = Color3.new(94/255, 1, 255/255)
                esp.OutlineTransparency = 0
                esp.Parent = v.Parent
                highlights[v] = esp  
            end
        end
    else 
        function ClearHighlights()
            for _, highlight in pairs(highlights) do
                highlight:Destroy()
            end
            highlights = {} 
        end  
        ClearHighlights()
    end
end)

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Player ESP",
    Default = getgenv().settings.ESP,
    Callback = function(value)
	getgenv().settings.ESP = value
    end
})

createLoop(function()
    if not getgenv().settings.ESP then
        for i,v in next, game:GetService('Players'):GetPlayers() do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    v.Character.Highlight:Destroy()
                end)
            end 
        end
    else
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()

        function CreateHighlight()
            for _, v in pairs(Players:GetChildren()) do
                if v ~= localPlayer and v.Character and not v.Character:FindFirstChild("Highlight") then
                    Instance.new("Highlight", v.Character)
                end
            end
        end

        function UpdateHighlights() 
            for _, v in pairs(Players:GetChildren()) do
                local highlight = v.Character and v.Character:FindFirstChild("Highlight")
                if v ~= localPlayer and highlight then
                    if IsAlive(v) then
                        if v.Name == Sheriff then 		
                            highlight.FillColor = Color3.fromRGB(0, 0, 225)
                        elseif v.Name == Murder then 
                            highlight.FillColor = Color3.fromRGB(225, 0, 0) 
                        elseif v.Name == Hero and not IsAlive(Players:WaitForChild(Sheriff)) then
                            highlight.FillColor = Color3.fromRGB(0, 0, 225)
                        else 
                            highlight.FillColor = Color3.fromRGB(76, 215, 134) 
                        end
                    else
                        highlight.FillColor = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end

        function IsAlive(Player)
            local role = roles[Player.Name]
            return role and not role.Killed and not role.Dead
        end  

        Sheriff, Murder, Hero = nil, nil, nil
        for i, v in pairs(roles) do
            if v.Role == "Murderer" then
                Murder = i
            elseif v.Role == 'Sheriff' then
                Sheriff = i
            elseif v.Role == 'Hero' then
                Hero = i
            end
        end  
        if connection.Connected == true and getgenv().settings.ESP then 
        CreateHighlight()
        UpdateHighlights()
        end

    end
end)

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Automatically Grab Gun",
    Default = getgenv().settings.AutoGrab,
    Callback = function(value)
        getgenv().settings.AutoGrab = value
    end
})

createLoop(function()
    local myPlayer = Players.LocalPlayer
    local myCharacter = myPlayer.Character
    local myRootPart = myCharacter:WaitForChild("HumanoidRootPart")
    
    
    local murdererPlayer = GetMurderer()
    local gunDrop = Workspace:FindFirstChild("GunDrop")
    local cashBag = game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game.CashBag.Visible == true
    
    if gunDrop and murdererPlayer and cashBag and getgenv().settings.AutoGrab then
        local murdererCharacter = murdererPlayer.Character
        local murdererRootPart = murdererCharacter:WaitForChild("HumanoidRootPart")
            
        local gunDropPosition = gunDrop.Position
      
        local distanceToGunDrop = (murdererRootPart.Position - gunDropPosition).Magnitude
        local player = game.Players.LocalPlayer
    
        if distanceToGunDrop > 10 then

            if game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Game.Timer.Visible == false then 
                local savedPosition = player.Character.HumanoidRootPart.CFrame
                wait(.5)
                player.Character.HumanoidRootPart.CFrame = gunDrop.CFrame
                player.Character.Humanoid.Jump = true
                wait(.3)
                player.Character.HumanoidRootPart.CFrame = savedPosition
            end  
        end
    end  
end)

local Toggle = Tabs.Main:AddToggle("Toggle", {
    Title = "Gun Dropped Chams",
    Default = getgenv().settings.GunChams,
    Callback = function(value)
	getgenv().settings.GunChams = value
    end
})

createLoop(function()
    local gunDrop = game:GetService("Workspace"):FindFirstChild("GunDrop")
    local esp = gunDrop:FindFirstChild("GunESP")

    if gunDrop and getgenv().settings.GunChams == false then
        esp:Destroy()  
    else 
        local gunDrop = game:GetService("Workspace"):FindFirstChild("GunDrop")

        if not esp then
            esp = Instance.new("Highlight")
            esp.Name = "GunESP"
            esp.FillTransparency = 0.5
            esp.FillColor = Color3.new(94, 1, 255)
            esp.OutlineColor = Color3.new(94, 1, 255)
            esp.OutlineTransparency = 0
            esp.Parent = gunDrop
        end
    end
end)

local Toggle = Tabs.Misc:AddToggle("Toggle", {
    Title = "Kill Aura",
    Default = false,
    Callback = function(value)
        getgenv().settings.KillAura = value
    end
})

createLoop(function()
    local Knife = localPlayer.Backpack:FindFirstChild("Knife") or localPlayer.Character:FindFirstChild("Knife")
    for i, v in ipairs(Players:GetPlayers()) do
        if v ~= localPlayer and v.Character ~= nil and getgenv().settings.KillAura then
            local EnemyRoot = v.Character.HumanoidRootPart
            local EnemyPosition = EnemyRoot.Position
            local Distance = (EnemyPosition - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            if (Distance <= 25) then
                firetouchinterest(EnemyRoot, Knife.Handle, 1)
                firetouchinterest(EnemyRoot, Knife.Handle, 0)
            end
        end  
    end
end)

Tabs.Misc:AddButton({
    Title = "Kill All",
    Callback = function()
        local myKnife = localPlayer.Backpack:FindFirstChild("Knife") or localPlayer.Character:FindFirstChild("Knife")
        if myKnife and myKnife:IsA("Tool") then
            local character = localPlayer.Character
            local humanoid = character:WaitForChild("Humanoid")
            humanoid:EquipTool(myKnife)
            
            for _ = 1, 3 do
                for i, v in ipairs(Players:GetPlayers()) do
                    if v ~= localPlayer and v.Character then
                        local enemyRoot = v.Character:WaitForChild("HumanoidRootPart")
                        local enemyPosition = enemyRoot.Position

                        virtualUser:ClickButton1(Vector2.new())

                        firetouchinterest(enemyRoot, myKnife.Handle, 1)
                        wait(0.1)
                        firetouchinterest(enemyRoot, myKnife.Handle, 0)
                    end
                end
            end
        end
    end
})

local Toggle = Tabs.Misc:AddToggle("Toggle", {
    Title = "Silent Aim",
    Default = false,
    Callback = function(value)
	getgenv().settings.SheriffAim = value
    end
})

local Slider = Tabs.Misc:AddSlider("Slider", {
    Title = "Accuracy",
    Default = getgenv().settings.GunAccuracy or 0,
    Min = 25,
    Max = 100,
    Rounding = 1,
    Callback = function(value)
        getgenv().settings.GunAccuracy = value
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
    if getgenv().settings.Walkspeed then task.wait(.3)
        setWalkSpeed(getgenv().settings.WS)  
    else
        setWalkSpeed(16)
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

Tabs.Emotes:AddButton({
    Title = "Ninja",
    Callback = function()
        module:emote("ninja")
    end
})

Tabs.Emotes:AddButton({
    Title = "Dab",
    Callback = function()
        module:emote("dab")
    end
})

Tabs.Emotes:AddButton({
    Title = "Floss",
    Callback = function()
        module:emote("floss")
    end
})

Tabs.Emotes:AddButton({
    Title = "Headless",
    Callback = function()
        module:emote("headless")
    end
})

Tabs.Emotes:AddButton({
    Title = "Zen",
    Callback = function()
        module:emote("zen")
    end
})

Tabs.Emotes:AddButton({
    Title = "Zombie",
    Callback = function()
        module:emote("zombie")
    end
}) 

Tabs.Emotes:AddButton({
    Title = "Sit",
    Callback = function()
        module:emote("sit")
    end
})

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
                queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/NEXUS/main/loadstring"))()')
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

local Murderer, Sheriff, CanGrab = nil, nil, false

function GetMurderer()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
            return v.Name
        end
    end
    return nil
end

function GetSheriff()
    for i,v in pairs(Players:GetChildren()) do 
        if v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun")) and v.Name == "Tool" then
            return v.Name
        end
    end
    return nil
end

coroutine.wrap(function()
    while true do
        task.wait(.5)
        local success, err = pcall(function()
            Murderer = GetMurderer()
            Sheriff = GetSheriff()
            if Murderer then
            end
        end)
    end
end)()

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

local GunHook
GunHook = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }
    if not checkcaller() then
        if typeof(self) == "Instance" then
            if self.Name == "ShootGun" and method == "InvokeServer" then
                if getgenv().settings.SheriffAim and getgenv().settings.GunAccuracy then 
                    if Murderer then
                        local Root = workspace[tostring(Murderer)].HumanoidRootPart;
                        local Veloc = Root.AssemblyLinearVelocity;
                        local Pos = Root.Position 
                        args[2] = Pos;
                    end;
                else
                    return GunHook(self, unpack(args));
                end;
            end;
        end;
    end;
    return GunHook(self, unpack(args));
end);

local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }
    if not checkcaller() then
        if tostring(method) == "InvokeServer" and tostring(self) == "GetChance" then
            wait(13)
            local success, err = pcall(function()
                Murderer = GetMurderer()
                Sheriff = GetSheriff()
            end)
            if not success then
                warn("Error: " .. err)
            end
            CanGrab = true
        end
    end
    return __namecall(self, unpack(args))
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
