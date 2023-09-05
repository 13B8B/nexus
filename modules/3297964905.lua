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
    " | nexus takeover",
    " | nexus gaming chair",
    " | domshoe is a W",
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
	Callback = function(L_136_arg1)
	end
})
local L_39_ = L_37_.Main:AddToggle("ShowFOV", {
	Title = "Show FOV",
	Default = false,
	Callback = function(L_137_arg1)
	end
})
local L_40_ = L_37_.Main:AddSlider("Radius", {
	Title = "Fov Radius",
	Default = 0,
	Min = 50,
	Max = 250,
	Rounding = 1,
	Callback = function(L_138_arg1)
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
	Callback = function(L_139_arg1)

	end
})
local L_42_ = L_37_.Misc:AddToggle("AutoReload", {
	Title = "Infinite Ammo",
	Default = false,
	Callback = function(L_140_arg1)
		if L_140_arg1 then 
			repeat
				task.wait(.1)  
				local L_141_ = L_7_.Character
				if L_141_ and L_141_:FindFirstChild("HumanoidRootPart") then
					for L_142_forvar1, L_143_forvar2 in pairs(L_141_:GetChildren()) do
						if L_143_forvar2:IsA("Tool") then
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
	Callback = function(L_144_arg1)
	end
})

local L_44_ = L_37_.Misc:AddToggle("Norecoil", {
	Title = "No Recoil",
	Default = false,
	Callback = function(L_145_arg1)
	end  
})
local function L_45_func()
	-- Shuffle the words table internally
	for L_146_forvar1 = #L_31_, 2, -1 do
		local L_147_ = math.random(1, L_146_forvar1)
		L_31_[L_146_forvar1], L_31_[L_147_] = L_31_[L_147_], L_31_[L_146_forvar1]
	end

	return L_31_[1]
end

local L_46_ = {}

local L_47_ = L_37_.Misc:AddToggle("AutoToxic", {
	Title = "Auto Toxic",
	Default = false,
	Callback = function(L_148_arg1)
		if L_148_arg1 then
			repeat
				task.wait()
				for L_149_forvar1, L_150_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.KillFeed:GetChildren()) do
					if L_150_forvar2:IsA("Frame") and L_150_forvar2.Eliminator.PlayerName.Text == L_20_ then
						local L_151_ = L_150_forvar2.Eliminated.PlayerName.Text
						if not table.find(L_46_, L_151_) then
							local L_152_ = L_45_func()
							if L_152_ ~= "steam is a furry" then
								L_152_ = L_151_..L_152_
							end
							print("You killed "..L_151_)
							game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(L_152_, "All")
							table.insert(L_46_, L_151_)
							spawn(function()
								wait(20)
								table.remove(L_46_, table.find(L_46_, L_151_))
							end)
						end
					end
				end
			until not L_35_.AutoToxic.Value or not L_29_.Connected
		end
	end
})
local L_48_ = L_37_.Visual:AddToggle("EnemyChams", {
	Title = "Enemy Chams",
	Default = false,
	Callback = function(L_153_arg1)  
	end
})
local L_49_ = L_37_.Visual:AddToggle("TeamChams", {
	Title = "Team Chams",
	Default = false,
	Callback = function(L_154_arg1)
	end
})
local L_50_ = L_37_.Visual:AddToggle("Rainbow", {
	Title = "Rainbow Chams",
	Default = false,
	Callback = function(L_155_arg1)
	end
})

