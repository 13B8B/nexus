local L_1_ = game:GetService("HttpService")
local L_2_ = game:GetService("TeleportService")
local L_3_ = game.GameId
local L_4_ = Instance.new("BindableEvent")
local L_5_ = L_4_.Event:Connect(function()
end)
local L_6_ = game.ReplicatedStorage
local L_7_ = game:GetService("Players")
local L_8_ = game:GetService("RunService")
local L_9_ = game:GetService("Workspace").areaCircles
local L_10_ = {
	{
		position = Vector3.new(-9684.84, 55.6854, 3093.3),
		name = "City"
	},
	{
		position = Vector3.new(-13097, 213.621, 5913.35),
		name = "Legends Highway"
	},
	{
		position = Vector3.new(-11053.1, 213.621, 4904.36),
		name = "Magma City"
	},
	{
		position = Vector3.new(-11040.2539, 55.6208916, 4068.81079),
		name = "Snow City"
	}
}
if L_9_ then
	for L_37_forvar1, L_38_forvar2 in ipairs(L_9_:GetDescendants()) do
		if L_38_forvar2.Name == "areaCircle" then
			local L_39_ = L_38_forvar2:FindFirstChild("circleOuter")
			if L_39_ then
				for L_40_forvar1, L_41_forvar2 in ipairs(L_10_) do
					local L_42_ = (L_39_.Position - L_41_forvar2.position).Magnitude
					if L_42_ <= 50 then
						L_39_.Parent.Name = L_41_forvar2.name
					end
				end
			end
		end
	end
end

local L_11_ = {}
do
	L_11_.Folder = "FLORENCE"
	L_11_.Ignore = {}
	L_11_.Parser = {
		Toggle = {
			Save = function(L_43_arg1, L_44_arg2) 
				return {
					type = "Toggle",
					idx = L_43_arg1,
					value = L_44_arg2.Value
				} 
			end,
			Load = function(L_45_arg1, L_46_arg2)
				if L_11_.Options[L_45_arg1] then 
					L_11_.Options[L_45_arg1]:SetValue(L_46_arg2.value)
				end
			end,
		},
		Slider = {
			Save = function(L_47_arg1, L_48_arg2)
				return {
					type = "Slider",
					idx = L_47_arg1,
					value = tostring(L_48_arg2.Value)
				}
			end,
			Load = function(L_49_arg1, L_50_arg2)
				if L_11_.Options[L_49_arg1] then 
					L_11_.Options[L_49_arg1]:SetValue(L_50_arg2.value)
				end
			end,
		},
		Dropdown = {
			Save = function(L_51_arg1, L_52_arg2)
				return {
					type = "Dropdown",
					idx = L_51_arg1,
					value = L_52_arg2.Value,
					mutli = L_52_arg2.Multi
				}
			end,
			Load = function(L_53_arg1, L_54_arg2)
				if L_11_.Options[L_53_arg1] then 
					L_11_.Options[L_53_arg1]:SetValue(L_54_arg2.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(L_55_arg1, L_56_arg2)
				return {
					type = "Colorpicker",
					idx = L_55_arg1,
					value = L_56_arg2.Value:ToHex(),
					transparency = L_56_arg2.Transparency
				}
			end,
			Load = function(L_57_arg1, L_58_arg2)
				if L_11_.Options[L_57_arg1] then 
					L_11_.Options[L_57_arg1]:SetValueRGB(Color3.fromHex(L_58_arg2.value), L_58_arg2.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(L_59_arg1, L_60_arg2)
				return {
					type = "Keybind",
					idx = L_59_arg1,
					mode = L_60_arg2.Mode,
					key = L_60_arg2.Value
				}
			end,
			Load = function(L_61_arg1, L_62_arg2)
				if L_11_.Options[L_61_arg1] then 
					L_11_.Options[L_61_arg1]:SetValue(L_62_arg2.key, L_62_arg2.mode)
				end
			end,
		},

		Input = {
			Save = function(L_63_arg1, L_64_arg2)
				return {
					type = "Input",
					idx = L_63_arg1,
					text = L_64_arg2.Value
				}
			end,
			Load = function(L_65_arg1, L_66_arg2)
				if L_11_.Options[L_65_arg1] and type(L_66_arg2.text) == "string" then
					L_11_.Options[L_65_arg1]:SetValue(L_66_arg2.text)
				end
			end,
		},
	}

	function L_11_:SetIgnoreIndexes(L_67_arg1)
		for L_68_forvar1, L_69_forvar2 in next, L_67_arg1 do
			self.Ignore[L_69_forvar2] = true
		end
	end

	function L_11_:SetFolder(L_70_arg1)
		self.Folder = L_70_arg1;
		self:BuildFolderTree()
	end

	function L_11_:Save(L_71_arg1)
		if (not L_71_arg1) then
			return false, "no config file is selected"
		end

		local L_72_ = self.Folder.."/settings/"..L_71_arg1..".json"

		local L_73_ = {
			objects = {}
		}

		for L_76_forvar1, L_77_forvar2 in next, L_11_.Options do
			if not self.Parser[L_77_forvar2.Type] then
				continue
			end
			if self.Ignore[L_76_forvar1] then
				continue
			end

			table.insert(L_73_.objects, self.Parser[L_77_forvar2.Type].Save(L_76_forvar1, L_77_forvar2))
		end	

		local L_74_, L_75_ = pcall(L_1_.JSONEncode, L_1_, L_73_)
		if not L_74_ then
			return false, "failed to encode data"
		end

		writefile(L_72_, L_75_)
		return true
	end

	function L_11_:Load(L_78_arg1)
		if (not L_78_arg1) then
			return false, "no config file is selected"
		end

		local L_79_ = self.Folder.."/settings/"..L_78_arg1..".json"
		if not isfile(L_79_) then
			return false, "invalid file"
		end

		local L_80_, L_81_ = pcall(L_1_.JSONDecode, L_1_, readfile(L_79_))
		if not L_80_ then
			return false, "decode error"
		end

		for L_82_forvar1, L_83_forvar2 in next, L_81_.objects do
			if self.Parser[L_83_forvar2.type] then
				task.spawn(function()
					self.Parser[L_83_forvar2.type].Load(L_83_forvar2.idx, L_83_forvar2)
				end)
			end
		end

		return true
	end

	function L_11_:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme",
			"AcrylicToggle",
			"TransparentToggle",
			"MenuKeybind"
		})
	end

	function L_11_:BuildFolderTree()
		local L_84_ = {
			self.Folder,
			self.Folder.."/settings"
		}

		for L_85_forvar1 = 1, #L_84_ do
			local L_86_ = L_84_[L_85_forvar1]
			if not isfolder(L_86_) then
				makefolder(L_86_)
			end
		end
	end

	function L_11_:SetLibrary(L_87_arg1)
		self.Library = L_87_arg1
		self.Options = L_87_arg1.Options
	end

	L_11_:BuildFolderTree()
