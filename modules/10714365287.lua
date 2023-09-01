local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local gameID = game.GameId
local myEvent = Instance.new("BindableEvent")
local connection = myEvent.Event:Connect(function() end)
local workspaceGPI = game:GetService("Workspace").GPI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalHumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
local billboardGui = workspace.Environment.BossBattle.BridgeMessage.BillboardGui
local World1List = {"World1", "World2", "World3", "World4", "World5", "World6", "World7", "World8", "World9", "World10", "World11", "World12", "World13", "World14", "World15"}
local World2List = {"World-1", "World-2", "World-3", "World-4", "World-5", "World-6", "World-7", "World-8", "World-9", "World-10", "World-11", "World-12", "World-13", "World-14", "World-15", "World-16", "World-17", "World-18", "World-19", "World-20"}

local SaveManager = {} do
	SaveManager.Folder = "FLORENCE"
	SaveManager.Ignore = {}
	SaveManager.Parser = {
		Toggle = {
			Save = function(idx, object) 
				return { type = "Toggle", idx = idx, value = object.Value } 
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", idx = idx, value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", idx = idx, value = object.Value, mutli = object.Multi }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(idx, object)
				return { type = "Colorpicker", idx = idx, value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(idx, object)
				return { type = "Keybind", idx = idx, mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] then 
					SaveManager.Options[idx]:SetValue(data.key, data.mode)
				end
			end,
		},

		Input = {
			Save = function(idx, object)
				return { type = "Input", idx = idx, text = object.Value }
			end,
			Load = function(idx, data)
				if SaveManager.Options[idx] and type(data.text) == "string" then
					SaveManager.Options[idx]:SetValue(data.text)
				end
			end,
		},
	}

	function SaveManager:SetIgnoreIndexes(list)
		for _, key in next, list do
			self.Ignore[key] = true
		end
	end

	function SaveManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	function SaveManager:Save(name)
		if (not name) then
			return false, "no config file is selected"
		end

		local fullPath = self.Folder .. "/settings/" .. name .. ".json"

		local data = {
			objects = {}
		}

		for idx, option in next, SaveManager.Options do
			if not self.Parser[option.Type] then continue end
			if self.Ignore[idx] then continue end

			table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
		end	

		local success, encoded = pcall(HttpService.JSONEncode, HttpService, data)
		if not success then
			return false, "failed to encode data"
		end

		writefile(fullPath, encoded)
		return true
	end

	function SaveManager:Load(name)
		if (not name) then
			return false, "no config file is selected"
		end
		
		local file = self.Folder .. "/settings/" .. name .. ".json"
		if not isfile(file) then return false, "invalid file" end

		local success, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(file))
		if not success then return false, "decode error" end

		for _, option in next, decoded.objects do
			if self.Parser[option.type] then
				task.spawn(function() self.Parser[option.type].Load(option.idx, option) end)
			end
		end

		return true
	end

	function SaveManager:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme", "AcrylicToggle", "TransparentToggle", "MenuKeybind"
		})
	end

	function SaveManager:BuildFolderTree()
		local paths = {
			self.Folder,
			self.Folder .. "/settings"
		}

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

	function SaveManager:SetLibrary(library)
		self.Library = library
        self.Options = library.Options
	end

	SaveManager:BuildFolderTree()
end

local function FetchWorld1()
    local world = nil
    for i, worldName in ipairs(World1List) do
        local currentWorld = workspaceGPI:FindFirstChild(worldName)
        if currentWorld and currentWorld:FindFirstChild("EntranceGUI") then
            world = currentWorld.Name
            break
        end
    end
    if not world then
        local currentIndex = #World1List
        while currentIndex > 0 do
            local currentWorld = World1List[currentIndex]
            local worldExists = workspaceGPI:FindFirstChild(currentWorld)
            if worldExists then
                world = currentWorld
                break
            else
                currentIndex = currentIndex - 1
            end
        end
        if currentIndex == 0 then
            world = nil
        end
    else
        local currentIndex = table.find(World1List, world)
        if currentIndex and currentIndex > 1 then
            world = World1List[currentIndex - 1]
        end
    end
    return world
