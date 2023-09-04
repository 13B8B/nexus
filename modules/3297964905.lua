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
	__index = function(L_85_arg1, L_86_arg2)
		local L_87_ = game:GetService(L_86_arg2);
		if L_87_ then
			L_85_arg1[L_86_arg2] = L_87_; 
			return L_87_;
		end
	end,
})
if hookmetamethod and typeof(hookmetamethod) == 'function' then
	local L_88_
	L_88_ = hookmetamethod(game, "__namecall", function(L_89_arg1, ...)
		if getnamecallmethod() == "Kick" then
			return
		end
		return L_88_(L_89_arg1, ...)
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
	" | domshoe is a W",
	" | domshoe supports nexus",
	" | domshoe hates panda",
	" | Domshoe uses Nexus's script",
	" | tell Panda nexus wuvs her ;)"
}
local L_32_ = {}

local L_33_ = {}
do
	L_33_.Folder = "FLORENCE"
	L_33_.Ignore = {}
	L_33_.Parser = {
		Toggle = {
			Save = function(L_90_arg1, L_91_arg2) 
				return {
					type = "Toggle",
					idx = L_90_arg1,
					value = L_91_arg2.Value
				} 
			end,
			Load = function(L_92_arg1, L_93_arg2)
				if L_33_.Options[L_92_arg1] then 
					L_33_.Options[L_92_arg1]:SetValue(L_93_arg2.value)
				end
			end,
		},
		Slider = {
			Save = function(L_94_arg1, L_95_arg2)
				return {
					type = "Slider",
					idx = L_94_arg1,
					value = tostring(L_95_arg2.Value)
				}
			end,
			Load = function(L_96_arg1, L_97_arg2)
				if L_33_.Options[L_96_arg1] then 
					L_33_.Options[L_96_arg1]:SetValue(L_97_arg2.value)
				end
			end,
		},
		Dropdown = {
			Save = function(L_98_arg1, L_99_arg2)
				return {
					type = "Dropdown",
					idx = L_98_arg1,
					value = L_99_arg2.Value,
					mutli = L_99_arg2.Multi
				}
			end,
			Load = function(L_100_arg1, L_101_arg2)
				if L_33_.Options[L_100_arg1] then 
					L_33_.Options[L_100_arg1]:SetValue(L_101_arg2.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(L_102_arg1, L_103_arg2)
				return {
					type = "Colorpicker",
					idx = L_102_arg1,
					value = L_103_arg2.Value:ToHex(),
					transparency = L_103_arg2.Transparency
				}
			end,
			Load = function(L_104_arg1, L_105_arg2)
				if L_33_.Options[L_104_arg1] then 
					L_33_.Options[L_104_arg1]:SetValueRGB(Color3.fromHex(L_105_arg2.value), L_105_arg2.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(L_106_arg1, L_107_arg2)
				return {
					type = "Keybind",
					idx = L_106_arg1,
					mode = L_107_arg2.Mode,
					key = L_107_arg2.Value
				}
			end,
			Load = function(L_108_arg1, L_109_arg2)
				if L_33_.Options[L_108_arg1] then 
					L_33_.Options[L_108_arg1]:SetValue(L_109_arg2.key, L_109_arg2.mode)
				end
			end,
		},

		Input = {
			Save = function(L_110_arg1, L_111_arg2)
				return {
					type = "Input",
					idx = L_110_arg1,
					text = L_111_arg2.Value
				}
			end,
			Load = function(L_112_arg1, L_113_arg2)
				if L_33_.Options[L_112_arg1] and type(L_113_arg2.text) == "string" then
					L_33_.Options[L_112_arg1]:SetValue(L_113_arg2.text)
				end
			end,
		},
	}

	function L_33_:SetIgnoreIndexes(L_114_arg1)
		for L_115_forvar1, L_116_forvar2 in next, L_114_arg1 do
			self.Ignore[L_116_forvar2] = true
		end
	end

	function L_33_:SetFolder(L_117_arg1)
		self.Folder = L_117_arg1;
		self:BuildFolderTree()
	end

	function L_33_:Save(L_118_arg1)
		if (not L_118_arg1) then
			return false, "no config file is selected"
		end

		local L_119_ = self.Folder.."/settings/"..L_118_arg1..".json"

		local L_120_ = {
			objects = {}
		}

		for L_123_forvar1, L_124_forvar2 in next, L_33_.Options do
			if not self.Parser[L_124_forvar2.Type] then
				continue
			end
			if self.Ignore[L_123_forvar1] then
				continue
			end

			table.insert(L_120_.objects, self.Parser[L_124_forvar2.Type].Save(L_123_forvar1, L_124_forvar2))
		end	

		local L_121_, L_122_ = pcall(L_21_.JSONEncode, L_21_, L_120_)
		if not L_121_ then
			return false, "failed to encode data"
		end

		writefile(L_119_, L_122_)
		return true
	end

	function L_33_:Load(L_125_arg1)
		if (not L_125_arg1) then
			return false, "no config file is selected"
		end

		local L_126_ = self.Folder.."/settings/"..L_125_arg1..".json"
		if not isfile(L_126_) then
			return false, "invalid file"
		end

		local L_127_, L_128_ = pcall(L_21_.JSONDecode, L_21_, readfile(L_126_))
		if not L_127_ then
			return false, "decode error"
		end

		for L_129_forvar1, L_130_forvar2 in next, L_128_.objects do
			if self.Parser[L_130_forvar2.type] then
				task.spawn(function()
					self.Parser[L_130_forvar2.type].Load(L_130_forvar2.idx, L_130_forvar2)
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
		local L_131_ = {
			self.Folder,
			self.Folder.."/settings"
		}

		for L_132_forvar1 = 1, #L_131_ do
			local L_133_ = L_131_[L_132_forvar1]
			if not isfolder(L_133_) then
				makefolder(L_133_)
			end
		end
	end

	function L_33_:SetLibrary(L_134_arg1)
		self.Library = L_134_arg1
		self.Options = L_134_arg1.Options
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
	Callback = function(L_135_arg1)
	end
})
local L_39_ = L_37_.Main:AddToggle("ShowFOV", {
	Title = "Show FOV",
	Default = false,
	Callback = function(L_136_arg1)
	end
})
local L_40_ = L_37_.Main:AddSlider("Radius", {
	Title = "Fov Radius",
	Default = 0,
	Min = 50,
	Max = 250,
	Rounding = 1,
	Callback = function(L_137_arg1)
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
	Callback = function(L_138_arg1)

	end
})
local L_42_ = L_37_.Misc:AddToggle("AutoReload", {
	Title = "Infinite Ammo",
	Default = false,
	Callback = function(L_139_arg1)
		if L_139_arg1 then 
			repeat
				task.wait(.1)  
				local L_140_ = L_7_.Character
				if L_140_ and L_140_:FindFirstChild("HumanoidRootPart") then
					for L_141_forvar1, L_142_forvar2 in pairs(L_140_:GetChildren()) do
						if L_142_forvar2:IsA("Tool") then
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
	Callback = function(L_143_arg1)
	end
})

local L_44_ = L_37_.Misc:AddToggle("Norecoil", {
	Title = "No Recoil",
	Default = false,
	Callback = function(L_144_arg1)
	end  
})
local function L_45_func()
	local L_145_ = math.random(1, #L_31_)
	return L_31_[L_145_]
end;
local L_46_ = L_37_.Misc:AddToggle("AutoToxic", {
	Title = "Auto Toxic",
	Default = false,
	Callback = function(L_146_arg1)
		if L_146_arg1 then 
			repeat
				task.wait()  
				for L_147_forvar1, L_148_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.KillFeed:GetChildren()) do
					if L_148_forvar2:IsA("Frame") and L_148_forvar2.Eliminator.PlayerName.Text == L_20_ then
						local L_149_ = L_148_forvar2.Eliminated.PlayerName.Text
						if not table.find(L_32_, L_149_) then
							print("You killed "..L_149_)
							game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(L_149_..L_45_func(), "All")
							table.insert(L_32_, L_149_)
							spawn(function()
								wait(20)
								table.remove(L_32_, table.find(L_32_, L_149_))
							end)
						end  
					end
				end
			until not L_35_.AutoToxic.Value or not L_29_.Connected
		end
	end
})
local L_47_ = L_37_.Visual:AddToggle("EnemyChams", {
	Title = "Enemy Chams",
	Default = false,
	Callback = function(L_150_arg1)  
	end
})
local L_48_ = L_37_.Visual:AddToggle("TeamChams", {
	Title = "Team Chams",
	Default = false,
	Callback = function(L_151_arg1)
	end
})
local L_49_ = L_37_.Visual:AddToggle("Rainbow", {
	Title = "Rainbow Chams",
	Default = false,
	Callback = function(L_152_arg1)
	end
})

task.spawn(function()
	while task.wait() do 
		if not L_29_.Connected then 
			for L_153_forvar1, L_154_forvar2 in next, game:GetService('Players'):GetPlayers() do
				pcall(function()
					L_154_forvar2.Character.Highlight:Destroy()
				end)
			end 
			return
		end 
		if L_35_.EnemyChams.Value or L_35_.TeamChams.Value then
			local L_155_, L_156_ = pcall(function()
				local L_157_ = game:GetService("ReplicatedStorage")
				local L_158_ = game:GetService("Players")
				local L_159_ = L_158_.LocalPlayer

				local L_160_ = {}  

				local function L_161_func(L_162_arg1)
					if L_160_[L_162_arg1] ~= nil then
						return L_160_[L_162_arg1]  
					end

					local L_163_ = game:GetService("Players").LocalPlayer.Team
					if L_163_ then
						local L_164_ = L_162_arg1 ~= game:GetService("Players").LocalPlayer and L_162_arg1.Team ~= L_163_
						L_160_[L_162_arg1] = L_164_  
						return L_164_
					end
					return false
				end

				function CreateHighlight()
					for L_165_forvar1, L_166_forvar2 in pairs(L_158_:GetChildren()) do
						if L_166_forvar2 ~= L_159_ and L_166_forvar2.Character and not L_166_forvar2.Character:FindFirstChild("Highlight") then
							local L_167_ = Instance.new("Highlight", L_166_forvar2.Character)
							if L_161_func(L_166_forvar2) == true then
								L_166_forvar2.Character.Highlight.Enabled = false
							elseif L_161_func(L_166_forvar2) == false then
								L_166_forvar2.Character.Highlight.Enabled = false
							end
						end
					end
				end

				function UpdateHighlights()
					for L_168_forvar1, L_169_forvar2 in pairs(L_158_:GetChildren()) do
						if L_169_forvar2 ~= L_159_ and L_169_forvar2.Character and L_169_forvar2.Character:FindFirstChild("Highlight") then
							local L_170_ = L_169_forvar2.Character:FindFirstChild("Highlight")
							if game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" and (L_35_.TeamChams.Value or L_35_.EnemyChams.Value) then
								L_169_forvar2.Character.Highlight.Enabled = true
								L_170_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_161_func(L_169_forvar2) == true and L_35_.EnemyChams.Value == true then
								L_169_forvar2.Character.Highlight.Enabled = true
								L_170_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_161_func(L_169_forvar2) == true and L_35_.EnemyChams.Value == false then
								L_169_forvar2.Character.Highlight.Enabled = false 
							elseif L_161_func(L_169_forvar2) == false and L_35_.TeamChams.Value == true then
								L_169_forvar2.Character.Highlight.Enabled = true
								L_170_.FillColor = Color3.fromRGB(255, 255, 255)
							elseif L_161_func(L_169_forvar2) == false and L_35_.TeamChams.Value == false then
								L_169_forvar2.Character.Highlight.Enabled = false
							end
							if L_35_.Rainbow.Value then 
								L_170_.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
							end
						end  
					end
				end  

				CreateHighlight()
				UpdateHighlights()
			end)
		else  
			for L_171_forvar1, L_172_forvar2 in next, game:GetService('Players'):GetPlayers() do
				if L_172_forvar2.Name ~= game:GetService('Players').LocalPlayer.Name and (L_35_.TeamChams.Value == false or L_172_forvar2.TeamColor ~= game:GetService('Players').LocalPlayer.TeamColor) then
					pcall(function()
						L_172_forvar2.Character.Highlight:Destroy()
					end)
				end
			end
			repeat
				wait()
			until L_35_.EnemyChams.Value == true or L_35_.TeamChams.Value == true 

		end 
	end
end)


local L_50_ = L_37_.Main:AddToggle("ExpandHitbox", {
	Title = "Expand Hitbox",
	Default = false,
	Callback = function(L_173_arg1)
		if L_173_arg1 then 
			repeat
				task.wait()  
				for L_174_forvar1, L_175_forvar2 in pairs (game:GetService("Workspace").Hitboxes:GetChildren()) do
					if L_175_forvar2.Name ~= tostring(game:GetService("Players").LocalPlayer.UserId) and L_175_forvar2:FindFirstChild("HitboxHead") then
						L_175_forvar2.HitboxHead.Size = Vector3.new(30, 30, 30)
					end
				end     
			until not L_35_.ExpandHitbox.Value or not L_29_.Connected
		end
	end
})

local L_51_ = L_37_.Visual:AddToggle("WeaponCham", {
	Title = "Weapon Chams",
	Default = false,
	Callback = function(L_176_arg1)
		if L_176_arg1 then 
			repeat
				task.wait()  
				local L_177_ = L_7_.Character
				if L_177_ and L_177_:FindFirstChild("HumanoidRootPart") then
					for L_178_forvar1, L_179_forvar2 in pairs(L_177_:GetChildren()) do
						if L_179_forvar2:IsA("Tool") then
							for L_180_forvar1, L_181_forvar2 in pairs(L_179_forvar2:GetDescendants()) do
								if L_181_forvar2:IsA("MeshPart") then
									L_181_forvar2.Material = Enum.Material.ForceField                            
								end
							end
						end  
					end
				end
			until not L_35_.WeaponCham.Value or not L_29_.Connected
			if L_24_ and L_24_:FindFirstChild("HumanoidRootPart") then  
				for L_182_forvar1, L_183_forvar2 in pairs(L_24_:GetChildren()) do
					if L_183_forvar2:IsA("Tool") then
						for L_184_forvar1, L_185_forvar2 in pairs(L_183_forvar2:GetDescendants()) do
							if L_185_forvar2:IsA("MeshPart") then
								L_185_forvar2.Material = Enum.Material.SmoothPlastic                        
							end
						end  
					end  
				end
			end
		end
	end
})

local L_52_ = L_37_.Visual:AddToggle("WeaponRainbow", {
	Title = "Rainbow Weapon",
	Default = false,
	Callback = function(L_186_arg1)
		if L_186_arg1 then 
			repeat
				task.wait()  
				local L_187_ = L_7_.Character
				if L_187_ and L_187_:FindFirstChild("HumanoidRootPart") then
					for L_188_forvar1, L_189_forvar2 in pairs(L_187_:GetChildren()) do
						if L_189_forvar2:IsA("Tool") then
							for L_190_forvar1, L_191_forvar2 in pairs(L_189_forvar2:GetDescendants()) do
								if L_191_forvar2:IsA("BasePart") and L_191_forvar2.Name ~= "Handle" then
									L_191_forvar2.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
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
function CreateVector2(L_192_arg1) 
	return Vector2.new(L_192_arg1.X, L_192_arg1.Y)
end;
function GetDirection(L_193_arg1, L_194_arg2)
	return (L_194_arg2 - L_193_arg1).Unit * 1000
end;
function GetHitPart(L_195_arg1) 
	if L_195_arg1 then
		local L_196_ = (L_35_.Hitpart.Value == "Random" and L_30_[math.random(1, 2)]) or (L_35_.Hitpart.Value or "Torso")
		local L_197_ = L_195_arg1:FindFirstChild(L_196_)

		if L_197_ then
			return L_197_
		end
	end
end;
function GetFramework()
	for L_198_forvar1, L_199_forvar2 in pairs(L_7_.PlayerScripts:GetChildren()) do
		local L_200_, L_201_ = pcall(function()
			return getsenv(L_199_forvar2)
		end)
		if L_200_ and L_201_.InspectWeapon then
			return L_201_
		end
	end;
	return nil
end;
function IsPartVisible(L_202_arg1, L_203_arg2) 
	L_203_arg2 = L_203_arg2 or {}
	local L_204_ = L_11_.GetPartsObscuringTarget(L_11_, {
		L_202_arg1.Position
	}, {
		L_11_,
		L_7_.Character,
		unpack(L_203_arg2)
	})
	return #L_204_ <= 10
end;
function GetClosestPlayer(L_205_arg1, L_206_arg2) 
	L_205_arg1 = L_205_arg1 or math.huge;    
	for L_207_forvar1, L_208_forvar2 in next, L_2_.GetPlayers(L_2_) do 
		if L_208_forvar2 == L_7_ then 
			continue
		end;
		if L_8_.Value == "Team Deathmatch" and workspace[L_208_forvar2.Name].Head.NameTag.Enabled == true then
			warn("Skipping team·mate")
			continue
		end;
		if not L_208_forvar2.Character then
			continue
		end;
		local L_209_ = L_208_forvar2.Character:FindFirstChild("HumanoidRootPart")

		if not L_209_ then
			continue
		end;
		local L_210_, L_211_ = L_11_.WorldToScreenPoint(L_11_, L_209_.Position) 
		if L_211_ then
			if not IsPartVisible(L_209_, L_206_arg2) then
				continue
			end;
			local L_212_, L_213_
			pcall(function()
				if workspace[L_208_forvar2.Name].Head.NameTag.Enabled == false then
					local L_214_ = (CreateVector2(L_13_) - CreateVector2(L_210_)).Magnitude;
					if L_214_ <= L_205_arg1 then
						L_205_arg1 = L_214_;
						closestPlayer = L_208_forvar2;
						closestPlayerChar = L_208_forvar2.Character       
					end
				end
			end)  
		end
	end;
	return closestPlayer, closestPlayerChar
end;

local L_53_ = GetFramework().CheckIsToolValid;
local L_54_ = {
	["Raycast"] = function(L_215_arg1, ...)
		local L_216_ = {
			...
		}
		if L_35_.SilentAim.Value and L_215_arg1 == L_215_arg1 then
			local L_217_ = debug.traceback() 
			if string.find(L_217_, "FireWeapon") then
				local L_218_ = L_216_[3].FilterDescendantsInstances; 
				local L_219_, L_220_ = GetClosestPlayer(200, L_218_)
				if L_219_ and L_220_ then
					local L_221_ = GetHitPart(L_220_)
					if L_221_ then
						L_216_[2] = GetDirection(L_216_[1], L_221_.Position)
						local L_222_ = game:GetService("Players"):GetPlayers()
						local L_223_ = game.Players.LocalPlayer
						for L_224_forvar1, L_225_forvar2 in ipairs(L_222_) do
							return L_215_arg1.Raycast(L_215_arg1, unpack(L_216_))
						end
					end 
				end  
			end
		end;
		return L_215_arg1.Raycast(L_215_arg1, ...)
	end;		 
}
local L_55_;
L_55_ = hookmetamethod(game, "__namecall", function(L_226_arg1, ...)
	local L_227_ = getnamecallmethod()
	local L_228_ = checkcaller()
	local L_229_ = L_54_[L_227_]
	local L_230_;
	if L_229_ then
		if typeof(L_229_) == "function" then
			L_230_ = {
				checkcaller = false;
				callback = L_229_
			}
		else
			L_230_ = L_229_[L_226_arg1.Name]
		end
	end;
	if (L_230_ and L_230_.checkcaller == L_228_) then
		local L_231_, L_232_ = pcall(L_230_.callback, L_226_arg1, ...)
		if not L_231_ then
			warn("Error", L_232_)
		end;
		return L_232_
	end;
	return L_55_(L_226_arg1, ...)
end)

local L_56_ = L_10_.accelerate
L_10_.accelerate = function(...)
	if L_35_.Norecoil.Value then
		return nil
	end
	return L_56_(...)
end

game.Loaded.Connect(L_22_.RenderStepped, function()
	L_23_.Radius = L_35_.Radius.Value;
	L_23_.Visible = L_35_.ShowFOV.Value;
	L_23_.Position = L_16_.GetMouseLocation(L_16_)
end)

local function L_57_func(L_233_arg1)
	local L_234_, L_235_ = L_11_:WorldToScreenPoint(L_233_arg1.Position)
	return L_235_, Vector2.new(L_234_.X, L_234_.Y)
end

local function L_58_func(L_236_arg1)
	local L_237_ = L_236_arg1.Character
	if not L_237_ or L_237_:FindFirstChildOfClass("ForceField") then
		return nil, nil
	end

	local L_238_ = game.workspace.Hitboxes:FindFirstChild(tostring(L_236_arg1.UserId))
	if not L_238_ or L_237_.Humanoid.Health <= 0 then
		return nil, nil
	end

	local L_239_ = {
		L_238_.HitboxHead,
		L_238_.HitboxBody,
		L_238_.HitboxLeg
	}
	local L_240_, L_241_ = nil, math.huge

	for L_242_forvar1, L_243_forvar2 in ipairs(L_239_) do
		local L_244_, L_245_ = L_57_func(L_243_forvar2)
		if L_244_ then
			local L_246_ = (L_245_ - Vector2.new(L_13_.X, L_13_.Y)).Magnitude
			if L_246_ < L_241_ then
				L_240_ = L_243_forvar2
				L_241_ = L_246_
			end
		end
	end

	return L_240_, L_241_
end

local function L_59_func()
	local L_247_, L_248_, L_249_ = nil, math.huge, nil

	for L_250_forvar1, L_251_forvar2 in ipairs(L_2_:GetPlayers()) do
		if L_251_forvar2 ~= L_7_ and L_251_forvar2.Character then
			local L_252_, L_253_ = L_58_func(L_251_forvar2)
			if L_252_ and L_253_ and L_253_ < L_248_ then
				L_247_ = L_252_
				L_248_ = L_253_
				L_249_ = L_251_forvar2
			end
		end
	end

	return L_247_, L_249_
end

local L_60_, L_61_

game:GetService("RunService").Stepped:Connect(function()
	L_60_, L_61_ = L_59_func()
end)

local L_62_
L_62_ = hookmetamethod(game, "__namecall", function(L_254_arg1, ...)
	local L_255_ = {
		...
	}
	local L_256_ = getnamecallmethod()

	if L_256_ == "InvokeServer" and L_254_arg1.Name == "HitHandler" and L_35_.SniperAim.Value then
		if L_255_[1]["HitPos"] and L_60_ then
			L_255_[1]["HitPos"] = L_60_.Position
			L_255_[1]["HitObj"] = L_60_
		end
	elseif L_256_ == "FireServer" and L_254_arg1.Name == "WeaponHandler" and L_35_.SniperAim.Value then
		if L_255_[3] and L_255_[3]["RayDir"] and L_60_ then
			L_255_[3]["RayDir"] = (L_60_.Position - L_7_.Character.Head.Position).Unit
		end
	end

	return L_62_(L_254_arg1, unpack(L_255_))
end)


local L_63_ = L_37_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_257_arg1)
		if L_257_arg1 then 
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

local L_64_ = L_37_.Player:AddToggle("SpeedMulti", {
	Title = "Walk Speed",
	Default = false,
	Callback = function(L_258_arg1)
		if L_258_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "SpeedMulti", L_35_.WalkSpeed.Value);
			until not L_35_.SpeedMulti.Value or not L_29_.Connected
			rawset(L_19_, "SpeedMulti", 1);
		end
	end
})
local L_65_ = L_37_.Player:AddSlider("WalkSpeed", {
	Title = "Walk Multi Speed",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_259_arg1)
	end
})
local L_66_ = L_37_.Player:AddToggle("Jump", {
	Title = "Jump Speed",
	Default = false,
	Callback = function(L_260_arg1)
		if L_260_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "JumpMulti", L_35_.JumpPower.Value);
			until not L_35_.Jump.Value or not L_29_.Connected
			rawset(L_19_, "JumpMulti", 1);
		end
	end
})
local L_67_ = L_37_.Player:AddSlider("JumpPower", {
	Title = "Jump Multi",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_261_arg1)
	end
})

