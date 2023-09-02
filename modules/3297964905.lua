if getgenv().nexus then
	return
end 
getgenv().nexus = true
repeat
	wait()
until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

--//-------------- FUNCTION ----------------//*
local L_1_ = setmetatable({}, {
	__index = function(L_86_arg1, L_87_arg2)
		local L_88_ = game:GetService(L_87_arg2);
		if L_88_ then
			L_86_arg1[L_87_arg2] = L_88_; 
			return L_88_;
		end
	end,
})
if hookmetamethod and typeof(hookmetamethod) == 'function' then
	local L_89_
	L_89_ = hookmetamethod(game, "__namecall", function(L_90_arg1, ...)
		if getnamecallmethod() == "Kick" then
			return
		end
		return L_89_(L_90_arg1, ...)
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
	" | nexus on top",
	" | nexus gaming chair",
	" | guess what? ... nexus back",
	" | nexus on top!",
	" | Panda is a bad moderator",
	" | tell Panda nexus wuvs her ;)"
}
local L_32_ = {}

local L_33_ = {}
do
	L_33_.Folder = "FLORENCE"
	L_33_.Ignore = {}
	L_33_.Parser = {
		Toggle = {
			Save = function(L_91_arg1, L_92_arg2) 
				return {
					type = "Toggle",
					idx = L_91_arg1,
					value = L_92_arg2.Value
				} 
			end,
			Load = function(L_93_arg1, L_94_arg2)
				if L_33_.Options[L_93_arg1] then 
					L_33_.Options[L_93_arg1]:SetValue(L_94_arg2.value)
				end
			end,
		},
		Slider = {
			Save = function(L_95_arg1, L_96_arg2)
				return {
					type = "Slider",
					idx = L_95_arg1,
					value = tostring(L_96_arg2.Value)
				}
			end,
			Load = function(L_97_arg1, L_98_arg2)
				if L_33_.Options[L_97_arg1] then 
					L_33_.Options[L_97_arg1]:SetValue(L_98_arg2.value)
				end
			end,
		},
		Dropdown = {
			Save = function(L_99_arg1, L_100_arg2)
				return {
					type = "Dropdown",
					idx = L_99_arg1,
					value = L_100_arg2.Value,
					mutli = L_100_arg2.Multi
				}
			end,
			Load = function(L_101_arg1, L_102_arg2)
				if L_33_.Options[L_101_arg1] then 
					L_33_.Options[L_101_arg1]:SetValue(L_102_arg2.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(L_103_arg1, L_104_arg2)
				return {
					type = "Colorpicker",
					idx = L_103_arg1,
					value = L_104_arg2.Value:ToHex(),
					transparency = L_104_arg2.Transparency
				}
			end,
			Load = function(L_105_arg1, L_106_arg2)
				if L_33_.Options[L_105_arg1] then 
					L_33_.Options[L_105_arg1]:SetValueRGB(Color3.fromHex(L_106_arg2.value), L_106_arg2.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(L_107_arg1, L_108_arg2)
				return {
					type = "Keybind",
					idx = L_107_arg1,
					mode = L_108_arg2.Mode,
					key = L_108_arg2.Value
				}
			end,
			Load = function(L_109_arg1, L_110_arg2)
				if L_33_.Options[L_109_arg1] then 
					L_33_.Options[L_109_arg1]:SetValue(L_110_arg2.key, L_110_arg2.mode)
				end
			end,
		},

		Input = {
			Save = function(L_111_arg1, L_112_arg2)
				return {
					type = "Input",
					idx = L_111_arg1,
					text = L_112_arg2.Value
				}
			end,
			Load = function(L_113_arg1, L_114_arg2)
				if L_33_.Options[L_113_arg1] and type(L_114_arg2.text) == "string" then
					L_33_.Options[L_113_arg1]:SetValue(L_114_arg2.text)
				end
			end,
		},
	}

	function L_33_:SetIgnoreIndexes(L_115_arg1)
		for L_116_forvar1, L_117_forvar2 in next, L_115_arg1 do
			self.Ignore[L_117_forvar2] = true
		end
	end

	function L_33_:SetFolder(L_118_arg1)
		self.Folder = L_118_arg1;
		self:BuildFolderTree()
	end

	function L_33_:Save(L_119_arg1)
		if (not L_119_arg1) then
			return false, "no config file is selected"
		end

		local L_120_ = self.Folder.."/settings/"..L_119_arg1..".json"

		local L_121_ = {
			objects = {}
		}

		for L_124_forvar1, L_125_forvar2 in next, L_33_.Options do
			if not self.Parser[L_125_forvar2.Type] then
				continue
			end
			if self.Ignore[L_124_forvar1] then
				continue
			end

			table.insert(L_121_.objects, self.Parser[L_125_forvar2.Type].Save(L_124_forvar1, L_125_forvar2))
		end	

		local L_122_, L_123_ = pcall(L_21_.JSONEncode, L_21_, L_121_)
		if not L_122_ then
			return false, "failed to encode data"
		end

		writefile(L_120_, L_123_)
		return true
	end

	function L_33_:Load(L_126_arg1)
		if (not L_126_arg1) then
			return false, "no config file is selected"
		end

		local L_127_ = self.Folder.."/settings/"..L_126_arg1..".json"
		if not isfile(L_127_) then
			return false, "invalid file"
		end

		local L_128_, L_129_ = pcall(L_21_.JSONDecode, L_21_, readfile(L_127_))
		if not L_128_ then
			return false, "decode error"
		end

		for L_130_forvar1, L_131_forvar2 in next, L_129_.objects do
			if self.Parser[L_131_forvar2.type] then
				task.spawn(function()
					self.Parser[L_131_forvar2.type].Load(L_131_forvar2.idx, L_131_forvar2)
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
		local L_132_ = {
			self.Folder,
			self.Folder.."/settings"
		}

		for L_133_forvar1 = 1, #L_132_ do
			local L_134_ = L_132_[L_133_forvar1]
			if not isfolder(L_134_) then
				makefolder(L_134_)
			end
		end
	end

	function L_33_:SetLibrary(L_135_arg1)
		self.Library = L_135_arg1
		self.Options = L_135_arg1.Options
	end

	L_33_:BuildFolderTree()
end



local function L_34_func(L_136_arg1)
	return spawn(function()
		while task.wait(.1) do
			if L_29_.Connected == true then
				local L_137_, L_138_ = pcall(function() 
					L_136_arg1()
				end)
			end
		end
	end)
end

L_34_func(function()
	for L_139_forvar1, L_140_forvar2 in pairs(getgenv().settings) do
		wait(0.3)
		if L_29_.Connected == true and getgenv().settings.AutoSave == true then 
			getgenv().settings[L_139_forvar1] = L_140_forvar2
			writefile(L_26_, L_21_:JSONEncode(getgenv().settings))
		end
	end
end)

local L_35_ = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
local L_36_ = L_35_.Options
L_33_:SetLibrary(L_35_)
--[[
   premium = true
]]

local L_37_ = L_35_:CreateWindow({
	Title = "nexus ",
	"",
	SubTitle = "",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Dark",
})

local L_38_ = {
	Main = L_37_:AddTab({
		Title = "Main",
		Icon = "rbxassetid://10723424505"
	}),
	Misc = L_37_:AddTab({
		Title = "Misc",
		Icon = "rbxassetid://10709818534"
	}),
	Visual = L_37_:AddTab({
		Title = "Visual",
		Icon = "rbxassetid://10709818534"
	}),
	Player = L_37_:AddTab({
		Title = "Player",
		Icon = "rbxassetid://10747373176"
	}),
	Server = L_37_:AddTab({
		Title = "Server",
		Icon = "rbxassetid://10734949856"
	}),
	Settings = L_37_:AddTab({
		Title = "Settings",
		Icon = "rbxassetid://10734950020"
	}),
	Premium = premium == "premium" and L_37_:AddTab({
		Title = "Premium",
		Icon = "rbxassetid://10709819149"
	}),

}
--Options.SniperAim.Value 200 Options.SilentAim.Value
local L_39_ = L_38_.Main:AddToggle("SilentAim", {
	Title = "Silent Aim",
	Default = false,
	Callback = function(L_141_arg1)
	end
})
local L_40_ = L_38_.Main:AddToggle("ShowFOV", {
	Title = "Show FOV",
	Default = false,
	Callback = function(L_142_arg1)
	end
})
local L_41_ = L_38_.Main:AddSlider("Radius", {
	Title = "Fov Radius",
	Default = 0,
	Min = 50,
	Max = 250,
	Rounding = 1,
	Callback = function(L_143_arg1)
	end
})  
local L_42_ = L_38_.Main:AddDropdown("Hitpart", {
	Title = "Hitpart",
	Values = {
		"Head",
		"Torso",
		"Random"
	}, 
	Multi = false,
	Default = "",
	Callback = function(L_144_arg1)

	end
})
local L_43_ = L_38_.Misc:AddToggle("AutoReload", {
	Title = "Infinite Ammo",
	Default = false,
	Callback = function(L_145_arg1)
		if L_145_arg1 then 
			repeat
				task.wait(.1)  
				local L_146_ = L_7_.Character
				if L_146_ and L_146_:FindFirstChild("HumanoidRootPart") then
					for L_147_forvar1, L_148_forvar2 in pairs(L_146_:GetChildren()) do
						if L_148_forvar2:IsA("Tool") then
							module:reloadWeapon()
						end
					end
				end
			until not L_36_.AutoReload.Value or not L_29_.Connected
		end
	end
})

local L_44_ = L_38_.Main:AddToggle("SniperAim", {
	Title = "Sniper Wallbang + [ Silent Aim ]",
	Default = false,
	Callback = function(L_149_arg1)
	end
})

local L_45_ = L_38_.Misc:AddToggle("Norecoil", {
	Title = "No Recoil",
	Default = false,
	Callback = function(L_150_arg1)
	end  
})
local function L_46_func()
	local L_151_ = math.random(1, #L_31_)
	return L_31_[L_151_]
end;
local L_47_ = L_38_.Misc:AddToggle("AutoToxic", {
	Title = "Auto Toxic",
	Default = false,
	Callback = function(L_152_arg1)
		if L_152_arg1 then 
			repeat
				task.wait()  
				for L_153_forvar1, L_154_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.KillFeed:GetChildren()) do
					if L_154_forvar2:IsA("Frame") and L_154_forvar2.Eliminator.PlayerName.Text == L_20_ then
						local L_155_ = L_154_forvar2.Eliminated.PlayerName.Text
						if not table.find(L_32_, L_155_) then
							print("You killed "..L_155_)
							game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(L_155_..L_46_func(), "All")
							table.insert(L_32_, L_155_)
							spawn(function()
								wait(20)
								table.remove(L_32_, table.find(L_32_, L_155_))
							end)
						end  
					end
				end
			until not L_36_.AutoToxic.Value or not L_29_.Connected
		end
	end
})
local L_48_ = L_38_.Visual:AddToggle("EnemyChams", {
	Title = "Enemy Chams",
	Default = false,
	Callback = function(L_156_arg1)  
	end
})
local L_49_ = L_38_.Visual:AddToggle("TeamChams", {
	Title = "Team Chams",
	Default = false,
	Callback = function(L_157_arg1)
	end
})
local L_50_ = L_38_.Visual:AddToggle("Rainbow", {
	Title = "Rainbow Chams",
	Default = false,
	Callback = function(L_158_arg1)
	end
})

task.spawn(function()
	while task.wait() do 
		if not L_29_.Connected then 
			for L_159_forvar1, L_160_forvar2 in next, game:GetService('Players'):GetPlayers() do
				pcall(function()
					L_160_forvar2.Character.Highlight:Destroy()
				end)
			end 
			return
		end 
		if L_36_.EnemyChams.Value or L_36_.TeamChams.Value then
			local L_161_, L_162_ = pcall(function()
				local L_163_ = game:GetService("ReplicatedStorage")
				local L_164_ = game:GetService("Players")
				local L_165_ = L_164_.LocalPlayer

				local L_166_ = {}  

				local function L_167_func(L_168_arg1)
					if L_166_[L_168_arg1] ~= nil then
						return L_166_[L_168_arg1]  
					end

					local L_169_ = game:GetService("Players").LocalPlayer.Team
					if L_169_ then
						local L_170_ = L_168_arg1 ~= game:GetService("Players").LocalPlayer and L_168_arg1.Team ~= L_169_
						L_166_[L_168_arg1] = L_170_  
						return L_170_
					end
					return false
				end

				function CreateHighlight()
					for L_171_forvar1, L_172_forvar2 in pairs(L_164_:GetChildren()) do
						if L_172_forvar2 ~= L_165_ and L_172_forvar2.Character and not L_172_forvar2.Character:FindFirstChild("Highlight") then
							local L_173_ = Instance.new("Highlight", L_172_forvar2.Character)
							if L_167_func(L_172_forvar2) == true then
								L_172_forvar2.Character.Highlight.Enabled = false
							elseif L_167_func(L_172_forvar2) == false then
								L_172_forvar2.Character.Highlight.Enabled = false
							end
						end
					end
				end

				function UpdateHighlights()
					for L_174_forvar1, L_175_forvar2 in pairs(L_164_:GetChildren()) do
						if L_175_forvar2 ~= L_165_ and L_175_forvar2.Character and L_175_forvar2.Character:FindFirstChild("Highlight") then
							local L_176_ = L_175_forvar2.Character:FindFirstChild("Highlight")
							if game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" and (L_36_.TeamChams.Value or L_36_.EnemyChams.Value) then
								L_175_forvar2.Character.Highlight.Enabled = true
								L_176_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_167_func(L_175_forvar2) == true and L_36_.EnemyChams.Value == true then
								L_175_forvar2.Character.Highlight.Enabled = true
								L_176_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_167_func(L_175_forvar2) == true and L_36_.EnemyChams.Value == false then
								L_175_forvar2.Character.Highlight.Enabled = false 
							elseif L_167_func(L_175_forvar2) == false and L_36_.TeamChams.Value == true then
								L_175_forvar2.Character.Highlight.Enabled = true
								L_176_.FillColor = Color3.fromRGB(255, 255, 255)
							elseif L_167_func(L_175_forvar2) == false and L_36_.TeamChams.Value == false then
								L_175_forvar2.Character.Highlight.Enabled = false
							end
							if L_36_.Rainbow.Value then 
								L_176_.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
							end
						end  
					end
				end  

				CreateHighlight()
				UpdateHighlights()
			end)
		else  
			for L_177_forvar1, L_178_forvar2 in next, game:GetService('Players'):GetPlayers() do
				if L_178_forvar2.Name ~= game:GetService('Players').LocalPlayer.Name and (L_36_.TeamChams.Value == false or L_178_forvar2.TeamColor ~= game:GetService('Players').LocalPlayer.TeamColor) then
					pcall(function()
						L_178_forvar2.Character.Highlight:Destroy()
					end)
				end
			end
			repeat
				wait()
			until L_36_.EnemyChams.Value == true or L_36_.TeamChams.Value == true 

		end 
	end
end)


local L_51_ = L_38_.Main:AddToggle("ExpandHitbox", {
	Title = "Expand Hitbox",
	Default = false,
	Callback = function(L_179_arg1)
		if L_179_arg1 then 
			repeat
				task.wait()  
				for L_180_forvar1, L_181_forvar2 in pairs (game:GetService("Workspace").Hitboxes:GetChildren()) do
					if L_181_forvar2.Name ~= tostring(game:GetService("Players").LocalPlayer.UserId) and L_181_forvar2:FindFirstChild("HitboxHead") then
						L_181_forvar2.HitboxHead.Size = Vector3.new(30, 30, 30)
					end
				end     
			until not L_36_.ExpandHitbox.Value or not L_29_.Connected
		end
	end
})

local L_52_ = L_38_.Visual:AddToggle("WeaponCham", {
	Title = "Weapon Chams",
	Default = false,
	Callback = function(L_182_arg1)
		if L_182_arg1 then 
			repeat
				task.wait()  
				local L_183_ = L_7_.Character
				if L_183_ and L_183_:FindFirstChild("HumanoidRootPart") then
					for L_184_forvar1, L_185_forvar2 in pairs(L_183_:GetChildren()) do
						if L_185_forvar2:IsA("Tool") then
							for L_186_forvar1, L_187_forvar2 in pairs(L_185_forvar2:GetDescendants()) do
								if L_187_forvar2:IsA("MeshPart") then
									L_187_forvar2.Material = Enum.Material.ForceField                            
								end
							end
						end  
					end
				end
			until not L_36_.WeaponCham.Value or not L_29_.Connected
			if L_24_ and L_24_:FindFirstChild("HumanoidRootPart") then  
				for L_188_forvar1, L_189_forvar2 in pairs(L_24_:GetChildren()) do
					if L_189_forvar2:IsA("Tool") then
						for L_190_forvar1, L_191_forvar2 in pairs(L_189_forvar2:GetDescendants()) do
							if L_191_forvar2:IsA("MeshPart") then
								L_191_forvar2.Material = Enum.Material.SmoothPlastic                        
							end
						end  
					end  
				end
			end
		end
	end
})

local L_53_ = L_38_.Visual:AddToggle("WeaponRainbow", {
	Title = "Rainbow Weapon",
	Default = false,
	Callback = function(L_192_arg1)
		if L_192_arg1 then 
			repeat
				task.wait()  
				local L_193_ = L_7_.Character
				if L_193_ and L_193_:FindFirstChild("HumanoidRootPart") then
					for L_194_forvar1, L_195_forvar2 in pairs(L_193_:GetChildren()) do
						if L_195_forvar2:IsA("Tool") then
							for L_196_forvar1, L_197_forvar2 in pairs(L_195_forvar2:GetDescendants()) do
								if L_197_forvar2:IsA("BasePart") and L_197_forvar2.Name ~= "Handle" then
									L_197_forvar2.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
								end
							end
						end
					end
				end
			until not L_36_.WeaponRainbow.Value or not L_29_.Connected  
		end
	end
})

do 
	L_23_.Thickness = 1
	L_23_.Filled = false
	L_23_.Transparency = 1
	L_23_.Color = Color3.new(207, 95, 64)
	L_23_.Visible = L_36_.ShowFOV.Value;
	L_23_.Radius = L_36_.Radius.Value
end;
function CreateVector2(L_198_arg1) 
	return Vector2.new(L_198_arg1.X, L_198_arg1.Y)
end;
function GetDirection(L_199_arg1, L_200_arg2)
	return (L_200_arg2 - L_199_arg1).Unit * 1000
end;
function GetHitPart(L_201_arg1) 
	if L_201_arg1 then
		local L_202_ = (L_36_.Hitpart.Value == "Random" and L_30_[math.random(1, 2)]) or (L_36_.Hitpart.Value or "Torso")
		local L_203_ = L_201_arg1:FindFirstChild(L_202_)

		if L_203_ then
			return L_203_
		end
	end
end;
function GetFramework()
	for L_204_forvar1, L_205_forvar2 in pairs(L_7_.PlayerScripts:GetChildren()) do
		local L_206_, L_207_ = pcall(function()
			return getsenv(L_205_forvar2)
		end)
		if L_206_ and L_207_.InspectWeapon then
			return L_207_
		end
	end;
	return nil
end;
function IsPartVisible(L_208_arg1, L_209_arg2) 
	L_209_arg2 = L_209_arg2 or {}
	local L_210_ = L_11_.GetPartsObscuringTarget(L_11_, {
		L_208_arg1.Position
	}, {
		L_11_,
		L_7_.Character,
		unpack(L_209_arg2)
	})
	return #L_210_ <= 10
end;
function GetClosestPlayer(L_211_arg1, L_212_arg2) 
	L_211_arg1 = L_211_arg1 or math.huge;    
	for L_213_forvar1, L_214_forvar2 in next, L_2_.GetPlayers(L_2_) do 
		if L_214_forvar2 == L_7_ then 
			continue
		end;
		if L_8_.Value == "Team Deathmatch" and workspace[L_214_forvar2.Name].Head.NameTag.Enabled == true then
			warn("Skipping team·mate")
			continue
		end;
		if not L_214_forvar2.Character then
			continue
		end;
		local L_215_ = L_214_forvar2.Character:FindFirstChild("HumanoidRootPart")

		if not L_215_ then
			continue
		end;
		local L_216_, L_217_ = L_11_.WorldToScreenPoint(L_11_, L_215_.Position) 
		if L_217_ then
			if not IsPartVisible(L_215_, L_212_arg2) then
				continue
			end;
			local L_218_, L_219_
			pcall(function()
				if workspace[L_214_forvar2.Name].Head.NameTag.Enabled == false then
					local L_220_ = (CreateVector2(L_13_) - CreateVector2(L_216_)).Magnitude;
					if L_220_ <= L_211_arg1 then
						L_211_arg1 = L_220_;
						closestPlayer = L_214_forvar2;
						closestPlayerChar = L_214_forvar2.Character       
					end
				end
			end)  
		end
	end;
	return closestPlayer, closestPlayerChar
end;

local L_54_ = GetFramework().CheckIsToolValid;
local L_55_ = {
	["Raycast"] = function(L_221_arg1, ...)
		local L_222_ = {
			...
		}
		if L_36_.SilentAim.Value and L_221_arg1 == L_221_arg1 then
			local L_223_ = debug.traceback() 
			if string.find(L_223_, "FireWeapon") then
				local L_224_ = L_222_[3].FilterDescendantsInstances; 
				local L_225_, L_226_ = GetClosestPlayer(200, L_224_)
				if L_225_ and L_226_ then
					local L_227_ = GetHitPart(L_226_)
					if L_227_ then
						L_222_[2] = GetDirection(L_222_[1], L_227_.Position)
						local L_228_ = game:GetService("Players"):GetPlayers()
						local L_229_ = game.Players.LocalPlayer
						for L_230_forvar1, L_231_forvar2 in ipairs(L_228_) do
							return L_221_arg1.Raycast(L_221_arg1, unpack(L_222_))
						end
					end 
				end  
			end
		end;
		return L_221_arg1.Raycast(L_221_arg1, ...)
	end;		 
}
local L_56_;
L_56_ = hookmetamethod(game, "__namecall", function(L_232_arg1, ...)
	local L_233_ = getnamecallmethod()
	local L_234_ = checkcaller()
	local L_235_ = L_55_[L_233_]
	local L_236_;
	if L_235_ then
		if typeof(L_235_) == "function" then
			L_236_ = {
				checkcaller = false;
				callback = L_235_
			}
		else
			L_236_ = L_235_[L_232_arg1.Name]
		end
	end;
	if (L_236_ and L_236_.checkcaller == L_234_) then
		local L_237_, L_238_ = pcall(L_236_.callback, L_232_arg1, ...)
		if not L_237_ then
			warn("Error", L_238_)
		end;
		return L_238_
	end;
	return L_56_(L_232_arg1, ...)
end)

local L_57_ = L_10_.accelerate
L_10_.accelerate = function(...)
	if L_36_.Norecoil.Value then
		return nil
	end
	return L_57_(...)
end

game.Loaded.Connect(L_22_.RenderStepped, function()
	L_23_.Radius = L_36_.Radius.Value;
	L_23_.Visible = L_36_.ShowFOV.Value;
	L_23_.Position = L_16_.GetMouseLocation(L_16_)
end)

local function L_58_func(L_239_arg1)
	local L_240_, L_241_ = L_11_:WorldToScreenPoint(L_239_arg1.Position)
	return L_241_, Vector2.new(L_240_.X, L_240_.Y)
end

local function L_59_func(L_242_arg1)
	local L_243_ = L_242_arg1.Character
	if not L_243_ or L_243_:FindFirstChildOfClass("ForceField") then
		return nil, nil
	end

	local L_244_ = game.workspace.Hitboxes:FindFirstChild(tostring(L_242_arg1.UserId))
	if not L_244_ or L_243_.Humanoid.Health <= 0 then
		return nil, nil
	end

	local L_245_ = {
		L_244_.HitboxHead,
		L_244_.HitboxBody,
		L_244_.HitboxLeg
	}
	local L_246_, L_247_ = nil, math.huge

	for L_248_forvar1, L_249_forvar2 in ipairs(L_245_) do
		local L_250_, L_251_ = L_58_func(L_249_forvar2)
		if L_250_ then
			local L_252_ = (L_251_ - Vector2.new(L_13_.X, L_13_.Y)).Magnitude
			if L_252_ < L_247_ then
				L_246_ = L_249_forvar2
				L_247_ = L_252_
			end
		end
	end

	return L_246_, L_247_
end

local function L_60_func()
	local L_253_, L_254_, L_255_ = nil, math.huge, nil

	for L_256_forvar1, L_257_forvar2 in ipairs(L_2_:GetPlayers()) do
		if L_257_forvar2 ~= L_7_ and L_257_forvar2.Character then
			local L_258_, L_259_ = L_59_func(L_257_forvar2)
			if L_258_ and L_259_ and L_259_ < L_254_ then
				L_253_ = L_258_
				L_254_ = L_259_
				L_255_ = L_257_forvar2
			end
		end
	end

	return L_253_, L_255_
end

local L_61_, L_62_

game:GetService("RunService").Stepped:Connect(function()
	L_61_, L_62_ = L_60_func()
end)

local L_63_
L_63_ = hookmetamethod(game, "__namecall", function(L_260_arg1, ...)
	local L_261_ = {
		...
	}
	local L_262_ = getnamecallmethod()

	if L_262_ == "InvokeServer" and L_260_arg1.Name == "HitHandler" and L_36_.SniperAim.Value then
		if L_261_[1]["HitPos"] and L_61_ then
			L_261_[1]["HitPos"] = L_61_.Position
			L_261_[1]["HitObj"] = L_61_
		end
	elseif L_262_ == "FireServer" and L_260_arg1.Name == "WeaponHandler" and L_36_.SniperAim.Value then
		if L_261_[3] and L_261_[3]["RayDir"] and L_61_ then
			L_261_[3]["RayDir"] = (L_61_.Position - L_7_.Character.Head.Position).Unit
		end
	end

	return L_63_(L_260_arg1, unpack(L_261_))
end)


local L_64_ = L_38_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_263_arg1)
		if L_263_arg1 then 
			repeat
				task.wait(10)  
				L_33_:Save(L_27_)
			until not L_36_.Settings.Value or not L_29_.Connected
		end
	end
})