task.spawn(function()
	while task.wait() do 
		if not L_29_.Connected then 
			for L_156_forvar1, L_157_forvar2 in next, game:GetService('Players'):GetPlayers() do
				pcall(function()
					L_157_forvar2.Character.Highlight:Destroy()
				end)
			end 
			return
		end 
		if L_35_.EnemyChams.Value or L_35_.TeamChams.Value then
			local L_158_, L_159_ = pcall(function()
				local L_160_ = game:GetService("ReplicatedStorage")
				local L_161_ = game:GetService("Players")
				local L_162_ = L_161_.LocalPlayer

				local L_163_ = {}  

				local function L_164_func(L_165_arg1)
					if L_163_[L_165_arg1] ~= nil then
						return L_163_[L_165_arg1]  
					end

					local L_166_ = game:GetService("Players").LocalPlayer.Team
					if L_166_ then
						local L_167_ = L_165_arg1 ~= game:GetService("Players").LocalPlayer and L_165_arg1.Team ~= L_166_
						L_163_[L_165_arg1] = L_167_  
						return L_167_
					end
					return false
				end

				function CreateHighlight()
					for L_168_forvar1, L_169_forvar2 in pairs(L_161_:GetChildren()) do
						if L_169_forvar2 ~= L_162_ and L_169_forvar2.Character and not L_169_forvar2.Character:FindFirstChild("Highlight") then
							local L_170_ = Instance.new("Highlight", L_169_forvar2.Character)
							if L_164_func(L_169_forvar2) == true then
								L_169_forvar2.Character.Highlight.Enabled = false
							elseif L_164_func(L_169_forvar2) == false then
								L_169_forvar2.Character.Highlight.Enabled = false
							end
						end
					end
				end

				function UpdateHighlights()
					for L_171_forvar1, L_172_forvar2 in pairs(L_161_:GetChildren()) do
						if L_172_forvar2 ~= L_162_ and L_172_forvar2.Character and L_172_forvar2.Character:FindFirstChild("Highlight") then
							local L_173_ = L_172_forvar2.Character:FindFirstChild("Highlight")
							if game:GetService("ReplicatedStorage").Game.SecondaryStatus.Value == "Free For All" and (L_35_.TeamChams.Value or L_35_.EnemyChams.Value) then
								L_172_forvar2.Character.Highlight.Enabled = true
								L_173_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_164_func(L_172_forvar2) == true and L_35_.EnemyChams.Value == true then
								L_172_forvar2.Character.Highlight.Enabled = true
								L_173_.FillColor = Color3.fromRGB(255, 0, 0)
							elseif L_164_func(L_172_forvar2) == true and L_35_.EnemyChams.Value == false then
								L_172_forvar2.Character.Highlight.Enabled = false 
							elseif L_164_func(L_172_forvar2) == false and L_35_.TeamChams.Value == true then
								L_172_forvar2.Character.Highlight.Enabled = true
								L_173_.FillColor = Color3.fromRGB(255, 255, 255)
							elseif L_164_func(L_172_forvar2) == false and L_35_.TeamChams.Value == false then
								L_172_forvar2.Character.Highlight.Enabled = false
							end
							if L_35_.Rainbow.Value then 
								L_173_.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
							end
						end  
					end
				end  

				CreateHighlight()
				UpdateHighlights()
			end)
		else  
			for L_174_forvar1, L_175_forvar2 in next, game:GetService('Players'):GetPlayers() do
				if L_175_forvar2.Name ~= game:GetService('Players').LocalPlayer.Name and (L_35_.TeamChams.Value == false or L_175_forvar2.TeamColor ~= game:GetService('Players').LocalPlayer.TeamColor) then
					pcall(function()
						L_175_forvar2.Character.Highlight:Destroy()
					end)
				end
			end
			repeat
				wait()
			until L_35_.EnemyChams.Value == true or L_35_.TeamChams.Value == true 

		end 
	end
end)


local L_51_ = L_37_.Main:AddToggle("ExpandHitbox", {
	Title = "Expand Hitbox",
	Default = false,
	Callback = function(L_176_arg1)
		if L_176_arg1 then 
			repeat
				task.wait()  
				for L_177_forvar1, L_178_forvar2 in pairs (game:GetService("Workspace").Hitboxes:GetChildren()) do
					if L_178_forvar2.Name ~= tostring(game:GetService("Players").LocalPlayer.UserId) and L_178_forvar2:FindFirstChild("HitboxHead") then
						L_178_forvar2.HitboxHead.Size = Vector3.new(30, 30, 30)
					end
				end     
			until not L_35_.ExpandHitbox.Value or not L_29_.Connected
		end
	end
})

