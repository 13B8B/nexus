if getgenv().nexus then
	return
else
	getgenv().nexus = true
end 
repeat
	wait()
until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

--//-------------- FUNCTION ----------------//*
local L_1_ = setmetatable({}, {
	__index = function(L_102_arg1, L_103_arg2)
		local L_104_ = game:GetService(L_103_arg2);
		if L_104_ then
			L_102_arg1[L_103_arg2] = L_104_; 
			return L_104_;
		end
	end,
})
if hookmetamethod and typeof(hookmetamethod) == 'function' then
	local L_105_
	L_105_ = hookmetamethod(game, "__namecall", function(L_106_arg1, ...)
		if getnamecallmethod() == "Kick" then
			return
		end
		return L_105_(L_106_arg1, ...)
	end)
end

--//-------------- SERVICES ----------------//*
local L_2_ = L_1_.Players
local L_3_ = L_1_.Workspace
local L_4_ = L_1_.ReplicatedStorage
local L_5_ = L_1_.RunService
local L_6_ = L_1_.UserInputService
local L_7_ = L_2_.LocalPlayer
local L_8_ = L_4_.Game.GameState
local L_9_ = L_4_.ClientModules
local L_10_ = require(L_9_.CameraAccelerator)
local L_11_ = L_3_.CurrentCamera
local L_12_ = game:GetService('VirtualInputManager')
local L_13_ = L_7_:GetMouse()
local L_14_ = Drawing.new("Circle")
local L_15_ = L_7_.PlayerScripts
local L_16_ = game:GetService("UserInputService")
local L_17_ = L_15_.WeaponryFramework
local L_18_ = require(L_9_.InputConfigs)
local L_19_ = require(L_9_.CharacterStateConfigs)
local L_20_ = L_7_.Name
local L_21_ = game:GetService("HttpService")
local L_22_ = game:GetService("RunService")
local L_23_ = Drawing.new("Circle")
local L_24_ = L_7_.Character
local L_25_ = game:GetService("TeleportService")
local L_26_ = "FLORENCE/SETTINGS/"..game.PlaceId..'.txt'
local L_27_ = game.GameId
local L_28_ = Instance.new("BindableEvent")
local L_29_ = L_28_.Event:Connect(function()
end)

spawn(function()
	while wait() do
		if getgenv().Disconnect == true then
			wait(1)
			L_29_:Disconnect()
			getgenv().Disconnect = false
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
			return
		else  
			L_28_:Fire()
		end
	end  
end)  

local L_30_ = {
	"Torso",
	"Head",
	"Random"
}
local L_31_ = {
	" | nexus takeover",
	" | nexus gaming chair",
	" | domshoe is a W",
	" | domshoe supports nexus",
	" | Domshoe uses Nexus's script",
	"steam is a furry"
}
local L_32_ = {}

local L_33_ = {}
do
	L_33_.Folder = "FLORENCE"
	L_33_.Ignore = {}
	L_33_.Parser = {
		Toggle = {
			Save = function(L_107_arg1, L_108_arg2) 
				return {
					type = "Toggle",
					idx = L_107_arg1,
					value = L_108_arg2.Value
				} 
			end,
			Load = function(L_109_arg1, L_110_arg2)
				if L_33_.Options[L_109_arg1] then 
					L_33_.Options[L_109_arg1]:SetValue(L_110_arg2.value)
				end
			end,
		},
		Slider = {
			Save = function(L_111_arg1, L_112_arg2)
				return {
					type = "Slider",
					idx = L_111_arg1,
					value = tostring(L_112_arg2.Value)
				}
			end,
			Load = function(L_113_arg1, L_114_arg2)
				if L_33_.Options[L_113_arg1] then 
					L_33_.Options[L_113_arg1]:SetValue(L_114_arg2.value)
				end
			end,
		},
		Dropdown = {
			Save = function(L_115_arg1, L_116_arg2)
				return {
					type = "Dropdown",
					idx = L_115_arg1,
					value = L_116_arg2.Value,
					mutli = L_116_arg2.Multi
				}
			end,
			Load = function(L_117_arg1, L_118_arg2)
				if L_33_.Options[L_117_arg1] then 
					L_33_.Options[L_117_arg1]:SetValue(L_118_arg2.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(L_119_arg1, L_120_arg2)
				return {
					type = "Colorpicker",
					idx = L_119_arg1,
					value = L_120_arg2.Value:ToHex(),
					transparency = L_120_arg2.Transparency
				}
			end,
			Load = function(L_121_arg1, L_122_arg2)
				if L_33_.Options[L_121_arg1] then 
					L_33_.Options[L_121_arg1]:SetValueRGB(Color3.fromHex(L_122_arg2.value), L_122_arg2.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(L_123_arg1, L_124_arg2)
				return {
					type = "Keybind",
					idx = L_123_arg1,
					mode = L_124_arg2.Mode,
					key = L_124_arg2.Value
				}
			end,
			Load = function(L_125_arg1, L_126_arg2)
				if L_33_.Options[L_125_arg1] then 
					L_33_.Options[L_125_arg1]:SetValue(L_126_arg2.key, L_126_arg2.mode)
				end
			end,
		},

		Input = {
			Save = function(L_127_arg1, L_128_arg2)
				return {
					type = "Input",
					idx = L_127_arg1,
					text = L_128_arg2.Value
				}
			end,
			Load = function(L_129_arg1, L_130_arg2)
				if L_33_.Options[L_129_arg1] and type(L_130_arg2.text) == "string" then
					L_33_.Options[L_129_arg1]:SetValue(L_130_arg2.text)
				end
			end,
		},
	}

	function L_33_:SetIgnoreIndexes(L_131_arg1)
		for L_132_forvar1, L_133_forvar2 in next, L_131_arg1 do
			self.Ignore[L_133_forvar2] = true
		end
	end

	function L_33_:SetFolder(L_134_arg1)
		self.Folder = L_134_arg1;
		self:BuildFolderTree()
	end

	function L_33_:Save(L_135_arg1)
		if (not L_135_arg1) then
			return false, "no config file is selected"
		end

		local L_136_ = self.Folder.."/settings/"..L_135_arg1..".json"

		local L_137_ = {
			objects = {}
		}

		for L_140_forvar1, L_141_forvar2 in next, L_33_.Options do
			if not self.Parser[L_141_forvar2.Type] then
				continue
			end
			if self.Ignore[L_140_forvar1] then
				continue
			end

			table.insert(L_137_.objects, self.Parser[L_141_forvar2.Type].Save(L_140_forvar1, L_141_forvar2))
		end	

		local L_138_, L_139_ = pcall(L_21_.JSONEncode, L_21_, L_137_)
		if not L_138_ then
			return false, "failed to encode data"
		end

		writefile(L_136_, L_139_)
		return true
	end

	function L_33_:Load(L_142_arg1)
		if (not L_142_arg1) then
			return false, "no config file is selected"
		end

		local L_143_ = self.Folder.."/settings/"..L_142_arg1..".json"
		if not isfile(L_143_) then
			return false, "invalid file"
		end

		local L_144_, L_145_ = pcall(L_21_.JSONDecode, L_21_, readfile(L_143_))
		if not L_144_ then
			return false, "decode error"
		end

		for L_146_forvar1, L_147_forvar2 in next, L_145_.objects do
			if self.Parser[L_147_forvar2.type] then
				task.spawn(function()
					self.Parser[L_147_forvar2.type].Load(L_147_forvar2.idx, L_147_forvar2)
				end)
			end
		end

		return true
	end

	function L_33_:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme",
			"AcrylicToggle",
			"TransparentToggle",
			"MenuKeybind"
		})
	end

	function L_33_:BuildFolderTree()
		local L_148_ = {
			self.Folder,
			self.Folder.."/settings"
		}

		for L_149_forvar1 = 1, #L_148_ do
			local L_150_ = L_148_[L_149_forvar1]
			if not isfolder(L_150_) then
				makefolder(L_150_)
			end
		end
	end

	function L_33_:SetLibrary(L_151_arg1)
		self.Library = L_151_arg1
		self.Options = L_151_arg1.Options
	end

	L_33_:BuildFolderTree()