L_38_.Settings:AddButton({
	Title = "Delete Setting Config",
	Callback = function()
		delfile("FLORENCE/settings/"..game.GameId..".json")
	end  
})  

local L_65_ = L_38_.Player:AddToggle("SpeedMulti", {
	Title = "Walk Speed",
	Default = false,
	Callback = function(L_264_arg1)
		if L_264_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "SpeedMulti", L_36_.WalkSpeed.Value);
			until not L_36_.SpeedMulti.Value or not L_29_.Connected
			rawset(L_19_, "SpeedMulti", 1);
		end
	end
})
local L_66_ = L_38_.Player:AddSlider("WalkSpeed", {
	Title = "Walk Multi Speed",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_265_arg1)
	end
})
local L_67_ = L_38_.Player:AddToggle("Jump", {
	Title = "Jump Speed",
	Default = false,
	Callback = function(L_266_arg1)
		if L_266_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "JumpMulti", L_36_.JumpPower.Value);
			until not L_36_.Jump.Value or not L_29_.Connected
			rawset(L_19_, "JumpMulti", 1);
		end
	end
})
local L_68_ = L_38_.Player:AddSlider("JumpPower", {
	Title = "Jump Multi",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_267_arg1)
	end
})

local L_69_ = L_38_.Player:AddToggle("AutoSprint", {
	Title = "Auto Sprint",
	Default = false,
	Callback = function(L_268_arg1)
		if L_268_arg1 then 
			repeat
				task.wait(.5)  
				rawset(L_18_, "SprintHolding", true);
			until not L_36_.AutoSprint.Value or not L_29_.Connected
		end
	end
})