local L_52_ = L_37_.Visual:AddToggle("WeaponCham", {
	Title = "Weapon Chams",
	Default = false,
	Callback = function(L_179_arg1)
		if L_179_arg1 then 
			repeat
				task.wait()  
				local L_180_ = L_7_.Character
				if L_180_ and L_180_:FindFirstChild("HumanoidRootPart") then
					for L_181_forvar1, L_182_forvar2 in pairs(L_180_:GetChildren()) do
						if L_182_forvar2:IsA("Tool") then
							for L_183_forvar1, L_184_forvar2 in pairs(L_182_forvar2:GetDescendants()) do
								if L_184_forvar2:IsA("MeshPart") then
									L_184_forvar2.Material = Enum.Material.ForceField                            
								end
							end
						end  
					end
				end
			until not L_35_.WeaponCham.Value or not L_29_.Connected
			if L_24_ and L_24_:FindFirstChild("HumanoidRootPart") then  
				for L_185_forvar1, L_186_forvar2 in pairs(L_24_:GetChildren()) do
					if L_186_forvar2:IsA("Tool") then
						for L_187_forvar1, L_188_forvar2 in pairs(L_186_forvar2:GetDescendants()) do
							if L_188_forvar2:IsA("MeshPart") then
								L_188_forvar2.Material = Enum.Material.SmoothPlastic                        
							end
						end  
					end  
				end
			end
		end
	end
})