local L_68_ = L_37_.Player:AddToggle("AutoSprint", {
	Title = "Auto Sprint",
	Default = false,
	Callback = function(L_262_arg1)
		if L_262_arg1 then 
			repeat
				task.wait(.5)  
				rawset(L_18_, "SprintHolding", true);
			until not L_35_.AutoSprint.Value or not L_29_.Connected
		end
	end
})

local L_69_ = L_37_.Player:AddToggle("Fly", {
	Title = "Fly",
	Default = false,
	Callback = function(L_263_arg1)
	end
})

local L_70_ = 200
local L_71_ = false
local L_72_ = 100000000000000


local function L_73_func(L_264_arg1, L_265_arg2, L_266_arg3)
	local L_267_ = (L_265_arg2 - L_264_arg1)
	local L_268_ = L_267_.Magnitude
	return (L_267_ / L_268_) * L_266_arg3
end

local function L_74_func(L_269_arg1)
	local L_270_ = tostring(L_269_arg1):lower()
	local L_271_, L_272_ = L_270_:find("keycode.")
	return L_270_:sub(L_272_ + 1)
end

local L_75_ = {}

game.RunService.Heartbeat:connect(function()
	pcall(function()
		local L_273_ = L_7_.Character.Humanoid.RootPart
		local L_274_ = CFrame.new() + Vector3.new(0, 0, -L_72_)
		local L_275_ = CFrame.new() + Vector3.new(0, 0, L_72_)
		local L_276_ = CFrame.new() + Vector3.new(-L_72_, 0, 0)
		local L_277_ = CFrame.new() + Vector3.new(L_72_, 0, 0)
		local L_278_ = CFrame.new() + Vector3.new(0, L_72_, 0)
		local L_279_ = CFrame.new() + Vector3.new(0, -L_72_, 0)
		local L_280_ = Vector3.new()

		if L_35_.Fly.Value then
			if L_75_.w_active then
				L_280_ = L_280_ + L_73_func(L_273_.Position, (L_273_.CFrame * L_274_).Position, L_70_)
			end
			if L_75_.s_active then
				L_280_ = L_280_ + L_73_func(L_273_.Position, (L_273_.CFrame * L_275_).Position, L_70_)
			end
			if L_75_.a_active then
				L_280_ = L_280_ + L_73_func(L_273_.Position, (L_273_.CFrame * L_276_).Position, L_70_)
			end
			if L_75_.d_active then
				L_280_ = L_280_ + L_73_func(L_273_.Position, (L_273_.CFrame * L_277_).Position, L_70_)
			end
			if L_75_.space_active then
				L_280_ = L_280_ + Vector3.new(0, L_70_, 0)
			end
			if L_75_.leftcontrol_active then
				L_280_ = L_280_ - Vector3.new(0, L_70_, 0)  -- Apply downward velocity
			end
			L_273_.Velocity = L_280_
			L_273_.CFrame = CFrame.new(L_273_.Position, (workspace.CurrentCamera.CFrame * (CFrame.new() + Vector3.new(0, 0, -L_72_))).Position)
		end
	end)
end)