end

spawn(function()
	while wait() do
		if getgenv().Disconnect == true then
			wait(1)
			L_5_:Disconnect()
			getgenv().Disconnect = false
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
			return
		else  
			L_4_:Fire()
		end
	end  
end)  

local function L_12_func()
	local L_88_ = "https://tryhardguides.com/legends-of-speed-codes"
	local L_89_ = game:HttpGet(L_88_)
	local L_90_ = {}

	for L_91_forvar1 in string.gmatch(L_89_, "<ul>(.-)</ul>") do
		for L_92_forvar1 in string.gmatch(L_91_forvar1, "<li>(.-)</li>") do
			for L_93_forvar1 in string.gmatch(L_92_forvar1, "<strong>([^<]+)</strong>") do
				table.insert(L_90_, L_93_forvar1)
			end
		end
	end

	for L_94_forvar1, L_95_forvar2 in ipairs(L_90_) do
		local L_96_ = {
			[1] = L_95_forvar2
		}
		game:GetService("ReplicatedStorage").rEvents.codeRemote:InvokeServer(unpack(L_96_))
	end 
end

local L_13_ = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
local L_14_ = L_13_.Options
L_11_:SetLibrary(L_13_)

local L_15_ = L_13_:CreateWindow({
	Title = "nexus ",
	"",
	SubTitle = "",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Dark",
})