end

local L_34_ = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
local L_35_ = L_34_.Options
L_33_:SetLibrary(L_34_)
--[[
   premium = true
]]

local L_36_ = L_34_:CreateWindow({
	Title = "nexus ",
	"",
	SubTitle = "",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Dark",
})

local L_37_ = {
	Main = L_36_:AddTab({
		Title = "Main",
		Icon = "rbxassetid://10723424505"
	}),
	Misc = L_36_:AddTab({
		Title = "Misc",
		Icon = "rbxassetid://10709818534"
	}),
	Visual = L_36_:AddTab({
		Title = "Visual",
		Icon = "rbxassetid://10723346959"
	}),
	Player = L_36_:AddTab({
		Title = "Player",
		Icon = "rbxassetid://10747373176"
	}),
	Server = L_36_:AddTab({
		Title = "Server",
		Icon = "rbxassetid://10734949856"
	}),
	Settings = L_36_:AddTab({
		Title = "Settings",
		Icon = "rbxassetid://10734950020"
	}),
	Premium = premium == "premium" and L_36_:AddTab({
		Title = "Premium",
		Icon = "rbxassetid://10709819149"
	}),

}
--Options.SniperAim.Value 200 Options.SilentAim.Value
local L_38_ = L_37_.Main:AddToggle("SilentAim", {
	Title = "Silent Aim",
	Default = false,
	Callback = function(L_152_arg1)
	end
})
local L_39_ = L_37_.Main:AddToggle("ShowFOV", {
	Title = "Show FOV",
	Default = false,
	Callback = function(L_153_arg1)
	end
})
local L_40_ = L_37_.Main:AddSlider("Radius", {
	Title = "Fov Radius",
	Default = 0,
	Min = 50,
	Max = 250,
	Rounding = 1,
	Callback = function(L_154_arg1)
	end
})  
local L_41_ = L_37_.Main:AddDropdown("Hitpart", {
	Title = "Hitpart",
	Values = {
		"Head",
		"Torso",
		"Random"
	}, 
	Multi = false,
	Default = "",
	Callback = function(L_155_arg1)

	end
})
local L_42_ = L_37_.Misc:AddToggle("AutoReload", {
	Title = "Infinite Ammo",
	Default = false,
	Callback = function(L_156_arg1)
		if L_156_arg1 then 
			repeat
				task.wait(.1)  
				local L_157_ = L_7_.Character
				if L_157_ and L_157_:FindFirstChild("HumanoidRootPart") then
					for L_158_forvar1, L_159_forvar2 in pairs(L_157_:GetChildren()) do
						if L_159_forvar2:IsA("Tool") then
							module:reloadWeapon()
						end
					end
				end
			until not L_35_.AutoReload.Value or not L_29_.Connected
		end
	end
})

local L_43_ = L_37_.Main:AddToggle("SniperAim", {
	Title = "Sniper Wallbang + [ Silent Aim ]",
	Default = false,
	Callback = function(L_160_arg1)
	end
})
local L_44_ = L_37_.Main:AddToggle("KillAll", {
	Title = "Kill All",
	Default = false,
	Callback = function(L_161_arg1)
	end
})

local L_45_ = game:GetService("Players")
local L_46_ = game:GetService("RunService")
local L_47_ = game:GetService("ReplicatedStorage")

if not LPH_OBFUSCATED then
	LPH_JIT = function(...)
		return ...
	end

	LPH_CRASH = function(...)
		return ...
	end

	LPH_NO_VIRTUALIZE = function(...)
		return ...
	end
end

local L_48_ = L_45_.LocalPlayer
local L_49_ = os.time()
local L_50_ = false
local L_51_ = L_47_.Remotes
local L_52_ = L_47_.Weapons