L_16_.InputBegan:connect(function(L_281_arg1, L_282_arg2)
	if L_282_arg2 then
		return
	end
	L_75_[L_74_func(L_281_arg1.KeyCode).."_active"] = true
end)

L_16_.InputEnded:connect(function(L_283_arg1)
	L_75_[L_74_func(L_283_arg1.KeyCode).."_active"] = false
end)

local L_76_ = L_37_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_284_arg1)
		if L_284_arg1 then 
			L_34_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_285_, L_286_, L_287_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_286_.ChildAdded:connect(function(L_288_arg1)
					if L_288_arg1.Name == 'ErrorPrompt' then
						L_287_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_35_.AutoRejoin.Value or not L_29_.Connected
		end
	end
})

local L_77_ = L_37_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_289_arg1)
		if L_289_arg1 then 
			repeat
				task.wait()
				local L_290_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_290_ then
					L_290_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
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
		local L_291_ = game:GetService("HttpService")
		local L_292_ = game:GetService("TeleportService")
		local L_293_ = "https://games.roblox.com/v1/games/"
		local L_294_, L_295_ = game.PlaceId, game.JobId
		local L_296_ = L_293_..L_294_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_297_func(L_299_arg1)
			local L_300_ = game:HttpGet(L_296_..((L_299_arg1 and "&cursor="..L_299_arg1) or ""))
			return L_291_:JSONDecode(L_300_)
		end
		local L_298_;
		repeat
			local L_301_ = L_297_func(L_298_)
			for L_302_forvar1, L_303_forvar2 in next, L_301_.data do
				if L_303_forvar2.playing < L_303_forvar2.maxPlayers and L_303_forvar2.id ~= L_295_ then
					local L_304_, L_305_ = pcall(L_292_.TeleportToPlaceInstance, L_292_, L_294_, L_303_forvar2.id, Player)
					if L_304_ then
						break
					end
				end
			end
			L_298_ = L_301_.nextPageCursor
		until not L_298_
	end
})