local L_16_ = {
	Main = L_15_:AddTab({
		Title = "Main",
		Icon = "rbxassetid://13075651575"
	}),
	-- Misc = Window:AddTab({
	--    Title = "Misc",
	--    Icon = "rbxassetid://10709818534"
	--}),
	Egg = L_15_:AddTab({
		Title = "Egg",
		Icon = "rbxassetid://10723345518"
	}),
	Server = L_15_:AddTab({
		Title = "Server",
		Icon = "rbxassetid://10734949856"
	}),
	Premium = premium == "premium" and L_15_:AddTab({
		Title = "Premium",
		Icon = "rbxassetid://10709819149"
	}),
	Settings = L_15_:AddTab({
		Title = "Settings",
		Icon = "rbxassetid://10734950020"
	}),
}
local function L_17_func(L_97_arg1, L_98_arg2, L_99_arg3)
	L_16_.Main:AddToggle(L_98_arg2, {
		Title = L_97_arg1,
		CurrentValue = false,
		Callback = function(L_100_arg1)
			if L_100_arg1 then 
				repeat
					task.wait()
					if L_14_[L_98_arg2].Value then
						local L_101_ = game:GetService("Players").LocalPlayer
						if L_101_.leaderstats.Rebirths.Value < L_99_arg3 then
							L_13_:Notify({
								Title = 'Notification',
								Content = "You need at least "..L_99_arg3.." rebirths to auto farm "..L_97_arg1,
								Duration = 5
							})
							repeat
								task.wait()
							until not L_14_[L_98_arg2].Value or L_101_.leaderstats.Rebirths.Value > L_99_arg3
						else
							if game:GetService("Players").LocalPlayer.currentMap.Value ~= L_98_arg2 then
								local L_102_ = game:GetService("Players").LocalPlayer.currentMap.Value
								if L_102_ ~= "Magma Race" and L_102_ ~= "Grass Race" and L_102_ ~= "Desert Race" then
									game:GetService("ReplicatedStorage").rEvents.areaTravelRemote:InvokeServer("travelToArea", workspace.areaCircles[L_98_arg2])
								end								
							end
							if L_14_.AutoGems.Value then
								spawn(function()
									for L_103_forvar1 = 1, 3 do
										task.wait()
										game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", L_98_arg2)
										game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", L_98_arg2)
									end 
								end)
							end  
							if not L_14_.AutoGems.Value then 
								spawn(function()
									for L_104_forvar1 = 1, 3 do
										task.wait()
										game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", L_98_arg2)
									end
								end)               
							end  
						end
					end
				until not L_14_[L_98_arg2].Value or not L_5_.Connected
			end
		end,
	})
end

L_17_func("Auto Farm City", "City", 0)
L_17_func("Auto Farm Snow City", "Snow City", 0)
L_17_func("Auto Farm Magma City", "Magma City", 1)
L_17_func("Auto Farm Legends Highway", "Legends Highway", 10)

local L_18_ = L_16_.Main:AddToggle("AutoGems", {
	Title = "Auto Farm Gems",
	Default = false,
	Callback = function(L_105_arg1)
	end
})

local L_19_ = L_16_.Main:AddToggle("AutoRebirth", {
	Title = "Auto Rebirth",
	Default = false,
	Callback = function(L_106_arg1)
		if L_106_arg1 then
			repeat
				task.wait(0.1)
				local L_107_ = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
				if L_107_ and L_107_:FindFirstChild("gameGui") and L_107_.gameGui.statsFrame.levelLabel.maxLabel.Visible then
					game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
				end
			until not L_14_.AutoRebirth.Value or not L_5_.Connected
		end
	end
})

local L_20_ = L_16_.Main:AddToggle("AutoHoop", {
	Title = "Auto Hoops",
	Default = false,
	Callback = function(L_108_arg1)
		if L_108_arg1 then 
			repeat
				wait(1)  
				for L_109_forvar1, L_110_forvar2 in pairs(game.Workspace.Hoops:GetChildren()) do
					if L_110_forvar2.Name == 'Hoop' then
						firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), L_110_forvar2, 0)
						firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), L_110_forvar2, 1)
					end
				end
			until not L_14_.AutoHoop.Value or not L_5_.Connected
		end  
	end
})

local L_21_ = L_16_.Main:AddToggle("AutoRace", {
	Title = "Auto Race",
	Default = false,
	Callback = function(L_111_arg1)
		if L_111_arg1 then 
			repeat
				task.wait(1)  
				local L_112_, L_113_ = pcall(function() 
					if game:GetService("Players").LocalPlayer.PlayerGui.gameGui.raceJoinLabel.Visible == true then 
						game:GetService("ReplicatedStorage").rEvents.raceEvent:FireServer("joinRace")
						repeat
							task.wait()
						until game:GetService("Players").LocalPlayer.PlayerGui.gameGui.raceLabel.Text == "Race in progress (44)..."  
						for L_114_forvar1, L_115_forvar2 in pairs(game:GetService("Workspace").raceMaps:GetDescendants()) do
							if L_115_forvar2:IsA("TouchTransmitter") and L_115_forvar2.Parent.Name == "finishPart" then
								Time = 0.1;
								target_pos = CFrame.new(L_115_forvar2.Parent.Position) * CFrame.new(-40, -30, 0)
								TweenI = TweenInfo.new(Time, Enum.EasingStyle.Sine) 
								local L_116_ = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {
									CFrame = target_pos
								}) 
								L_116_:Play() 
								L_116_.Completed:Wait() 
							end 
						end
					end  
				end)
			until not L_14_.AutoRace.Value or not L_5_.Connected
		end  
	end
})