local L_53_ = L_37_.Visual:AddToggle("WeaponRainbow", {
	Title = "Rainbow Weapon",
	Default = false,
	Callback = function(L_189_arg1)
		if L_189_arg1 then 
			repeat
				task.wait()  
				local L_190_ = L_7_.Character
				if L_190_ and L_190_:FindFirstChild("HumanoidRootPart") then
					for L_191_forvar1, L_192_forvar2 in pairs(L_190_:GetChildren()) do
						if L_192_forvar2:IsA("Tool") then
							for L_193_forvar1, L_194_forvar2 in pairs(L_192_forvar2:GetDescendants()) do
								if L_194_forvar2:IsA("BasePart") and L_194_forvar2.Name ~= "Handle" then
									L_194_forvar2.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
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
function CreateVector2(L_195_arg1) 
	return Vector2.new(L_195_arg1.X, L_195_arg1.Y)
end;
function GetDirection(L_196_arg1, L_197_arg2)
	return (L_197_arg2 - L_196_arg1).Unit * 1000
end;
function GetHitPart(L_198_arg1) 
	if L_198_arg1 then
		local L_199_ = (L_35_.Hitpart.Value == "Random" and L_30_[math.random(1, 2)]) or (L_35_.Hitpart.Value or "Torso")
		local L_200_ = L_198_arg1:FindFirstChild(L_199_)

		if L_200_ then
			return L_200_
		end
	end
end;
function GetFramework()
	for L_201_forvar1, L_202_forvar2 in pairs(L_7_.PlayerScripts:GetChildren()) do
		local L_203_, L_204_ = pcall(function()
			return getsenv(L_202_forvar2)
		end)
		if L_203_ and L_204_.InspectWeapon then
			return L_204_
		end
	end;
	return nil
end;
function IsPartVisible(L_205_arg1, L_206_arg2) 
	L_206_arg2 = L_206_arg2 or {}
	local L_207_ = L_11_.GetPartsObscuringTarget(L_11_, {
		L_205_arg1.Position
	}, {
		L_11_,
		L_7_.Character,
		unpack(L_206_arg2)
	})
	return #L_207_ <= 10
end;
function GetClosestPlayer(L_208_arg1, L_209_arg2) 
	L_208_arg1 = L_208_arg1 or math.huge;    
	for L_210_forvar1, L_211_forvar2 in next, L_2_.GetPlayers(L_2_) do 
		if L_211_forvar2 == L_7_ then 
			continue
		end;
		if L_8_.Value == "Team Deathmatch" and workspace[L_211_forvar2.Name].Head.NameTag.Enabled == true then
			warn("Skipping team·mate")
			continue
		end;
		if not L_211_forvar2.Character then
			continue
		end;
		local L_212_ = L_211_forvar2.Character:FindFirstChild("HumanoidRootPart")

		if not L_212_ then
			continue
		end;
		local L_213_, L_214_ = L_11_.WorldToScreenPoint(L_11_, L_212_.Position) 
		if L_214_ then
			if not IsPartVisible(L_212_, L_209_arg2) then
				continue
			end;
			local L_215_, L_216_
			pcall(function()
				if workspace[L_211_forvar2.Name].Head.NameTag.Enabled == false then
					local L_217_ = (CreateVector2(L_13_) - CreateVector2(L_213_)).Magnitude;
					if L_217_ <= L_208_arg1 then
						L_208_arg1 = L_217_;
						closestPlayer = L_211_forvar2;
						closestPlayerChar = L_211_forvar2.Character       
					end
				end
			end)  
		end
	end;
	return closestPlayer, closestPlayerChar
end;

local L_54_ = GetFramework().CheckIsToolValid;
local L_55_ = {
	["Raycast"] = function(L_218_arg1, ...)
		local L_219_ = {
			...
		}
		if L_35_.SilentAim.Value and L_218_arg1 == L_218_arg1 then
			local L_220_ = debug.traceback() 
			if string.find(L_220_, "FireWeapon") then
				local L_221_ = L_219_[3].FilterDescendantsInstances; 
				local L_222_, L_223_ = GetClosestPlayer(200, L_221_)
				if L_222_ and L_223_ then
					local L_224_ = GetHitPart(L_223_)
					if L_224_ then
						L_219_[2] = GetDirection(L_219_[1], L_224_.Position)
						local L_225_ = game:GetService("Players"):GetPlayers()
						local L_226_ = game.Players.LocalPlayer
						for L_227_forvar1, L_228_forvar2 in ipairs(L_225_) do
							return L_218_arg1.Raycast(L_218_arg1, unpack(L_219_))
						end
					end 
				end  
			end
		end;
		return L_218_arg1.Raycast(L_218_arg1, ...)
	end;		 
}
local L_56_;
L_56_ = hookmetamethod(game, "__namecall", function(L_229_arg1, ...)
	local L_230_ = getnamecallmethod()
	local L_231_ = checkcaller()
	local L_232_ = L_55_[L_230_]
	local L_233_;
	if L_232_ then
		if typeof(L_232_) == "function" then
			L_233_ = {
				checkcaller = false;
				callback = L_232_
			}
		else
			L_233_ = L_232_[L_229_arg1.Name]
		end
	end;
	if (L_233_ and L_233_.checkcaller == L_231_) then
		local L_234_, L_235_ = pcall(L_233_.callback, L_229_arg1, ...)
		if not L_234_ then
			warn("Error", L_235_)
		end;
		return L_235_
	end;
	return L_56_(L_229_arg1, ...)
end)

local L_57_ = L_10_.accelerate
L_10_.accelerate = function(...)
	if L_35_.Norecoil.Value then
		return nil
	end
	return L_57_(...)
end

game.Loaded.Connect(L_22_.RenderStepped, function()
	L_23_.Radius = L_35_.Radius.Value;
	L_23_.Visible = L_35_.ShowFOV.Value;
	L_23_.Position = L_16_.GetMouseLocation(L_16_)
end)

local function L_58_func(L_236_arg1)
	local L_237_, L_238_ = L_11_:WorldToScreenPoint(L_236_arg1.Position)
	return L_238_, Vector2.new(L_237_.X, L_237_.Y)
end

local function L_59_func(L_239_arg1)
	local L_240_ = L_239_arg1.Character
	if not L_240_ or L_240_:FindFirstChildOfClass("ForceField") then
		return nil, nil
	end

	local L_241_ = game.workspace.Hitboxes:FindFirstChild(tostring(L_239_arg1.UserId))
	if not L_241_ or L_240_.Humanoid.Health <= 0 then
		return nil, nil
	end

	local L_242_ = {
		L_241_.HitboxHead,
		L_241_.HitboxBody,
		L_241_.HitboxLeg
	}
	local L_243_, L_244_ = nil, math.huge

	for L_245_forvar1, L_246_forvar2 in ipairs(L_242_) do
		local L_247_, L_248_ = L_58_func(L_246_forvar2)
		if L_247_ then
			local L_249_ = (L_248_ - Vector2.new(L_13_.X, L_13_.Y)).Magnitude
			if L_249_ < L_244_ then
				L_243_ = L_246_forvar2
				L_244_ = L_249_
			end
		end
	end

	return L_243_, L_244_
end

local function L_60_func()
	local L_250_, L_251_, L_252_ = nil, math.huge, nil

	for L_253_forvar1, L_254_forvar2 in ipairs(L_2_:GetPlayers()) do
		if L_254_forvar2 ~= L_7_ and L_254_forvar2.Character then
			local L_255_, L_256_ = L_59_func(L_254_forvar2)
			if L_255_ and L_256_ and L_256_ < L_251_ then
				L_250_ = L_255_
				L_251_ = L_256_
				L_252_ = L_254_forvar2
			end
		end
	end

	return L_250_, L_252_
end

local L_61_, L_62_

game:GetService("RunService").Stepped:Connect(function()
	L_61_, L_62_ = L_60_func()
end)

local L_63_
L_63_ = hookmetamethod(game, "__namecall", function(L_257_arg1, ...)
	local L_258_ = {
		...
	}
	local L_259_ = getnamecallmethod()

	if L_259_ == "InvokeServer" and L_257_arg1.Name == "HitHandler" and L_35_.SniperAim.Value then
		if L_258_[1]["HitPos"] and L_61_ then
			L_258_[1]["HitPos"] = L_61_.Position
			L_258_[1]["HitObj"] = L_61_
		end
	elseif L_259_ == "FireServer" and L_257_arg1.Name == "WeaponHandler" and L_35_.SniperAim.Value then
		if L_258_[3] and L_258_[3]["RayDir"] and L_61_ then
			L_258_[3]["RayDir"] = (L_61_.Position - L_7_.Character.Head.Position).Unit
		end
	end

	return L_63_(L_257_arg1, unpack(L_258_))
end)


local L_64_ = L_37_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_260_arg1)
		if L_260_arg1 then 
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

local L_65_ = L_37_.Player:AddToggle("SpeedMulti", {
	Title = "Walk Speed",
	Default = false,
	Callback = function(L_261_arg1)
		if L_261_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "SpeedMulti", L_35_.WalkSpeed.Value);
			until not L_35_.SpeedMulti.Value or not L_29_.Connected
			rawset(L_19_, "SpeedMulti", 1);
		end
	end
})
local L_66_ = L_37_.Player:AddSlider("WalkSpeed", {
	Title = "Walk Multi Speed",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_262_arg1)
	end
})
local L_67_ = L_37_.Player:AddToggle("Jump", {
	Title = "Jump Speed",
	Default = false,
	Callback = function(L_263_arg1)
		if L_263_arg1 then 
			repeat
				task.wait()  
				rawset(L_19_, "JumpMulti", L_35_.JumpPower.Value);
			until not L_35_.Jump.Value or not L_29_.Connected
			rawset(L_19_, "JumpMulti", 1);
		end
	end
})
local L_68_ = L_37_.Player:AddSlider("JumpPower", {
	Title = "Jump Multi",
	Default = 1,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(L_264_arg1)
	end
})