local L_78_ = game:GetService("HttpService")

local L_79_ = {}
do
	L_79_.Folder = "FLORENCE"
	L_79_.Settings = {
		Theme = "Dark",
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "LeftControl"
	}

	function L_79_:SetFolder(L_306_arg1)
		self.Folder = L_306_arg1;
		self:BuildFolderTree()
	end

	function L_79_:SetLibrary(L_307_arg1)
		self.Library = L_307_arg1
	end

	function L_79_:BuildFolderTree()
		local L_308_ = {}

		local L_309_ = self.Folder:split("/")
		for L_310_forvar1 = 1, #L_309_ do
			L_308_[#L_308_ + 1] = table.concat(L_309_, "/", 1, L_310_forvar1)
		end

		table.insert(L_308_, self.Folder)
		table.insert(L_308_, self.Folder.."/settings")

		for L_311_forvar1 = 1, #L_308_ do
			local L_312_ = L_308_[L_311_forvar1]
			if not isfolder(L_312_) then
				makefolder(L_312_)
			end
		end
	end

	function L_79_:SaveSettings()
		writefile(self.Folder.."/options.json", L_78_:JSONEncode(L_79_.Settings))
	end

	function L_79_:LoadSettings()
		local L_313_ = self.Folder.."/options.json"
		if isfile(L_313_) then
			local L_314_ = readfile(L_313_)
			local L_315_, L_316_ = pcall(L_78_.JSONDecode, L_78_, L_314_)

			if L_315_ then
				for L_317_forvar1, L_318_forvar2 in next, L_316_ do
					L_79_.Settings[L_317_forvar1] = L_318_forvar2
				end
			end
		end
	end

	function L_79_:BuildInterfaceSection(L_319_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_320_ = self.Library
		local L_321_ = L_79_.Settings

		L_79_:LoadSettings()

		local L_322_ = L_319_arg1:AddSection("Interface")

		local L_323_ = L_322_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_320_.Themes,
			Default = L_321_.Theme,
			Callback = function(L_325_arg1)
				L_320_:SetTheme(L_325_arg1)
				L_321_.Theme = L_325_arg1
				L_79_:SaveSettings()
			end
		})

		L_323_:SetValue(L_321_.Theme)

		if L_320_.UseAcrylic then
			L_322_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_321_.Acrylic,
				Callback = function(L_326_arg1)
					L_320_:ToggleAcrylic(L_326_arg1)
					L_321_.Acrylic = L_326_arg1
					L_79_:SaveSettings()
				end
			})
		end

		L_322_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_321_.Transparency,
			Callback = function(L_327_arg1)
				L_320_:ToggleTransparency(L_327_arg1)
				L_321_.Transparency = L_327_arg1
				L_79_:SaveSettings()
			end
		})

		local L_324_ = L_322_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_321_.MenuKeybind
		})
		L_324_:OnChanged(function()
			L_321_.MenuKeybind = L_324_.Value
			L_79_:SaveSettings()
		end)
		L_320_.MinimizeKeybind = L_324_
	end