local L_70_ = L_38_.Player:AddToggle("Fly", {
	Title = "Fly",
	Default = false,
	Callback = function(L_269_arg1)
	end
})

local L_71_ = 200
local L_72_ = false
local L_73_ = 100000000000000


local function L_74_func(L_270_arg1, L_271_arg2, L_272_arg3)
	local L_273_ = (L_271_arg2 - L_270_arg1)
	local L_274_ = L_273_.Magnitude
	return (L_273_ / L_274_) * L_272_arg3
end

local function L_75_func(L_275_arg1)
	local L_276_ = tostring(L_275_arg1):lower()
	local L_277_, L_278_ = L_276_:find("keycode.")
	return L_276_:sub(L_278_ + 1)
end

local L_76_ = {}

game.RunService.Heartbeat:connect(function()
	pcall(function()
		local L_279_ = L_7_.Character.Humanoid.RootPart
		local L_280_ = CFrame.new() + Vector3.new(0, 0, -L_73_)
		local L_281_ = CFrame.new() + Vector3.new(0, 0, L_73_)
		local L_282_ = CFrame.new() + Vector3.new(-L_73_, 0, 0)
		local L_283_ = CFrame.new() + Vector3.new(L_73_, 0, 0)
		local L_284_ = CFrame.new() + Vector3.new(0, L_73_, 0)
		local L_285_ = CFrame.new() + Vector3.new(0, -L_73_, 0)
		local L_286_ = Vector3.new()

		if L_36_.Fly.Value then
			if L_76_.w_active then
				L_286_ = L_286_ + L_74_func(L_279_.Position, (L_279_.CFrame * L_280_).Position, L_71_)
			end
			if L_76_.s_active then
				L_286_ = L_286_ + L_74_func(L_279_.Position, (L_279_.CFrame * L_281_).Position, L_71_)
			end
			if L_76_.a_active then
				L_286_ = L_286_ + L_74_func(L_279_.Position, (L_279_.CFrame * L_282_).Position, L_71_)
			end
			if L_76_.d_active then
				L_286_ = L_286_ + L_74_func(L_279_.Position, (L_279_.CFrame * L_283_).Position, L_71_)
			end
			if L_76_.space_active then
				L_286_ = L_286_ + Vector3.new(0, L_71_, 0)
			end
			if L_76_.leftcontrol_active then
				L_286_ = L_286_ - Vector3.new(0, L_71_, 0)  -- Apply downward velocity
			end
			L_279_.Velocity = L_286_
			L_279_.CFrame = CFrame.new(L_279_.Position, (workspace.CurrentCamera.CFrame * (CFrame.new() + Vector3.new(0, 0, -L_73_))).Position)
		end
	end)
end)