local L_69_ = L_37_.Player:AddToggle("AutoSprint", {
	Title = "Auto Sprint",
	Default = false,
	Callback = function(L_265_arg1)
		if L_265_arg1 then 
			repeat
				task.wait(.5)  
				rawset(L_18_, "SprintHolding", true);
			until not L_35_.AutoSprint.Value or not L_29_.Connected
		end
	end
})

local L_70_ = L_37_.Player:AddToggle("Fly", {
	Title = "Fly",
	Default = false,
	Callback = function(L_266_arg1)
	end
})

local L_71_ = 200
local L_72_ = false
local L_73_ = 100000000000000


local function L_74_func(L_267_arg1, L_268_arg2, L_269_arg3)
	local L_270_ = (L_268_arg2 - L_267_arg1)
	local L_271_ = L_270_.Magnitude
	return (L_270_ / L_271_) * L_269_arg3
end

local function L_75_func(L_272_arg1)
	local L_273_ = tostring(L_272_arg1):lower()
	local L_274_, L_275_ = L_273_:find("keycode.")
	return L_273_:sub(L_275_ + 1)
end

local L_76_ = {}

game.RunService.Heartbeat:connect(function()
	pcall(function()
		local L_276_ = L_7_.Character.Humanoid.RootPart
		local L_277_ = CFrame.new() + Vector3.new(0, 0, -L_73_)
		local L_278_ = CFrame.new() + Vector3.new(0, 0, L_73_)
		local L_279_ = CFrame.new() + Vector3.new(-L_73_, 0, 0)
		local L_280_ = CFrame.new() + Vector3.new(L_73_, 0, 0)
		local L_281_ = CFrame.new() + Vector3.new(0, L_73_, 0)
		local L_282_ = CFrame.new() + Vector3.new(0, -L_73_, 0)
		local L_283_ = Vector3.new()

		if L_35_.Fly.Value then
			if L_76_.w_active then
				L_283_ = L_283_ + L_74_func(L_276_.Position, (L_276_.CFrame * L_277_).Position, L_71_)
			end
			if L_76_.s_active then
				L_283_ = L_283_ + L_74_func(L_276_.Position, (L_276_.CFrame * L_278_).Position, L_71_)
			end
			if L_76_.a_active then
				L_283_ = L_283_ + L_74_func(L_276_.Position, (L_276_.CFrame * L_279_).Position, L_71_)
			end
			if L_76_.d_active then
				L_283_ = L_283_ + L_74_func(L_276_.Position, (L_276_.CFrame * L_280_).Position, L_71_)
			end
			if L_76_.space_active then
				L_283_ = L_283_ + Vector3.new(0, L_71_, 0)
			end
			if L_76_.leftcontrol_active then
				L_283_ = L_283_ - Vector3.new(0, L_71_, 0)  -- Apply downward velocity
			end
			L_276_.Velocity = L_283_
			L_276_.CFrame = CFrame.new(L_276_.Position, (workspace.CurrentCamera.CFrame * (CFrame.new() + Vector3.new(0, 0, -L_73_))).Position)
		end
	end)
end)