local L_53_ = L_51_.HitHandler
local L_54_ = L_51_.WeaponHandler
local L_55_ = L_51_.VotekickPlayerInit

local L_56_ = LPH_NO_VIRTUALIZE(function(L_162_arg1:Player)
	if L_162_arg1 and L_162_arg1.Character then
		if L_162_arg1.Character:FindFirstChild("Humanoid") and L_162_arg1.Character:FindFirstChild("HumanoidRootPart") and not L_162_arg1.Character:FindFirstChild("ForceField") then
			if (L_162_arg1.Character.Humanoid.Health >= 1) then
				return true
			end
		elseif game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" or game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Team Deathmatch" then 
			if L_7_ and L_7_.Character then
				local L_163_ = L_7_.Character
				if L_163_:FindFirstChild("ForceField") then
					print("Forcefield exists in your character!")
					L_12_:SendKeyEvent(true, "W", false, game)
					task.wait(0.003)
					L_12_:SendKeyEvent(false, "W", false, game)
				end
			end
		end
	end  
	return false
end)

local L_57_ = LPH_NO_VIRTUALIZE(function()
	local L_164_
	local L_165_ = math.huge

	for L_166_forvar1, L_167_forvar2 in next, L_45_:GetPlayers() do
		if (L_167_forvar2 ~= L_48_) and (L_167_forvar2.Team ~= L_48_.Team or L_167_forvar2.Team == nil) and (L_56_(L_167_forvar2) and L_56_(L_48_)) then
			local L_168_ = L_48_:DistanceFromCharacter(L_167_forvar2.Character.HumanoidRootPart.Position)

			if L_168_ < L_165_ then
				L_164_ = L_167_forvar2
				L_165_ = L_168_
			end
		end
	end

	return L_164_
end)

local L_58_ = LPH_JIT(function(L_169_arg1:Player)
	if L_56_(L_48_) and L_56_(L_169_arg1) then
		local L_170_ = L_169_arg1.HitboxVal.Value
		local L_171_ = L_48_.Character:FindFirstChildWhichIsA("Tool")
		local L_172_ = L_48_:DistanceFromCharacter(L_169_arg1.Character.HumanoidRootPart.Position)

		if ((os.time() - L_49_) < 0.1) then
			return
		end

		if L_171_ and L_170_ and L_171_.Name == "Knife" then
			local L_173_ = require(L_52_[L_171_.Name:lower()][L_171_.Name:lower()])

			L_54_:FireServer(1, { 
				["RunTimeValue"] = os.time(), 
				["IsFirstPerson"] = true, 
				["MeleeMode"] = 2, 
				["WeaponProfile"] = {
					["TriggerDisconnected"] = true,
					["WeaponStats"] = L_173_,
					["Reloading"] = false,
					["Extra"] = true,
					["WeaponName"] = L_171_.Name,
					["ToolInstance"] = L_171_,
					["CanShoot"] = true,
					["PauseDebounce"] = {},
					["BodyAttach"] = L_171_.BodyAttach
				},
				["InitialPos"] = L_171_.BodyAttach.Position,
				["ShotTick"] = os.time()
			})

			L_54_:FireServer(2, os.time(), {
				["RayDir"] = CFrame.new(L_171_.BodyAttach.Position, L_170_.HitboxMelee.Position).LookVector,
				["BulletTick"] = os.time()
			})

			L_53_:InvokeServer({
				["HitPlr"] = L_169_arg1,
				["isChar"] = true,
				["Distance"] = L_172_,
				["ShotTick"] = os.time(),
				["isHitbox"] = true,
				["HitObj"] = L_170_.HitboxMelee,
				["HitNorm"] = CFrame.new(L_171_.BodyAttach.Position, L_170_.HitboxMelee.Position).LookVector,
				["BulletTick"] = os.time(),
				["HitChar"] = L_169_arg1.Character,
				["HitPos"] = L_170_.HitboxMelee.Position
			})
		end
	end
end)

L_46_.RenderStepped:Connect(function()

	if ((os.time() - L_49_) < 0) then
		L_50_ = false
	end

	if (not L_50_) and L_35_.KillAll.Value and L_29_.Connected then
		local L_174_ = L_57_()

		if (L_174_ and L_56_(L_174_)) then
			L_50_ = true

			repeat
				task.wait()
				if L_56_(L_48_) then        
					L_48_.Character.HumanoidRootPart.CFrame = CFrame.new(L_174_.Character.HumanoidRootPart.Position - (Vector3.new(0, 0, 0)))
					workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, (L_174_.Character.HumanoidRootPart.Position - Vector3.new(-0.5, 0, 1)))
					L_58_(L_174_)
					local L_175_, L_176_ = pcall(function()
						local L_177_ = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Knife")
						game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(L_177_)
					end)
				end
			until L_174_.Character.Humanoid.Health <= 0 or (not L_56_(L_174_) or not L_56_(L_48_))

			L_50_ = false
		end  
	end
end)
local L_59_ = L_37_.Main:AddToggle("AntiKick", {
	Title = "Anti Vote-Kick",
	Default = false,
	Callback = function(L_178_arg1)
		if L_178_arg1 then
			repeat
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.VerticalInterface.Visible = false
				task.wait(.1)
				if #L_45_:GetPlayers() > 1 then
					local L_179_ = L_45_:GetPlayers()[2]
					L_55_:FireServer(L_179_)
				end
			until not L_35_.AntiKick.Value or not L_29_.Connected
			game:GetService("Players").LocalPlayer.PlayerGui.MainUI.VerticalInterface.Visible = true
		end
	end
})

local L_60_ = L_37_.Misc:AddToggle("Norecoil", {
	Title = "No Recoil",
	Default = false,
	Callback = function(L_180_arg1)
	end  
})
local function L_61_func()
	for L_181_forvar1 = #L_31_, 2, -1 do
		local L_182_ = math.random(1, L_181_forvar1)
		L_31_[L_181_forvar1], L_31_[L_182_] = L_31_[L_182_], L_31_[L_181_forvar1]
	end

	return L_31_[1]