local L_22_ = L_16_.Egg:AddToggle("AutoHatch", {
	Title = "Auto Hatch",
	Default = false,
	Callback = function(L_117_arg1)
		if L_117_arg1 then 
			repeat
				task.wait(.1)  
				game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", L_14_.SelectCrystal.Value)
			until not L_14_.AutoHatch.Value or not L_5_.Connected
		end  
	end
})

local L_23_ = L_16_.Egg:AddDropdown("SelectCrystal", {
	Title = "Select Crystal",
	Values = {
		"Red Crystal",
		"Blue Crystal",
		"Purple Crystal",
		"Yellow Crystal",
		"Lightning Crystal",
		"Snow Crystal",
		"Inferno Crystal",
		"Lava Crystal",
		"Electro Legends Crystal"
	},
	Multi = false,
	Default = false,
	Callback = function(L_118_arg1)
	end
})

local L_24_ = L_16_.Egg:AddToggle("AutoEvolve", {
	Title = "Auto Evolve Pets",
	Default = false,
	Callback = function(L_119_arg1)
		if L_119_arg1 then 
			repeat
				task.wait(1)  
				for L_120_forvar1, L_121_forvar2 in ipairs(game:GetService("ReplicatedStorage").cPetShopFolder:GetChildren()) do
					game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", L_121_forvar2.Name)
				end   
			until not L_14_.AutoEvolve.Value or not L_5_.Connected
		end  
	end
})

local L_25_ = L_16_.Egg:AddToggle("AutoDelete", {
	Title = "Auto Delete Bad Pets",
	Default = false,
	Callback = function(L_122_arg1)
		if L_122_arg1 then 
			repeat
				task.wait(1)  
				local L_123_ = {
					game:GetService("Players").LocalPlayer.petsFolder.Advanced,
					game:GetService("Players").LocalPlayer.petsFolder.Rare,
					game:GetService("Players").LocalPlayer.petsFolder.Basic,
					game:GetService("Players").LocalPlayer.petsFolder.Epic,
					game:GetService("Players").LocalPlayer.petsFolder.Unique,
					game:GetService("Players").LocalPlayer.petsFolder.Omega
				}
				for L_124_forvar1, L_125_forvar2 in ipairs(L_123_) do
					if L_125_forvar2 ~= nil then
						for L_126_forvar1, L_127_forvar2 in ipairs(L_125_forvar2:GetChildren()) do
							if L_125_forvar2 ~= game:GetService("Players").LocalPlayer.petsFolder.Omega or L_127_forvar2.Name ~= "Ultimate Overdrive Bunny" then
								game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer("sellPet", L_127_forvar2)
							end
						end
					end
				end
			until not L_14_.AutoDelete.Value or not L_5_.Connected
		end  
	end
})

local L_26_ = L_16_.Egg:AddToggle("AutoDeleteTrails", {
	Title = "Auto Delete Bad Trails",
	Default = false,
	Callback = function(L_128_arg1)
		if L_128_arg1 then 
			repeat
				task.wait(1)  
				local L_129_ = game:GetService("Players").LocalPlayer.trailsFolder.Unique
				if L_129_ ~= nil then
					for L_131_forvar1, L_132_forvar2 in ipairs(L_129_:GetChildren()) do
						if L_132_forvar2.Name ~= "Rainbow Steps" then
							game:GetService("ReplicatedStorage").rEvents.sellTrailEvent:FireServer("sellTrail", L_132_forvar2)
						end
					end
				end
				local L_130_ = {
					game:GetService("Players").LocalPlayer.trailsFolder.Epic,
					game:GetService("Players").LocalPlayer.trailsFolder.Basic,
					game:GetService("Players").LocalPlayer.trailsFolder.Rare,
					game:GetService("Players").LocalPlayer.trailsFolder.Advanced
				}
				for L_133_forvar1, L_134_forvar2 in ipairs(L_130_) do
					if L_134_forvar2 ~= nil then
						for L_135_forvar1, L_136_forvar2 in ipairs(L_134_forvar2:GetChildren()) do
							game:GetService("ReplicatedStorage").rEvents.sellTrailEvent:FireServer("sellTrail", L_136_forvar2)
						end
					end
				end
			until not L_14_.AutoDeleteTrails.Value or not L_5_.Connected
		end  
	end
})