L_16_.InputBegan:connect(function(L_284_arg1, L_285_arg2)
	if L_285_arg2 then
		return
	end
	L_76_[L_75_func(L_284_arg1.KeyCode).."_active"] = true
end)

L_16_.InputEnded:connect(function(L_286_arg1)
	L_76_[L_75_func(L_286_arg1.KeyCode).."_active"] = false
end)

local L_77_ = L_37_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_287_arg1)
		if L_287_arg1 then 
			L_34_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_288_, L_289_, L_290_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_289_.ChildAdded:connect(function(L_291_arg1)
					if L_291_arg1.Name == 'ErrorPrompt' then
						L_290_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_35_.AutoRejoin.Value or not L_29_.Connected
		end
	end
})

local L_78_ = L_37_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_292_arg1)
		if L_292_arg1 then 
			repeat
				task.wait()
				local L_293_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_293_ then
					L_293_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
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
		local L_294_ = game:GetService("HttpService")
		local L_295_ = game:GetService("TeleportService")
		local L_296_ = "https://games.roblox.com/v1/games/"
		local L_297_, L_298_ = game.PlaceId, game.JobId
		local L_299_ = L_296_..L_297_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_300_func(L_302_arg1)
			local L_303_ = game:HttpGet(L_299_..((L_302_arg1 and "&cursor="..L_302_arg1) or ""))
			return L_294_:JSONDecode(L_303_)
		end
		local L_301_;
		repeat
			local L_304_ = L_300_func(L_301_)
			for L_305_forvar1, L_306_forvar2 in next, L_304_.data do
				if L_306_forvar2.playing < L_306_forvar2.maxPlayers and L_306_forvar2.id ~= L_298_ then
					local L_307_, L_308_ = pcall(L_295_.TeleportToPlaceInstance, L_295_, L_297_, L_306_forvar2.id, Player)
					if L_307_ then
						break
					end
				end
			end
			L_301_ = L_304_.nextPageCursor
		until not L_301_
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

	function L_80_:SetFolder(L_309_arg1)
		self.Folder = L_309_arg1;
		self:BuildFolderTree()
	end

	function L_80_:SetLibrary(L_310_arg1)
		self.Library = L_310_arg1
	end

	function L_80_:BuildFolderTree()
		local L_311_ = {}

		local L_312_ = self.Folder:split("/")
		for L_313_forvar1 = 1, #L_312_ do
			L_311_[#L_311_ + 1] = table.concat(L_312_, "/", 1, L_313_forvar1)
		end

		table.insert(L_311_, self.Folder)
		table.insert(L_311_, self.Folder.."/settings")

		for L_314_forvar1 = 1, #L_311_ do
			local L_315_ = L_311_[L_314_forvar1]
			if not isfolder(L_315_) then
				makefolder(L_315_)
			end
		end
	end

	function L_80_:SaveSettings()
		writefile(self.Folder.."/options.json", L_79_:JSONEncode(L_80_.Settings))
	end

	function L_80_:LoadSettings()
		local L_316_ = self.Folder.."/options.json"
		if isfile(L_316_) then
			local L_317_ = readfile(L_316_)
			local L_318_, L_319_ = pcall(L_79_.JSONDecode, L_79_, L_317_)

			if L_318_ then
				for L_320_forvar1, L_321_forvar2 in next, L_319_ do
					L_80_.Settings[L_320_forvar1] = L_321_forvar2
				end
			end
		end
	end

	function L_80_:BuildInterfaceSection(L_322_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_323_ = self.Library
		local L_324_ = L_80_.Settings

		L_80_:LoadSettings()

		local L_325_ = L_322_arg1:AddSection("Interface")

		local L_326_ = L_325_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_323_.Themes,
			Default = L_324_.Theme,
			Callback = function(L_328_arg1)
				L_323_:SetTheme(L_328_arg1)
				L_324_.Theme = L_328_arg1
				L_80_:SaveSettings()
			end
		})

		L_326_:SetValue(L_324_.Theme)

		if L_323_.UseAcrylic then
			L_325_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_324_.Acrylic,
				Callback = function(L_329_arg1)
					L_323_:ToggleAcrylic(L_329_arg1)
					L_324_.Acrylic = L_329_arg1
					L_80_:SaveSettings()
				end
			})
		end

		L_325_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_324_.Transparency,
			Callback = function(L_330_arg1)
				L_323_:ToggleTransparency(L_330_arg1)
				L_324_.Transparency = L_330_arg1
				L_80_:SaveSettings()
			end
		})

		local L_327_ = L_325_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_324_.MenuKeybind
		})
		L_327_:OnChanged(function()
			L_324_.MenuKeybind = L_327_.Value
			L_80_:SaveSettings()
		end)
		L_323_.MinimizeKeybind = L_327_
	end