end

L_79_:SetLibrary(L_34_)
L_79_:SetFolder("FLORENCE")
L_79_:BuildInterfaceSection(L_37_.Settings)

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
		local L_328_ = game:GetService("Players")
		local L_329_ = game:GetService("TextChatService")
		local L_330_ = L_328_.LocalPlayer
		local L_331_ = L_330_.Name:gsub("_", "")

		for L_332_forvar1, L_333_forvar2 in ipairs(L_328_:GetPlayers()) do
			L_333_forvar2.Chatted:Connect(function(L_334_arg1)
				local L_335_, L_336_ = pcall(function()
					local L_337_ = L_334_arg1:gsub("_", "")
					if L_337_ == ".k "..L_331_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_337_ == ". "..L_331_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_337_ == ".b "..L_331_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_333_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_337_ == ".s "..L_331_ then
						game:Shutdown()
					elseif L_337_ == "- "..L_331_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_337_ == ".u "..L_331_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
					end  
				end)
			end) 
		end
	end 
end)

local L_80_ = {}
local L_81_ = {} 
local L_82_

local function L_83_func()
	if L_82_ then
		L_82_:SetValues(L_80_)
	end
end
local function L_84_func(L_338_arg1)
	for L_339_forvar1, L_340_forvar2 in ipairs(L_80_) do
		if L_340_forvar2 == L_338_arg1.Name then
			table.remove(L_80_, L_339_forvar1)
			L_81_[L_338_arg1] = nil
			L_83_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_341_arg1)
	L_84_func(L_341_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_342_forvar1, L_343_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_343_forvar2.Chatted:Connect(function(L_344_arg1)
				if L_344_arg1 == "nexus-is-back" and not L_81_[L_343_forvar2] then
					if not table.find(L_80_, L_343_forvar2.Name) and L_343_forvar2 ~= game.Players.LocalPlayer then
						local L_345_ = L_343_forvar2.Name:gsub("_", "")
						table.insert(L_80_, L_345_)
						print("Detected:", L_345_)
						L_81_[L_343_forvar2] = true  
						L_83_func() 
					end
				end  
			end) 
		end
	end
end)

L_82_ = premium == "premium" and L_37_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_80_, 
	Multi = false,
	Default = "",
	Callback = function(L_346_arg1)
		getgenv().Selected = L_346_arg1
	end
})

L_36_:SelectTab(1)