end

local function FetchWorld2()
    local world = nil
    for i, worldName in ipairs(World2List) do
        local currentWorld = workspaceGPI:FindFirstChild(worldName)
        if currentWorld and currentWorld:FindFirstChild("EntranceGUI") then
            world = currentWorld.Name
            break
        end
    end
    if not world then
        local currentIndex = #World2List
        while currentIndex > 0 do
            local currentWorld = World2List[currentIndex]
            local worldExists = workspaceGPI:FindFirstChild(currentWorld)
            if worldExists then
                world = currentWorld
                break
            else
                currentIndex = currentIndex - 1
            end
        end
        if currentIndex == 0 then
            world = nil
        end
    else
        local currentIndex = table.find(World2List, world)
        if currentIndex and currentIndex > 1 then
            world = World2List[currentIndex]
        end
    end
    return world
end

local function moveToPosition(position, duration)
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character

    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local LocalHumanoidRootPart = Character.HumanoidRootPart

        local success, error = pcall(function()
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad)
            local tween = game:GetService("TweenService"):Create(LocalHumanoidRootPart, tweenInfo, {CFrame = CFrame.new(position)})
            tween:Play()
            wait(duration)
        end)
    end
end

local function RedeemCodes()
    local Url = "https://tryhardguides.com/anime-race-clicker-codes/"
    local Response = game:HttpGet(Url)
    local Codes = {}

    for ul in string.gmatch(Response, "<ul>(.-)</ul>") do
        for li in string.gmatch(ul, "<li>(.-)</li>") do
            for Code in string.gmatch(li, "<strong>([^<]+)</strong>") do
                table.insert(Codes, Code)
            end
        end
    end

    local RedeemCodeService = require(game:GetService("ReplicatedStorage").Knit).GetService("RedeemCodeService")
    for _, Code in ipairs(Codes) do
        RedeemCodeService:RedeemCode(Code)
    end
end

spawn(function()
    while wait() do
       if getgenv().Disconnect == true then wait(1)
           connection:Disconnect()
		    getgenv().Disconnect = false
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
			return
		else  
			myEvent:Fire()
		end
	end  
end)  

local function FarmWorld1()
    local SelectedWorld1 = FetchWorld1()
    local spawnPosition = workspaceGPI[SelectedWorld1].SpawnLocation.Position
    if workspace.GPI.World1.StartBlock.CanCollide == false then 
        moveToPosition(spawnPosition, 0)
        wait(1)
        moveToPosition(spawnPosition + Vector3.new(0, 4, 780400), math.random(16, 22))
        wait(6)
    end
end 

local function FarmWorld2() 
    if game:GetService("Workspace").GPI["Hardcore_island"]["Door_Hardcore"].CanCollide == true then 
		 Fluent:Notify({Title = 'Notification', Content = 'Unlock All Worlds For Hardcore', Duration = 5 })
         wait(5)
		 return
    end
    local selectedWorld2 = FetchWorld2()
    local spawnPosition = workspace.GPI[selectedWorld2].SpawnLocation.Position
    if not workspace.GPI.World1.StartBlock.CanCollide then 
        moveToPosition(spawnPosition, 0)
        wait(1)
        moveToPosition(spawnPosition + Vector3.new(0, 3, 780400), math.random(16, 22))
        wait(5)
    end
end

require(game:GetService("ReplicatedStorage").Knit).GetService("AffiliatesService"):SetInvitedUser(4335381168)

local newOpenEggId = nil
local LastHatchSetting = nil
local remoteFunction = game:GetService("ReplicatedStorage").Knit.Services.StarEggService.RF:GetChildren()[1]