end

local L_62_ = {}

local L_63_ = L_37_.Misc:AddToggle("AutoToxic", {
	Title = "Auto Toxic",
	Default = false,
	Callback = function(L_183_arg1)
		if L_183_arg1 then
			repeat
				task.wait()
				for L_184_forvar1, L_185_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.KillFeed:GetChildren()) do
					if L_185_forvar2:IsA("Frame") and L_185_forvar2.Eliminator.PlayerName.Text == L_20_ then
						local L_186_ = L_185_forvar2.Eliminated.PlayerName.Text
						if not table.find(L_62_, L_186_) then
							local L_187_ = L_61_func()
							if L_187_ ~= "steam is a furry" then
								L_187_ = L_186_..L_187_
							end
							print("You killed "..L_186_)
							game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(L_187_, "All")
							table.insert(L_62_, L_186_)
							spawn(function()
								wait(20)
								table.remove(L_62_, table.find(L_62_, L_186_))
							end)
						end
					end
				end
			until not L_35_.AutoToxic.Value or not L_29_.Connected
		end
	end
})
local L_64_ = L_37_.Visual:AddToggle("EnemyChams", {
	Title = "Enemy Chams",
	Default = false,
	Callback = function(L_188_arg1)  
	end
})
local L_65_ = L_37_.Visual:AddToggle("TeamChams", {
	Title = "Team Chams",
	Default = false,
	Callback = function(L_189_arg1)
	end
})
local L_66_ = L_37_.Visual:AddToggle("Rainbow", {
	Title = "Rainbow Chams",
	Default = false,
	Callback = function(L_190_arg1)
	end
})

task.spawn(function()
	while task.wait() do 
		if not L_29_.Connected then 
			for L_191_forvar1, L_192_forvar2 in next, game:GetService('Players'):GetPlayers() do
				pcall(function()
					L_192_forvar2.Character.Highlight:Destroy()
				end)
			end 
			return
		end 
		if L_35_.EnemyChams.Value or L_35_.TeamChams.Value then
			local L_193_, L_194_ = pcall(function()
				local L_195_ = game:GetService("ReplicatedStorage")
				local L_196_ = game:GetService("Players")
				local L_197_ = L_196_.LocalPlayer

				local L_198_ = {}  

				local function L_199_func(L_200_arg1)
					if L_198_[L_200_arg1] ~= nil then
						return L_198_[L_200_arg1]  
					end

					local L_201_ = game:GetService("Players").LocalPlayer.Team
					if L_201_ then
						local L_202_ = L_200_arg1 ~= game:GetService("Players").LocalPlayer and L_200_arg1.Team ~= L_201_
						L_198_[L_200_arg1] = L_202_  
						return L_202_
					end
					return false
				end

				function CreateHighlight()
					for L_203_forvar1, L_204_forvar2 in pairs(L_196_:GetChildren()) do
						if L_204_forvar2 ~= L_197_ and L_204_forvar2.Character and not L_204_forvar2.Character:FindFirstChild("Highlight") then
							local L_205_ = Instance.new("Highlight", L_204_forvar2.Character)
							if L_199_func(L_204_forvar2) == true then
								L_204_forvar2.Character.Highlight.Enabled = false
							elseif L_199_func(L_204_forvar2) == false then
								L_204_forvar2.Character.Highlight.Enabled = false
							end
						end
					end
				end

				function UpdateHighlights()
					for L_206_forvar1, L_207_forvar2 in pairs(L_196_:GetChildren()) do
						if L_207_forvar2 ~= L_197_ and L_207_forvar2.Character and L_207_forvar2.Character:FindFirstChild("Highlight") then
							local L_208_ = L_207_forvar2.Character:FindFirstChild("Highlight")
							if game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" and (L_35_.TeamChams.Value or L_35_.EnemyChams.Value) then
								L_207_forvar2.Character.Highlight.Enabled = true
								L_208_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_199_func(L_207_forvar2) == true and L_35_.EnemyChams.Value == true then
								L_207_forvar2.Character.Highlight.Enabled = true
								L_208_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_199_func(L_207_forvar2) == true and L_35_.EnemyChams.Value == false then
								L_207_forvar2.Character.Highlight.Enabled = false 
							elseif L_199_func(L_207_forvar2) == false and L_35_.TeamChams.Value == true then
								L_207_forvar2.Character.Highlight.Enabled = true
								L_208_.FillColor = Color3.fromRGB(255, 255, 255)
							elseif L_199_func(L_207_forvar2) == false and L_35_.TeamChams.Value == false then
								L_207_forvar2.Character.Highlight.Enabled = false
							end
							if L_35_.Rainbow.Value then 
								L_208_.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
							end
						end  
					end
				end  

				CreateHighlight()
				UpdateHighlights()
			end)
		else  
			for L_209_forvar1, L_210_forvar2 in next, game:GetService('Players'):GetPlayers() do
				if L_210_forvar2.Name ~= game:GetService('Players').LocalPlayer.Name and (L_35_.TeamChams.Value == false or L_210_forvar2.TeamColor ~= game:GetService('Players').LocalPlayer.TeamColor) then
					pcall(function()
						L_210_forvar2.Character.Highlight:Destroy()
					end)
				end
			end
			repeat
				wait()
			until L_35_.EnemyChams.Value == true or L_35_.TeamChams.Value == true 

		end 
	end
end)


local L_67_ = L_37_.Main:AddToggle("ExpandHitbox", {
	Title = "Expand Hitbox",
	Default = false,
	Callback = function(L_211_arg1)
		if L_211_arg1 then 
			repeat
				task.wait()  
				for L_212_forvar1, L_213_forvar2 in pairs (game:GetService("Workspace").Hitboxes:GetChildren()) do
					if L_213_forvar2.Name ~= tostring(game:GetService("Players").LocalPlayer.UserId) and L_213_forvar2:FindFirstChild("HitboxHead") then
						L_213_forvar2.HitboxHead.Size = Vector3.new(30, 30, 30)
					end
				end     
			until not L_35_.ExpandHitbox.Value or not L_29_.Connected
		end
	end
})