L_16_.InputBegan:connect(function(L_287_arg1, L_288_arg2)
	if L_288_arg2 then
		return
	end
	L_76_[L_75_func(L_287_arg1.KeyCode).."_active"] = true
end)

L_16_.InputEnded:connect(function(L_289_arg1)
	L_76_[L_75_func(L_289_arg1.KeyCode).."_active"] = false
end)

local L_77_ = L_38_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_290_arg1)
		if L_290_arg1 then 
			L_35_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_291_, L_292_, L_293_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_292_.ChildAdded:connect(function(L_294_arg1)
					if L_294_arg1.Name == 'ErrorPrompt' then
						L_293_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_36_.AutoRejoin.Value or not L_29_.Connected
		end
	end
})

local L_78_ = L_38_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_295_arg1)
		if L_295_arg1 then 
			repeat
				task.wait()
				local L_296_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_296_ then
					L_296_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
				end  
			until not L_36_.ReExecute.Value or not L_29_.Connected
		end
	end 
})
L_38_.Server:AddButton({
	Title = "Rejoin-Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
	end
})  
L_38_.Server:AddButton({
	Title = "Server-Hop", 
	Callback = function()
		local L_297_ = game:GetService("HttpService")
		local L_298_ = game:GetService("TeleportService")
		local L_299_ = "https://games.roblox.com/v1/games/"
		local L_300_, L_301_ = game.PlaceId, game.JobId
		local L_302_ = L_299_..L_300_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_303_func(L_305_arg1)
			local L_306_ = game:HttpGet(L_302_..((L_305_arg1 and "&cursor="..L_305_arg1) or ""))
			return L_297_:JSONDecode(L_306_)
		end
		local L_304_;
		repeat
			local L_307_ = L_303_func(L_304_)
			for L_308_forvar1, L_309_forvar2 in next, L_307_.data do
				if L_309_forvar2.playing < L_309_forvar2.maxPlayers and L_309_forvar2.id ~= L_301_ then
					local L_310_, L_311_ = pcall(L_298_.TeleportToPlaceInstance, L_298_, L_300_, L_309_forvar2.id, Player)
					if L_310_ then
						break
					end
				end
			end
			L_304_ = L_307_.nextPageCursor
		until not L_304_
	end
})