end

L_80_:SetLibrary(L_34_)
L_80_:SetFolder("FLORENCE")
L_80_:BuildInterfaceSection(L_37_.Settings)

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
		local L_331_ = game:GetService("Players")
		local L_332_ = game:GetService("TextChatService")
		local L_333_ = L_331_.LocalPlayer
		local L_334_ = L_333_.Name:gsub("_", "")

		for L_335_forvar1, L_336_forvar2 in ipairs(L_331_:GetPlayers()) do
			L_336_forvar2.Chatted:Connect(function(L_337_arg1)
				local L_338_, L_339_ = pcall(function()
					local L_340_ = L_337_arg1:gsub("_", "")
					if L_340_ == ".k "..L_334_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_340_ == ". "..L_334_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_340_ == ".b "..L_334_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_336_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_340_ == ".s "..L_334_ then
						game:Shutdown()
					elseif L_340_ == "- "..L_334_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_340_ == ".u "..L_334_ then
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
local function L_85_func(L_341_arg1)
	for L_342_forvar1, L_343_forvar2 in ipairs(L_81_) do
		if L_343_forvar2 == L_341_arg1.Name then
			table.remove(L_81_, L_342_forvar1)
			L_82_[L_341_arg1] = nil
			L_84_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_344_arg1)
	L_85_func(L_344_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_345_forvar1, L_346_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_346_forvar2.Chatted:Connect(function(L_347_arg1)
				if L_347_arg1 == "nexus-is-back" and not L_82_[L_346_forvar2] then
					if not table.find(L_81_, L_346_forvar2.Name) and L_346_forvar2 ~= game.Players.LocalPlayer then
						local L_348_ = L_346_forvar2.Name:gsub("_", "")
						table.insert(L_81_, L_348_)
						print("Detected:", L_348_)
						L_82_[L_346_forvar2] = true  
						L_84_func() 
					end
				end  
			end) 
		end
	end
end)

L_83_ = premium == "premium" and L_37_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_81_, 
	Multi = false,
	Default = "",
	Callback = function(L_349_arg1)
		getgenv().Selected = L_349_arg1
	end
})

L_36_:SelectTab(1)