local L_68_ = L_37_.Visual:AddToggle("WeaponCham", {
	Title = "Weapon Chams",
	Default = false,
	Callback = function(L_214_arg1)
		if L_214_arg1 then 
			repeat
				task.wait()  
				local L_215_ = L_7_.Character
				if L_215_ and L_215_:FindFirstChild("HumanoidRootPart") then
					for L_216_forvar1, L_217_forvar2 in pairs(L_215_:GetChildren()) do
						if L_217_forvar2:IsA("Tool") then
							for L_218_forvar1, L_219_forvar2 in pairs(L_217_forvar2:GetDescendants()) do
								if L_219_forvar2:IsA("MeshPart") then
									L_219_forvar2.Material = Enum.Material.ForceField                            
								end
							end
						end  
					end
				end
			until not L_35_.WeaponCham.Value or not L_29_.Connected
			if L_24_ and L_24_:FindFirstChild("HumanoidRootPart") then  
				for L_220_forvar1, L_221_forvar2 in pairs(L_24_:GetChildren()) do
					if L_221_forvar2:IsA("Tool") then
						for L_222_forvar1, L_223_forvar2 in pairs(L_221_forvar2:GetDescendants()) do
							if L_223_forvar2:IsA("MeshPart") then
								L_223_forvar2.Material = Enum.Material.SmoothPlastic                        
							end
						end  
					end  
				end
			end
		end
	end
})

local L_69_ = L_37_.Visual:AddToggle("WeaponRainbow", {
	Title = "Rainbow Weapon",
	Default = false,
	Callback = function(L_224_arg1)
		if L_224_arg1 then 
			repeat
				task.wait()  
				local L_225_ = L_7_.Character
				if L_225_ and L_225_:FindFirstChild("HumanoidRootPart") then
					for L_226_forvar1, L_227_forvar2 in pairs(L_225_:GetChildren()) do
						if L_227_forvar2:IsA("Tool") then
							for L_228_forvar1, L_229_forvar2 in pairs(L_227_forvar2:GetDescendants()) do
								if L_229_forvar2:IsA("BasePart") and L_229_forvar2.Name ~= "Handle" then
									L_229_forvar2.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
								end
							end
						end
					end
				end
			until not L_35_.WeaponRainbow.Value or not L_29_.Connected  
		end
	end
})

do 
	L_23_.Thickness = 1
	L_23_.Filled = false
	L_23_.Transparency = 1
	L_23_.Color = Color3.new(207, 95, 64)
	L_23_.Visible = L_35_.ShowFOV.Value;
	L_23_.Radius = L_35_.Radius.Value
end;
function CreateVector2(L_230_arg1) 
	return Vector2.new(L_230_arg1.X, L_230_arg1.Y)
end;
function GetDirection(L_231_arg1, L_232_arg2)
	return (L_232_arg2 - L_231_arg1).Unit * 1000
end;
function GetHitPart(L_233_arg1) 
	if L_233_arg1 then
		local L_234_ = (L_35_.Hitpart.Value == "Random" and L_30_[math.random(1, 2)]) or (L_35_.Hitpart.Value or "Torso")
		local L_235_ = L_233_arg1:FindFirstChild(L_234_)

		if L_235_ then
			return L_235_
		end
	end
end;
function GetFramework()
	for L_236_forvar1, L_237_forvar2 in pairs(L_7_.PlayerScripts:GetChildren()) do
		local L_238_, L_239_ = pcall(function()
			return getsenv(L_237_forvar2)
		end)
		if L_238_ and L_239_.InspectWeapon then
			return L_239_
		end
	end;
	return nil
end;
function IsPartVisible(L_240_arg1, L_241_arg2) 
	L_241_arg2 = L_241_arg2 or {}
	local L_242_ = L_11_.GetPartsObscuringTarget(L_11_, {
		L_240_arg1.Position
	}, {
		L_11_,
		L_7_.Character,
		unpack(L_241_arg2)
	})
	return #L_242_ <= 10
end;
function GetClosestPlayer(L_243_arg1, L_244_arg2) 
	L_243_arg1 = L_243_arg1 or math.huge;    
	for L_245_forvar1, L_246_forvar2 in next, L_45_.GetPlayers(L_45_) do 
		if L_246_forvar2 == L_7_ then 
			continue
		end;
		if L_8_.Value == "Team Deathmatch" and workspace[L_246_forvar2.Name].Head.NameTag.Enabled == true then
			warn("Skipping team·mate")
			continue
		end;
		if not L_246_forvar2.Character then
			continue
		end;
		local L_247_ = L_246_forvar2.Character:FindFirstChild("HumanoidRootPart")

		if not L_247_ then
			continue
		end;
		local L_248_, L_249_ = L_11_.WorldToScreenPoint(L_11_, L_247_.Position) 
		if L_249_ then
			if not IsPartVisible(L_247_, L_244_arg2) then
				continue
			end;
			local L_250_, L_251_
			pcall(function()
				if workspace[L_246_forvar2.Name].Head.NameTag.Enabled == false then
					local L_252_ = (CreateVector2(L_13_) - CreateVector2(L_248_)).Magnitude;
					if L_252_ <= L_243_arg1 then
						L_243_arg1 = L_252_;
						closestPlayer = L_246_forvar2;
						closestPlayerChar = L_246_forvar2.Character       
					end
				end
			end)  
		end
	end;
	return closestPlayer, closestPlayerChar
end;