local L_79_ = game:GetService("HttpService")

local L_80_ = {}
do
	L_80_.Folder = "FLORENCE"
	L_80_.Settings = {
		Theme = "Dark",
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "LeftControl"
	}

	function L_80_:SetFolder(L_312_arg1)
		self.Folder = L_312_arg1;
		self:BuildFolderTree()
	end

	function L_80_:SetLibrary(L_313_arg1)
		self.Library = L_313_arg1
	end

	function L_80_:BuildFolderTree()
		local L_314_ = {}

		local L_315_ = self.Folder:split("/")
		for L_316_forvar1 = 1, #L_315_ do
			L_314_[#L_314_ + 1] = table.concat(L_315_, "/", 1, L_316_forvar1)
		end

		table.insert(L_314_, self.Folder)
		table.insert(L_314_, self.Folder.."/settings")

		for L_317_forvar1 = 1, #L_314_ do
			local L_318_ = L_314_[L_317_forvar1]
			if not isfolder(L_318_) then
				makefolder(L_318_)
			end
		end
	end

	function L_80_:SaveSettings()
		writefile(self.Folder.."/options.json", L_79_:JSONEncode(L_80_.Settings))
	end

	function L_80_:LoadSettings()
		local L_319_ = self.Folder.."/options.json"
		if isfile(L_319_) then
			local L_320_ = readfile(L_319_)
			local L_321_, L_322_ = pcall(L_79_.JSONDecode, L_79_, L_320_)

			if L_321_ then
				for L_323_forvar1, L_324_forvar2 in next, L_322_ do
					L_80_.Settings[L_323_forvar1] = L_324_forvar2
				end
			end
		end
	end

	function L_80_:BuildInterfaceSection(L_325_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_326_ = self.Library
		local L_327_ = L_80_.Settings

		L_80_:LoadSettings()

		local L_328_ = L_325_arg1:AddSection("Interface")

		local L_329_ = L_328_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_326_.Themes,
			Default = L_327_.Theme,
			Callback = function(L_331_arg1)
				L_326_:SetTheme(L_331_arg1)
				L_327_.Theme = L_331_arg1
				L_80_:SaveSettings()
			end
		})

		L_329_:SetValue(L_327_.Theme)

		if L_326_.UseAcrylic then
			L_328_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_327_.Acrylic,
				Callback = function(L_332_arg1)
					L_326_:ToggleAcrylic(L_332_arg1)
					L_327_.Acrylic = L_332_arg1
					L_80_:SaveSettings()
				end
			})
		end

		L_328_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_327_.Transparency,
			Callback = function(L_333_arg1)
				L_326_:ToggleTransparency(L_333_arg1)
				L_327_.Transparency = L_333_arg1
				L_80_:SaveSettings()
			end
		})

		local L_330_ = L_328_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_327_.MenuKeybind
		})
		L_330_:OnChanged(function()
			L_327_.MenuKeybind = L_330_.Value
			L_80_:SaveSettings()
		end)
		L_326_.MinimizeKeybind = L_330_
	end