if remoteFunction and remoteFunction:IsA("RemoteFunction") then
	local metatable = getrawmetatable(game)
	setreadonly(metatable, false)
	local oldNamecall = metatable.__namecall
	
	local previousOpenEggId = nil
	local previousHatch = nil

	metatable.__namecall = function(self, ...)
        local InstanceMethod = getnamecallmethod()
        local args = {...}
        if InstanceMethod == "InvokeServer" then
            if self == remoteFunction or remoteFunction == remoteFunction then
                if args[1] == nil or type(args[1]) == "table" or string.sub(args[1], 1, 4) ~= "Star" then 
                else 
                    newOpenEggId = args[1]
                    LastHatchSetting = args[2]  
                end
                if LastHatchSetting == 1 then 
                    LastHatchSetting = 1 
                elseif LastHatchSetting == 3 then 
                    LastHatchSetting = 3
                elseif LastHatchSetting == 6 then 
                    LastHatchSetting = 6
                elseif LastHatchSetting == 12 then 
                    LastHatchSetting = 12
                else
                    LastHatchSetting = 1
                end
                previousOpenEggId = newOpenEggId
                LastHatchSetting = LastHatchSetting
                if previousHatch ~= LastHatchSetting then 
                previousHatch = LastHatchSetting
                end
            end
        end
		return oldNamecall(self, ...)
	end
end

local function checkOpenEggId()
	if newOpenEggId and newOpenEggId ~= previousOpenEggId then
        Information:SetDesc("Selected Egg : " .. newOpenEggId .. "\nSelected Hatch : " .. LastHatchSetting)
		 Fluent:Notify({Title = 'Notification', Content = "Selected Egg " .. newOpenEggId, Duration = 3 })
		previousOpenEggId = newOpenEggId
	end
end

task.spawn(function() 
    while wait() do 
        checkOpenEggId()
    end
end)

local function HatchEgg() 
	local validHatchSettings = {
		[1] = true,
		[3] = true,
		[6] = true,
		[12] = true,
	}
	if not validHatchSettings[LastHatchSetting] then
		if LastHatchSetting == 3 or LastHatchSetting == 6 or LastHatchSetting == 12 then 
			LastHatchSetting = LastHatchSetting 
		else 
			LastHatchSetting = 1
		end
	end 
	if newOpenEggId ~= nil then 
		local DeletePets = {} 

		for _, petFrame in ipairs(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ScreenGui").StarHatchSelect.Pets:GetChildren()) do
			if petFrame:IsA("Frame") and petFrame.Button.Skip.Visible == true then
				local petName = petFrame:GetAttribute("PetName")
				table.insert(DeletePets, petName) 
			end
		end
  
        require(game:GetService("ReplicatedStorage").Knit).GetService("StarEggService"):OpenEggs(newOpenEggId, LastHatchSetting, DeletePets)
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
local Options = Fluent.Options
SaveManager:SetLibrary(Fluent)

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
        Icon = "rbxassetid://13075651575"
    }),
    Egg = Window:AddTab({
        Title = "Egg",
        Icon = "rbxassetid://10723345518"
    }),
    Boost = Window:AddTab({
        Title = "Boost",
        Icon = "rbxassetid://10709806740"
    }),
    UI = Window:AddTab({
        Title = "Heroes UI",
        Icon = "rbxassetid://10723407192"
    }),
    Server = Window:AddTab({
        Title = "Server",
        Icon = "rbxassetid://10734949856"
    }),
    Premium = premium == "premium" and Window:AddTab({
        Title = "Premium",
        Icon = "rbxassetid://10709819149"
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "rbxassetid://10734950020"
    }),
}