local L_70_ = GetFramework().CheckIsToolValid;
local L_71_ = {
	["Raycast"] = function(L_253_arg1, ...)
		local L_254_ = {
			...
		}
		if L_35_.SilentAim.Value and L_253_arg1 == L_253_arg1 then
			local L_255_ = debug.traceback() 
			if string.find(L_255_, "FireWeapon") then
				local L_256_ = L_254_[3].FilterDescendantsInstances; 
				local L_257_, L_258_ = GetClosestPlayer(200, L_256_)
				if L_257_ and L_258_ then
					local L_259_ = GetHitPart(L_258_)
					if L_259_ then
						L_254_[2] = GetDirection(L_254_[1], L_259_.Position)
						local L_260_ = game:GetService("Players"):GetPlayers()
						local L_261_ = game.Players.LocalPlayer
						for L_262_forvar1, L_263_forvar2 in ipairs(L_260_) do
							return L_253_arg1.Raycast(L_253_arg1, unpack(L_254_))
						end
					end 
				end  
			end
		end;
		return L_253_arg1.Raycast(L_253_arg1, ...)
	end;		 
}
local L_72_;
L_72_ = hookmetamethod(game, "__namecall", function(L_264_arg1, ...)
	local L_265_ = getnamecallmethod()
	local L_266_ = checkcaller()
	local L_267_ = L_71_[L_265_]
	local L_268_;
	if L_267_ then
		if typeof(L_267_) == "function" then
			L_268_ = {
				checkcaller = false;
				callback = L_267_
			}
		else
			L_268_ = L_267_[L_264_arg1.Name]
		end
	end;
	if (L_268_ and L_268_.checkcaller == L_266_) then
		local L_269_, L_270_ = pcall(L_268_.callback, L_264_arg1, ...)
		if not L_269_ then
			warn("Error", L_270_)
		end;
		return L_270_
	end;
	return L_72_(L_264_arg1, ...)
end)

local L_73_ = L_10_.accelerate
L_10_.accelerate = function(...)
	if L_35_.Norecoil.Value then
		return nil
	end
	return L_73_(...)
end

game.Loaded.Connect(L_46_.RenderStepped, function()
	L_23_.Radius = L_35_.Radius.Value;
	L_23_.Visible = L_35_.ShowFOV.Value;
	L_23_.Position = L_16_.GetMouseLocation(L_16_)
end)

local function L_74_func(L_271_arg1)
	local L_272_, L_273_ = L_11_:WorldToScreenPoint(L_271_arg1.Position)
	return L_273_, Vector2.new(L_272_.X, L_272_.Y)
end

local function L_75_func(L_274_arg1)
	local L_275_ = L_274_arg1.Character
	if not L_275_ or L_275_:FindFirstChildOfClass("ForceField") then
		return nil, nil
	end

	local L_276_ = game.workspace.Hitboxes:FindFirstChild(tostring(L_274_arg1.UserId))
	if not L_276_ or L_275_.Humanoid.Health <= 0 then
		return nil, nil
	end

	local L_277_ = {
		L_276_.HitboxHead,
		L_276_.HitboxBody,
		L_276_.HitboxLeg
	}
	local L_278_, L_279_ = nil, math.huge

	for L_280_forvar1, L_281_forvar2 in ipairs(L_277_) do
		local L_282_, L_283_ = L_74_func(L_281_forvar2)
		if L_282_ then
			local L_284_ = (L_283_ - Vector2.new(L_13_.X, L_13_.Y)).Magnitude
			if L_284_ < L_279_ then
				L_278_ = L_281_forvar2
				L_279_ = L_284_
			end
		end
	end

	return L_278_, L_279_
end

local function L_76_func()
	local L_285_, L_286_, L_287_ = nil, math.huge, nil

	for L_288_forvar1, L_289_forvar2 in ipairs(L_45_:GetPlayers()) do
		if L_289_forvar2 ~= L_7_ and L_289_forvar2.Character then
			local L_290_, L_291_ = L_75_func(L_289_forvar2)
			if L_290_ and L_291_ and L_291_ < L_286_ then
				L_285_ = L_290_
				L_286_ = L_291_
				L_287_ = L_289_forvar2
			end
		end
	end

	return L_285_, L_287_
end

local L_77_, L_78_

game:GetService("RunService").Stepped:Connect(function()
	L_77_, L_78_ = L_76_func()
end)

local L_79_
L_79_ = hookmetamethod(game, "__namecall", function(L_292_arg1, ...)
	local L_293_ = {
		...
	}
	local L_294_ = getnamecallmethod()

	if L_294_ == "InvokeServer" and L_292_arg1.Name == "HitHandler" and L_35_.SniperAim.Value then
		if L_293_[1]["HitPos"] and L_77_ then
			L_293_[1]["HitPos"] = L_77_.Position
			L_293_[1]["HitObj"] = L_77_
		end
	elseif L_294_ == "FireServer" and L_292_arg1.Name == "WeaponHandler" and L_35_.SniperAim.Value then
		if L_293_[3] and L_293_[3]["RayDir"] and L_77_ then
			L_293_[3]["RayDir"] = (L_77_.Position - L_7_.Character.Head.Position).Unit
		end
	end

	return L_79_(L_292_arg1, unpack(L_293_))
end)


local L_80_ = L_37_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_295_arg1)
		if L_295_arg1 then 
			repeat
				task.wait(10)  
				L_33_:Save(L_27_)
			until not L_35_.Settings.Value or not L_29_.Connected
		end
	end
})

L_37_.Settings:AddButton({
	Title = "Delete Setting Config",
	Callback = function()
		delfile("FLORENCE/settings/"..game.GameId..".json")
	end  
})  