local L_27_ = L_16_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_137_arg1)
		if L_137_arg1 then 
			repeat
				task.wait()  
				L_11_:Save(L_3_)
			until not L_14_.Settings.Value or not L_5_.Connected
		end
	end
})

L_16_.Settings:AddButton({
	Title = "Delete Setting Config",
	Callback = function()
		delfile("FLORENCE/settings/"..game.GameId..".json")
	end  
})  

local L_28_ = L_16_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_138_arg1)
		if L_138_arg1 then 
			L_13_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_139_, L_140_, L_141_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_140_.ChildAdded:connect(function(L_142_arg1)
					if L_142_arg1.Name == 'ErrorPrompt' then
						L_141_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_14_.AutoRejoin.Value or not L_5_.Connected
		end
	end
})

local L_29_ = L_16_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_143_arg1)
		if L_143_arg1 then 
			repeat
				task.wait()
				local L_144_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_144_ then
					L_144_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
				end  
			until not L_14_.ReExecute.Value or not L_5_.Connected
		end
	end 
})
L_16_.Server:AddButton({
	Title = "Redeem Codes",
	Callback = function()
		L_12_func()
	end
})
L_16_.Server:AddButton({
	Title = "Rejoin-Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
	end
})  
L_16_.Server:AddButton({
	Title = "Server-Hop", 
	Callback = function()
		local L_145_ = game:GetService("HttpService")
		local L_146_ = game:GetService("TeleportService")
		local L_147_ = "https://games.roblox.com/v1/games/"
		local L_148_, L_149_ = game.PlaceId, game.JobId
		local L_150_ = L_147_..L_148_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_151_func(L_153_arg1)
			local L_154_ = game:HttpGet(L_150_..((L_153_arg1 and "&cursor="..L_153_arg1) or ""))
			return L_145_:JSONDecode(L_154_)
		end
		local L_152_;
		repeat
			local L_155_ = L_151_func(L_152_)
			for L_156_forvar1, L_157_forvar2 in next, L_155_.data do
				if L_157_forvar2.playing < L_157_forvar2.maxPlayers and L_157_forvar2.id ~= L_149_ then
					local L_158_, L_159_ = pcall(L_146_.TeleportToPlaceInstance, L_146_, L_148_, L_157_forvar2.id, Player)
					if L_158_ then
						break
					end
				end
			end
			L_152_ = L_155_.nextPageCursor
		until not L_152_
	end
})

local L_30_ = game:GetService("HttpService")

local L_31_ = {}
do
	L_31_.Folder = "FLORENCE"
	L_31_.Settings = {
		Theme = "Dark",
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "LeftControl"
	}

	function L_31_:SetFolder(L_160_arg1)
		self.Folder = L_160_arg1;
		self:BuildFolderTree()
	end

	function L_31_:SetLibrary(L_161_arg1)
		self.Library = L_161_arg1
	end

	function L_31_:BuildFolderTree()
		local L_162_ = {}

		local L_163_ = self.Folder:split("/")
		for L_164_forvar1 = 1, #L_163_ do
			L_162_[#L_162_ + 1] = table.concat(L_163_, "/", 1, L_164_forvar1)
		end

		table.insert(L_162_, self.Folder)
		table.insert(L_162_, self.Folder.."/settings")

		for L_165_forvar1 = 1, #L_162_ do
			local L_166_ = L_162_[L_165_forvar1]
			if not isfolder(L_166_) then
				makefolder(L_166_)
			end
		end
	end

	function L_31_:SaveSettings()
		writefile(self.Folder.."/options.json", L_30_:JSONEncode(L_31_.Settings))
	end

	function L_31_:LoadSettings()
		local L_167_ = self.Folder.."/options.json"
		if isfile(L_167_) then
			local L_168_ = readfile(L_167_)
			local L_169_, L_170_ = pcall(L_30_.JSONDecode, L_30_, L_168_)

			if L_169_ then
				for L_171_forvar1, L_172_forvar2 in next, L_170_ do
					L_31_.Settings[L_171_forvar1] = L_172_forvar2
				end
			end
		end
	end

	function L_31_:BuildInterfaceSection(L_173_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_174_ = self.Library
		local L_175_ = L_31_.Settings

		L_31_:LoadSettings()

		local L_176_ = L_173_arg1:AddSection("Interface")

		local L_177_ = L_176_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_174_.Themes,
			Default = L_175_.Theme,
			Callback = function(L_179_arg1)
				L_174_:SetTheme(L_179_arg1)
				L_175_.Theme = L_179_arg1
				L_31_:SaveSettings()
			end
		})

		L_177_:SetValue(L_175_.Theme)

		if L_174_.UseAcrylic then
			L_176_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_175_.Acrylic,
				Callback = function(L_180_arg1)
					L_174_:ToggleAcrylic(L_180_arg1)
					L_175_.Acrylic = L_180_arg1
					L_31_:SaveSettings()
				end
			})
		end

		L_176_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_175_.Transparency,
			Callback = function(L_181_arg1)
				L_174_:ToggleTransparency(L_181_arg1)
				L_175_.Transparency = L_181_arg1
				L_31_:SaveSettings()
			end
		})

		local L_178_ = L_176_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_175_.MenuKeybind
		})
		L_178_:OnChanged(function()
			L_175_.MenuKeybind = L_178_.Value
			L_31_:SaveSettings()
		end)
		L_174_.MinimizeKeybind = L_178_
	end