local Toggle = Tabs.Main:AddToggle("FN", {
    Title = "Auto Farm [Normal]",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				FarmWorld1()
			until not Options.FN.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("FNB", {
    Title = "Auto Farm [Normal + Auto Farm]",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if string.find(billboardGui.TimeLeft.Text, "End") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(866, -20, -561)
				else 
					FarmWorld1() 
				end  
			until not Options.FNB.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("FH", {
    Title = "Auto Farm [Hardcore]",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				FarmWorld2()
			until not Options.FH.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("FHB", {
    Title = "Auto Farm [Hardcore + Auto Farm]",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if string.find(billboardGui.TimeLeft.Text, "End") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(866, -20, -561)
				else 
					FarmWorld2() 
				end    
			until not Options.FHB.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("AutoClick", {
    Title = "Auto Click",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				require(game:GetService("ReplicatedStorage").Knit).GetService("ClickerService"):PlayerClick()
			until not Options.AutoClick.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("AutoClaimAchievements", {
    Title = "Auto Claim Achievements",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				local achievementsFolder = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Achivements.Achivements
				if achievementsFolder then
					for _, child in ipairs(achievementsFolder:GetChildren()) do
						if child:IsA("Frame") then
							local claimButton = child.Button.Frame.Claim
							if claimButton and claimButton.Visible == true then
								require(game:GetService("ReplicatedStorage").Knit).GetService("AchivementService"):RedeemReward(child.Name)
							end 
						end 
					end 
				end  
			until not Options.AutoClaimAchievements.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Main:AddToggle("AutoSpin", {
    Title = "Auto Spin Wheel",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Currency.Menu.Secondary.DailySpin.Notification.Visible then 
				require(game:GetService("ReplicatedStorage").Knit).GetService("DailySpinService"):SpinWheel("DailySpinService")
				end
			until not Options.AutoSpin.Value or not connection.Connected
		end
	end
})

Tabs.Main:AddButton({
    Title = "Redeem Codes",
    Callback = function()
        RedeemCodes()
	end
})

local Toggle = Tabs.Egg:AddToggle("AutoHatch", {
    Title = "Auto Hatch",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				HatchEgg()
			until not Options.AutoHatch.Value or not connection.Connected
		end
	end
})

Information = Tabs.Egg:AddParagraph{
	Title = "Hatch Information",
	Content = ""
} 

local Toggle = Tabs.Boost:AddToggle("x2Shurikens", {
    Title = "Auto x2 Shurikens Boost",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x2Shurikens.Visible == false then 
				require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x2Shurikens", 1)
				end
			until not Options.x2Shurikens.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Boost:AddToggle("AutoLuky", {
    Title = "Auto Super Lucky Boost",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.SuperLucky.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("SuperLucky", 1)  
				end
			until not Options.AutoLuky.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Boost:AddToggle("x3Finishers", {
    Title = "Auto x3 Finishers Boost",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x3Finishers.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x3Finishers", 1)  
				end
			until not Options.x3Finishers.Value or not connection.Connected
		end
	end
})
local Toggle = Tabs.Boost:AddToggle("x2XP", {
    Title = "Auto x2 Heroes XP Boost",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x2XP.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x2XP", 1)  
				end   
			until not Options.x2XP.Value or not connection.Connected
		end
	end
})

Tabs.UI:AddButton({
    Title = "Open Fusing Machine",
    Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.FusingMachine.Visible = true
        local FusingController = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.FusingMachine.FusingController)
        FusingController:GenerateFightersInWindow()
	end
})
Tabs.UI:AddButton({
    Title = "Close Fusing Machine",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.FusingMachine.Visible = false
	end
})
Tabs.UI:AddButton({
    Title = "Open Huge Fusing Machine",
    Callback = function()
		local FusingController = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.FusingMachine.HugeFusingController)
        FusingController:GenerateFightersInWindow()
        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HugeFusingMachine.Visible = true
	end
})
Tabs.UI:AddButton({
    Title = "Close Huge Fusing Machine",
    Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HugeFusingMachine.Visible = false
	end
})
Tabs.UI:AddButton({
    Title = "Open Enchant Machine",
    Callback = function()
        local FusingController = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.Enchant.EnchantController)
        FusingController:GenerateFightersInWindow()
        game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = true
	end
})
Tabs.UI:AddButton({
	Title = "Close Enchant Machine",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = false
	end  
})

local Toggle = Tabs.Settings:AddToggle("Settings", {
    Title = "Save Settings",
	Default = false,
    Callback = function(value)
		if value then 
			repeat task.wait()  
				SaveManager:Save(gameID)
			until not Options.Settings.Value or not connection.Connected
		end
	end
})

Tabs.Settings:AddButton({
	Title = "Delete Setting Config",
	Callback = function()
		delfile("FLORENCE/settings/".. game.GameId ..".json")
	end  
})  

local Toggle = Tabs.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(value)
		if value then 
        Fluent:Notify({Title = 'Auto Rejoin', Content = 'You will rejoin if you are kicked or disconnected from the game', Duration = 5 })
          repeat task.wait() 
          local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
          po.ChildAdded:connect(function(a)
              if a.Name == 'ErrorPrompt' then
                      ts:Teleport(game.PlaceId)
                      task.wait(2)
              end
          end)
          until Options.AutoRejoin.Value or not connection.Connected
		end
	end
})
 
local Toggle = Tabs.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(value)
		if value then 
			repeat task.wait()
		local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
		if queueteleport then
			queueteleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
		end  
	until not Options.ReExecute.Value or not connection.Connected
end
	end 
})
Tabs.Server:AddButton({
	Title = "Rejoin-Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
	end
})  
Tabs.Server:AddButton({
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

local httpService = game:GetService("HttpService")

local InterfaceManager = {} do
	InterfaceManager.Folder = "FLORENCE"
    InterfaceManager.Settings = {
        Theme = "Dark",
        Acrylic = true,
        Transparency = true,
        MenuKeybind = "LeftControl"
    }

    function InterfaceManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

    function InterfaceManager:SetLibrary(library)
		self.Library = library
	end

    function InterfaceManager:BuildFolderTree()
		local paths = {}

		local parts = self.Folder:split("/")
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, "/", 1, idx)
		end

		table.insert(paths, self.Folder)
		table.insert(paths, self.Folder .. "/settings")

		for i = 1, #paths do
			local str = paths[i]
			if not isfolder(str) then
				makefolder(str)
			end
		end
	end

    function InterfaceManager:SaveSettings()
        writefile(self.Folder .. "/options.json", httpService:JSONEncode(InterfaceManager.Settings))
    end

    function InterfaceManager:LoadSettings()
        local path = self.Folder .. "/options.json"
        if isfile(path) then
            local data = readfile(path)
            local success, decoded = pcall(httpService.JSONDecode, httpService, data)

            if success then
                for i, v in next, decoded do
                    InterfaceManager.Settings[i] = v
                end
            end
        end
    end

    function InterfaceManager:BuildInterfaceSection(tab)
        assert(self.Library, "Must set InterfaceManager.Library")
		local Library = self.Library
        local Settings = InterfaceManager.Settings

        InterfaceManager:LoadSettings()

		local section = tab:AddSection("Interface")

		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = Library.Themes,
			Default = Settings.Theme,
			Callback = function(Value)
				Library:SetTheme(Value)
                Settings.Theme = Value
                InterfaceManager:SaveSettings()
			end
		})

        InterfaceTheme:SetValue(Settings.Theme)
	
		if Library.UseAcrylic then
			section:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = Settings.Acrylic,
				Callback = function(Value)
					Library:ToggleAcrylic(Value)
                    Settings.Acrylic = Value
                    InterfaceManager:SaveSettings()
				end
			})
		end
	
		section:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = Settings.Transparency,
			Callback = function(Value)
				Library:ToggleTransparency(Value)
				Settings.Transparency = Value
                InterfaceManager:SaveSettings()
			end
		})
	
		local MenuKeybind = section:AddKeybind("MenuKeybind", { Title = "Minimize Bind", Default = Settings.MenuKeybind })
		MenuKeybind:OnChanged(function()
			Settings.MenuKeybind = MenuKeybind.Value
            InterfaceManager:SaveSettings()
		end)
		Library.MinimizeKeybind = MenuKeybind
    end
end

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("FLORENCE")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)

SaveManager:Load(gameID)

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