end

L_80_:SetLibrary(L_35_)
L_80_:SetFolder("FLORENCE")
L_80_:BuildInterfaceSection(L_38_.Settings)

L_33_:Load(L_27_)

----------// PREMIUM \\----------
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Kick",
	Callback = function()
		game.Players:Chat(".k "..getgenv().Selected)
	end 
})
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Kill",
	Callback = function()
		game.Players:Chat(". "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Teleport",
	Callback = function()
		game.Players:Chat(".b "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Shut Game Down",
	Callback = function()
		game.Players:Chat(".s "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Freeze",
	Callback = function()
		game.Players:Chat("- "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_38_.Premium:AddButton({
	Title = "Unfreeze",
	Callback = function()
		game.Players:Chat(".u "..getgenv().Selected)
	end
})

task.spawn(function()
	while task.wait() do 
		local L_334_ = game:GetService("Players")
		local L_335_ = game:GetService("TextChatService")
		local L_336_ = L_334_.LocalPlayer
		local L_337_ = L_336_.Name:gsub("_", "")

		for L_338_forvar1, L_339_forvar2 in ipairs(L_334_:GetPlayers()) do
			L_339_forvar2.Chatted:Connect(function(L_340_arg1)
				local L_341_, L_342_ = pcall(function()
					local L_343_ = L_340_arg1:gsub("_", "")
					if L_343_ == ".k "..L_337_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_343_ == ". "..L_337_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_343_ == ".b "..L_337_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_339_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_343_ == ".s "..L_337_ then
						game:Shutdown()
					elseif L_343_ == "- "..L_337_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_343_ == ".u "..L_337_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
					end  
				end)
			end) 
		end
	end 
end)

local L_81_ = {}
local L_82_ = {} 
local L_83_

local function L_84_func()
	if L_83_ then
		L_83_:SetValues(L_81_)
	end
end
local function L_85_func(L_344_arg1)
	for L_345_forvar1, L_346_forvar2 in ipairs(L_81_) do
		if L_346_forvar2 == L_344_arg1.Name then
			table.remove(L_81_, L_345_forvar1)
			L_82_[L_344_arg1] = nil
			L_84_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_347_arg1)
	L_85_func(L_347_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_348_forvar1, L_349_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_349_forvar2.Chatted:Connect(function(L_350_arg1)
				if L_350_arg1 == "nexus-is-back" and not L_82_[L_349_forvar2] then
					if not table.find(L_81_, L_349_forvar2.Name) and L_349_forvar2 ~= game.Players.LocalPlayer then
						local L_351_ = L_349_forvar2.Name:gsub("_", "")
						table.insert(L_81_, L_351_)
						print("Detected:", L_351_)
						L_82_[L_349_forvar2] = true  
						L_84_func() 
					end
				end  
			end) 
		end
	end
end)

L_83_ = premium == "premium" and L_38_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_81_, 
	Multi = false,
	Default = "",
	Callback = function(L_352_arg1)
		getgenv().Selected = L_352_arg1
	end
})

L_37_:SelectTab(1)