end

L_31_:SetLibrary(L_13_)
L_31_:SetFolder("FLORENCE")
L_31_:BuildInterfaceSection(L_16_.Settings)

L_11_:Load(L_3_)

----------// PREMIUM \\----------
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Kick",
	Callback = function()
		game.Players:Chat(".k "..getgenv().Selected)
	end 
})
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Kill",
	Callback = function()
		game.Players:Chat(". "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Teleport",
	Callback = function()
		game.Players:Chat(".b "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Shut Game Down",
	Callback = function()
		game.Players:Chat(".s "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Freeze",
	Callback = function()
		game.Players:Chat("- "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_16_.Premium:AddButton({
	Title = "Unfreeze",
	Callback = function()
		game.Players:Chat(".u "..getgenv().Selected)
	end
})

task.spawn(function()
	while task.wait() do 
		local L_182_ = game:GetService("Players")
		local L_183_ = game:GetService("TextChatService")
		local L_184_ = L_182_.LocalPlayer
		local L_185_ = L_184_.Name:gsub("_", "")

		for L_186_forvar1, L_187_forvar2 in ipairs(L_182_:GetPlayers()) do
			L_187_forvar2.Chatted:Connect(function(L_188_arg1)
				local L_189_, L_190_ = pcall(function()
					local L_191_ = L_188_arg1:gsub("_", "")
					if L_191_ == ".k "..L_185_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_191_ == ". "..L_185_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_191_ == ".b "..L_185_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_187_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_191_ == ".s "..L_185_ then
						game:Shutdown()
					elseif L_191_ == "- "..L_185_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_191_ == ".u "..L_185_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
					end  
				end)
			end) 
		end
	end 
end)

local L_32_ = {}
local L_33_ = {} 
local L_34_

local function L_35_func()
	if L_34_ then
		L_34_:SetValues(L_32_)
	end
end
local function L_36_func(L_192_arg1)
	for L_193_forvar1, L_194_forvar2 in ipairs(L_32_) do
		if L_194_forvar2 == L_192_arg1.Name then
			table.remove(L_32_, L_193_forvar1)
			L_33_[L_192_arg1] = nil
			L_35_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_195_arg1)
	L_36_func(L_195_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_196_forvar1, L_197_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_197_forvar2.Chatted:Connect(function(L_198_arg1)
				if L_198_arg1 == "nexus-is-back" and not L_33_[L_197_forvar2] then
					if not table.find(L_32_, L_197_forvar2.Name) and L_197_forvar2 ~= game.Players.LocalPlayer then
						local L_199_ = L_197_forvar2.Name:gsub("_", "")
						table.insert(L_32_, L_199_)
						print("Detected:", L_199_)
						L_33_[L_197_forvar2] = true  
						L_35_func() 
					end
				end  
			end) 
		end
	end
end)

L_34_ = premium == "premium" and L_16_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_32_, 
	Multi = false,
	Default = "",
	Callback = function(L_200_arg1)
		getgenv().Selected = L_200_arg1
	end
})

L_15_:SelectTab(1)