local L_81_ = L_37_.Player:AddToggle("SpeedMulti", {
	Title = "Walk Speed",
	Default = false,
	Callback = function(L_296_arg1)
		if L_296_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "SpeedMulti", L_35_.WalkSpeed.Value);
			until not L_35_.SpeedMulti.Value or not L_29_.Connected
			rawset(L_19_, "SpeedMulti", 1);
		end
	end
})
local L_82_ = L_37_.Player:AddSlider("WalkSpeed", {
	Title = "Walk Multi Speed",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_297_arg1)
	end
})
local L_83_ = L_37_.Player:AddToggle("Jump", {
	Title = "Jump Speed",
	Default = false,
	Callback = function(L_298_arg1)
		if L_298_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "JumpMulti", L_35_.JumpPower.Value);
			until not L_35_.Jump.Value or not L_29_.Connected
			rawset(L_19_, "JumpMulti", 1);
		end
	end
})
local L_84_ = L_37_.Player:AddSlider("JumpPower", {
	Title = "Jump Multi",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_299_arg1)
	end
})

local L_85_ = L_37_.Player:AddToggle("AutoSprint", {
	Title = "Auto Sprint",
	Default = false,
	Callback = function(L_300_arg1)
		if L_300_arg1 then 
			repeat
				task.wait(.5)  
				rawset(L_18_, "SprintHolding", true);
			until not L_35_.AutoSprint.Value or not L_29_.Connected
		end
	end
})

local L_86_ = L_37_.Player:AddToggle("Fly", {
	Title = "Fly",
	Default = false,
	Callback = function(L_301_arg1)
	end
})

local L_87_ = 200
local L_88_ = false
local L_89_ = 100000000000000


local function L_90_func(L_302_arg1, L_303_arg2, L_304_arg3)
	local L_305_ = (L_303_arg2 - L_302_arg1)
	local L_306_ = L_305_.Magnitude
	return (L_305_ / L_306_) * L_304_arg3
end

local function L_91_func(L_307_arg1)
	local L_308_ = tostring(L_307_arg1):lower()
	local L_309_, L_310_ = L_308_:find("keycode.")
	return L_308_:sub(L_310_ + 1)
end

local L_92_ = {}

game.RunService.Heartbeat:connect(function()
	pcall(function()
		local L_311_ = L_7_.Character.Humanoid.RootPart
		local L_312_ = CFrame.new() + Vector3.new(0, 0, -L_89_)
		local L_313_ = CFrame.new() + Vector3.new(0, 0, L_89_)
		local L_314_ = CFrame.new() + Vector3.new(-L_89_, 0, 0)
		local L_315_ = CFrame.new() + Vector3.new(L_89_, 0, 0)
		local L_316_ = CFrame.new() + Vector3.new(0, L_89_, 0)
		local L_317_ = CFrame.new() + Vector3.new(0, -L_89_, 0)
		local L_318_ = Vector3.new()

		if L_35_.Fly.Value then
			if L_92_.w_active then
				L_318_ = L_318_ + L_90_func(L_311_.Position, (L_311_.CFrame * L_312_).Position, L_87_)
			end
			if L_92_.s_active then
				L_318_ = L_318_ + L_90_func(L_311_.Position, (L_311_.CFrame * L_313_).Position, L_87_)
			end
			if L_92_.a_active then
				L_318_ = L_318_ + L_90_func(L_311_.Position, (L_311_.CFrame * L_314_).Position, L_87_)
			end
			if L_92_.d_active then
				L_318_ = L_318_ + L_90_func(L_311_.Position, (L_311_.CFrame * L_315_).Position, L_87_)
			end
			if L_92_.space_active then
				L_318_ = L_318_ + Vector3.new(0, L_87_, 0)
			end
			if L_92_.leftcontrol_active then
				L_318_ = L_318_ - Vector3.new(0, L_87_, 0)  -- Apply downward velocity
			end
			L_311_.Velocity = L_318_
			L_311_.CFrame = CFrame.new(L_311_.Position, (workspace.CurrentCamera.CFrame * (CFrame.new() + Vector3.new(0, 0, -L_89_))).Position)
		end
	end)
end)

L_16_.InputBegan:connect(function(L_319_arg1, L_320_arg2)
	if L_320_arg2 then
		return
	end
	L_92_[L_91_func(L_319_arg1.KeyCode).."_active"] = true
end)

L_16_.InputEnded:connect(function(L_321_arg1)
	L_92_[L_91_func(L_321_arg1.KeyCode).."_active"] = false
end)

local L_93_ = L_37_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_322_arg1)
		if L_322_arg1 then 
			L_34_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_323_, L_324_, L_325_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_324_.ChildAdded:connect(function(L_326_arg1)
					if L_326_arg1.Name == 'ErrorPrompt' then
						L_325_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_35_.AutoRejoin.Value or not L_29_.Connected
		end
	end
})

local L_94_ = L_37_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_327_arg1)
		if L_327_arg1 then 
			repeat
				task.wait()
				local L_328_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_328_ then
					L_328_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
				end  
			until not L_35_.ReExecute.Value or not L_29_.Connected
		end
	end 
})
L_37_.Server:AddButton({
	Title = "Rejoin-Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
	end
})  
L_37_.Server:AddButton({
	Title = "Server-Hop", 
	Callback = function()
		local L_329_ = game:GetService("HttpService")
		local L_330_ = game:GetService("TeleportService")
		local L_331_ = "https://games.roblox.com/v1/games/"
		local L_332_, L_333_ = game.PlaceId, game.JobId
		local L_334_ = L_331_..L_332_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_335_func(L_337_arg1)
			local L_338_ = game:HttpGet(L_334_..((L_337_arg1 and "&cursor="..L_337_arg1) or ""))
			return L_329_:JSONDecode(L_338_)
		end
		local L_336_;
		repeat
			local L_339_ = L_335_func(L_336_)
			for L_340_forvar1, L_341_forvar2 in next, L_339_.data do
				if L_341_forvar2.playing < L_341_forvar2.maxPlayers and L_341_forvar2.id ~= L_333_ then
					local L_342_, L_343_ = pcall(L_330_.TeleportToPlaceInstance, L_330_, L_332_, L_341_forvar2.id, Player)
					if L_342_ then
						break
					end
				end
			end
			L_336_ = L_339_.nextPageCursor
		until not L_336_
	end
})

local L_95_ = game:GetService("HttpService")

local L_96_ = {}
do
	L_96_.Folder = "FLORENCE"
	L_96_.Settings = {
		Theme = "Dark",
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "LeftControl"
	}

	function L_96_:SetFolder(L_344_arg1)
		self.Folder = L_344_arg1;
		self:BuildFolderTree()
	end

	function L_96_:SetLibrary(L_345_arg1)
		self.Library = L_345_arg1
	end

	function L_96_:BuildFolderTree()
		local L_346_ = {}

		local L_347_ = self.Folder:split("/")
		for L_348_forvar1 = 1, #L_347_ do
			L_346_[#L_346_ + 1] = table.concat(L_347_, "/", 1, L_348_forvar1)
		end

		table.insert(L_346_, self.Folder)
		table.insert(L_346_, self.Folder.."/settings")

		for L_349_forvar1 = 1, #L_346_ do
			local L_350_ = L_346_[L_349_forvar1]
			if not isfolder(L_350_) then
				makefolder(L_350_)
			end
		end
	end

	function L_96_:SaveSettings()
		writefile(self.Folder.."/options.json", L_95_:JSONEncode(L_96_.Settings))
	end

	function L_96_:LoadSettings()
		local L_351_ = self.Folder.."/options.json"
		if isfile(L_351_) then
			local L_352_ = readfile(L_351_)
			local L_353_, L_354_ = pcall(L_95_.JSONDecode, L_95_, L_352_)

			if L_353_ then
				for L_355_forvar1, L_356_forvar2 in next, L_354_ do
					L_96_.Settings[L_355_forvar1] = L_356_forvar2
				end
			end
		end
	end

	function L_96_:BuildInterfaceSection(L_357_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_358_ = self.Library
		local L_359_ = L_96_.Settings

		L_96_:LoadSettings()

		local L_360_ = L_357_arg1:AddSection("Interface")

		local L_361_ = L_360_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_358_.Themes,
			Default = L_359_.Theme,
			Callback = function(L_363_arg1)
				L_358_:SetTheme(L_363_arg1)
				L_359_.Theme = L_363_arg1
				L_96_:SaveSettings()
			end
		})

		L_361_:SetValue(L_359_.Theme)

		if L_358_.UseAcrylic then
			L_360_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_359_.Acrylic,
				Callback = function(L_364_arg1)
					L_358_:ToggleAcrylic(L_364_arg1)
					L_359_.Acrylic = L_364_arg1
					L_96_:SaveSettings()
				end
			})
		end

		L_360_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_359_.Transparency,
			Callback = function(L_365_arg1)
				L_358_:ToggleTransparency(L_365_arg1)
				L_359_.Transparency = L_365_arg1
				L_96_:SaveSettings()
			end
		})

		local L_362_ = L_360_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_359_.MenuKeybind
		})
		L_362_:OnChanged(function()
			L_359_.MenuKeybind = L_362_.Value
			L_96_:SaveSettings()
		end)
		L_358_.MinimizeKeybind = L_362_
	end
end

L_96_:SetLibrary(L_34_)
L_96_:SetFolder("FLORENCE")
L_96_:BuildInterfaceSection(L_37_.Settings)

L_33_:Load(L_27_)

----------// PREMIUM \\----------
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Kick",
	Callback = function()
		game.Players:Chat(".k "..getgenv().Selected)
	end 
})
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Kill",
	Callback = function()
		game.Players:Chat(". "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Teleport",
	Callback = function()
		game.Players:Chat(".b "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Shut Game Down",
	Callback = function()
		game.Players:Chat(".s "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Freeze",
	Callback = function()
		game.Players:Chat("- "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_37_.Premium:AddButton({
	Title = "Unfreeze",
	Callback = function()
		game.Players:Chat(".u "..getgenv().Selected)
	end
})

task.spawn(function()
	while task.wait() do 
		local L_366_ = game:GetService("Players")
		local L_367_ = game:GetService("TextChatService")
		local L_368_ = L_366_.LocalPlayer
		local L_369_ = L_368_.Name:gsub("_", "")

		for L_370_forvar1, L_371_forvar2 in ipairs(L_366_:GetPlayers()) do
			L_371_forvar2.Chatted:Connect(function(L_372_arg1)
				local L_373_, L_374_ = pcall(function()
					local L_375_ = L_372_arg1:gsub("_", "")
					if L_375_ == ".k "..L_369_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_375_ == ". "..L_369_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_375_ == ".b "..L_369_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_371_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_375_ == ".s "..L_369_ then
						game:Shutdown()
					elseif L_375_ == "- "..L_369_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_375_ == ".u "..L_369_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
					end  
				end)
			end) 
		end
	end 
end)

local L_97_ = {}
local L_98_ = {} 
local L_99_

local function L_100_func()
	if L_99_ then
		L_99_:SetValues(L_97_)
	end
end
local function L_101_func(L_376_arg1)
	for L_377_forvar1, L_378_forvar2 in ipairs(L_97_) do
		if L_378_forvar2 == L_376_arg1.Name then
			table.remove(L_97_, L_377_forvar1)
			L_98_[L_376_arg1] = nil
			L_100_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_379_arg1)
	L_101_func(L_379_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_380_forvar1, L_381_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_381_forvar2.Chatted:Connect(function(L_382_arg1)
				if L_382_arg1 == "nexus-is-back" and not L_98_[L_381_forvar2] then
					if not table.find(L_97_, L_381_forvar2.Name) and L_381_forvar2 ~= game.Players.LocalPlayer then
						local L_383_ = L_381_forvar2.Name:gsub("_", "")
						table.insert(L_97_, L_383_)
						print("Detected:", L_383_)
						L_98_[L_381_forvar2] = true  
						L_100_func() 
					end
				end  
			end) 
		end
	end
end)

L_99_ = premium == "premium" and L_37_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_97_, 
	Multi = false,
	Default = "",
	Callback = function(L_384_arg1)
		getgenv().Selected = L_384_arg1
	end
})

L_36_:SelectTab(1)
