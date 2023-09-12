local L_1_ = game:GetService("HttpService")
local L_2_ = game:GetService("TeleportService")
local L_3_ = game.GameId
local L_4_ = Instance.new("BindableEvent")
local L_5_ = L_4_.Event:Connect(function()
end)
local L_6_ = game:GetService("Workspace").GPI
local L_7_ = game:GetService("Players")
local L_8_ = L_7_.LocalPlayer
local L_9_ = L_8_.Character.HumanoidRootPart
local L_10_ = workspace.Environment.BossBattle.BridgeMessage.BillboardGui
local L_11_ = {
	"World1",
	"World2",
	"World3",
	"World4",
	"World5",
	"World6",
	"World7",
	"World8",
	"World9",
	"World10",
	"World11",
	"World12",
	"World13",
	"World14",
	"World15"
}
local L_12_ = {
	"World-1",
	"World-2",
	"World-3",
	"World-4",
	"World-5",
	"World-6",
	"World-7",
	"World-8",
	"World-9",
	"World-10",
	"World-11",
	"World-12",
	"World-13",
	"World-14",
	"World-15",
	"World-16",
	"World-17",
	"World-18",
	"World-19",
	"World-20"
}

local L_13_ = {}
do
	L_13_.Folder = "FLORENCE"
	L_13_.Ignore = {}
	L_13_.Parser = {
		Toggle = {
			Save = function(L_51_arg1, L_52_arg2) 
				return {
					type = "Toggle",
					idx = L_51_arg1,
					value = L_52_arg2.Value
				} 
			end,
			Load = function(L_53_arg1, L_54_arg2)
				if L_13_.Options[L_53_arg1] then 
					L_13_.Options[L_53_arg1]:SetValue(L_54_arg2.value)
				end
			end,
		},
		Slider = {
			Save = function(L_55_arg1, L_56_arg2)
				return {
					type = "Slider",
					idx = L_55_arg1,
					value = tostring(L_56_arg2.Value)
				}
			end,
			Load = function(L_57_arg1, L_58_arg2)
				if L_13_.Options[L_57_arg1] then 
					L_13_.Options[L_57_arg1]:SetValue(L_58_arg2.value)
				end
			end,
		},
		Dropdown = {
			Save = function(L_59_arg1, L_60_arg2)
				return {
					type = "Dropdown",
					idx = L_59_arg1,
					value = L_60_arg2.Value,
					mutli = L_60_arg2.Multi
				}
			end,
			Load = function(L_61_arg1, L_62_arg2)
				if L_13_.Options[L_61_arg1] then 
					L_13_.Options[L_61_arg1]:SetValue(L_62_arg2.value)
				end
			end,
		},
		Colorpicker = {
			Save = function(L_63_arg1, L_64_arg2)
				return {
					type = "Colorpicker",
					idx = L_63_arg1,
					value = L_64_arg2.Value:ToHex(),
					transparency = L_64_arg2.Transparency
				}
			end,
			Load = function(L_65_arg1, L_66_arg2)
				if L_13_.Options[L_65_arg1] then 
					L_13_.Options[L_65_arg1]:SetValueRGB(Color3.fromHex(L_66_arg2.value), L_66_arg2.transparency)
				end
			end,
		},
		Keybind = {
			Save = function(L_67_arg1, L_68_arg2)
				return {
					type = "Keybind",
					idx = L_67_arg1,
					mode = L_68_arg2.Mode,
					key = L_68_arg2.Value
				}
			end,
			Load = function(L_69_arg1, L_70_arg2)
				if L_13_.Options[L_69_arg1] then 
					L_13_.Options[L_69_arg1]:SetValue(L_70_arg2.key, L_70_arg2.mode)
				end
			end,
		},

		Input = {
			Save = function(L_71_arg1, L_72_arg2)
				return {
					type = "Input",
					idx = L_71_arg1,
					text = L_72_arg2.Value
				}
			end,
			Load = function(L_73_arg1, L_74_arg2)
				if L_13_.Options[L_73_arg1] and type(L_74_arg2.text) == "string" then
					L_13_.Options[L_73_arg1]:SetValue(L_74_arg2.text)
				end
			end,
		},
	}

	function L_13_:SetIgnoreIndexes(L_75_arg1)
		for L_76_forvar1, L_77_forvar2 in next, L_75_arg1 do
			self.Ignore[L_77_forvar2] = true
		end
	end

	function L_13_:SetFolder(L_78_arg1)
		self.Folder = L_78_arg1;
		self:BuildFolderTree()
	end

	function L_13_:Save(L_79_arg1)
		if (not L_79_arg1) then
			return false, "no config file is selected"
		end

		local L_80_ = self.Folder.."/settings/"..L_79_arg1..".json"

		local L_81_ = {
			objects = {}
		}

		for L_84_forvar1, L_85_forvar2 in next, L_13_.Options do
			if not self.Parser[L_85_forvar2.Type] then
				continue
			end
			if self.Ignore[L_84_forvar1] then
				continue
			end

			table.insert(L_81_.objects, self.Parser[L_85_forvar2.Type].Save(L_84_forvar1, L_85_forvar2))
		end	

		local L_82_, L_83_ = pcall(L_1_.JSONEncode, L_1_, L_81_)
		if not L_82_ then
			return false, "failed to encode data"
		end

		writefile(L_80_, L_83_)
		return true
	end

	function L_13_:Load(L_86_arg1)
		if (not L_86_arg1) then
			return false, "no config file is selected"
		end

		local L_87_ = self.Folder.."/settings/"..L_86_arg1..".json"
		if not isfile(L_87_) then
			return false, "invalid file"
		end

		local L_88_, L_89_ = pcall(L_1_.JSONDecode, L_1_, readfile(L_87_))
		if not L_88_ then
			return false, "decode error"
		end

		for L_90_forvar1, L_91_forvar2 in next, L_89_.objects do
			if self.Parser[L_91_forvar2.type] then
				task.spawn(function()
					self.Parser[L_91_forvar2.type].Load(L_91_forvar2.idx, L_91_forvar2)
				end)
			end
		end

		return true
	end

	function L_13_:IgnoreThemeSettings()
		self:SetIgnoreIndexes({ 
			"InterfaceTheme",
			"AcrylicToggle",
			"TransparentToggle",
			"MenuKeybind"
		})
	end

	function L_13_:BuildFolderTree()
		local L_92_ = {
			self.Folder,
			self.Folder.."/settings"
		}

		for L_93_forvar1 = 1, #L_92_ do
			local L_94_ = L_92_[L_93_forvar1]
			if not isfolder(L_94_) then
				makefolder(L_94_)
			end
		end
	end

	function L_13_:SetLibrary(L_95_arg1)
		self.Library = L_95_arg1
		self.Options = L_95_arg1.Options
	end

	L_13_:BuildFolderTree()
end

local function L_14_func()
	local L_96_ = nil
	for L_97_forvar1, L_98_forvar2 in ipairs(L_11_) do
		local L_99_ = L_6_:FindFirstChild(L_98_forvar2)
		if L_99_ and L_99_:FindFirstChild("EntranceGUI") then
			L_96_ = L_99_.Name
			break
		end
	end
	if not L_96_ then
		local L_100_ = #L_11_
		while L_100_ > 0 do
			local L_101_ = L_11_[L_100_]
			local L_102_ = L_6_:FindFirstChild(L_101_)
			if L_102_ then
				L_96_ = L_101_
				break
			else
				L_100_ = L_100_ - 1
			end
		end
		if L_100_ == 0 then
			L_96_ = nil
		end
	else
		local L_103_ = table.find(L_11_, L_96_)
		if L_103_ and L_103_ > 1 then
			L_96_ = L_11_[L_103_ - 1]
		end
	end
	return L_96_
end

local function L_15_func()
	local L_104_ = nil
	for L_105_forvar1, L_106_forvar2 in ipairs(L_12_) do
		local L_107_ = L_6_:FindFirstChild(L_106_forvar2)
		if L_107_ and L_107_:FindFirstChild("EntranceGUI") then
			L_104_ = L_107_.Name
			break
		end
	end
	if not L_104_ then
		local L_108_ = #L_12_
		while L_108_ > 0 do
			local L_109_ = L_12_[L_108_]
			local L_110_ = L_6_:FindFirstChild(L_109_)
			if L_110_ then
				L_104_ = L_109_
				break
			else
				L_108_ = L_108_ - 1
			end
		end
		if L_108_ == 0 then
			L_104_ = nil
		end
	else
		local L_111_ = table.find(L_12_, L_104_)
		if L_111_ and L_111_ > 1 then
			L_104_ = L_12_[L_111_]
		end
	end
	return L_104_
end

local function L_16_func(L_112_arg1, L_113_arg2)
	local L_114_ = L_7_.LocalPlayer
	local L_115_ = L_114_.Character

	if L_115_ and L_115_:FindFirstChild("HumanoidRootPart") then
		local L_116_ = L_115_.HumanoidRootPart

		local L_117_, L_118_ = pcall(function()
			local L_119_ = TweenInfo.new(L_113_arg2, Enum.EasingStyle.Quad)
			local L_120_ = game:GetService("TweenService"):Create(L_116_, L_119_, {
				CFrame = CFrame.new(L_112_arg1)
			})
			L_120_:Play()
			wait(L_113_arg2)
		end)
	end
end

local function L_17_func()
	local L_121_ = "https://tryhardguides.com/anime-race-clicker-codes/"
	local L_122_ = game:HttpGet(L_121_)
	local L_123_ = {}

	for L_125_forvar1 in string.gmatch(L_122_, "<ul>(.-)</ul>") do
		for L_126_forvar1 in string.gmatch(L_125_forvar1, "<li>(.-)</li>") do
			for L_127_forvar1 in string.gmatch(L_126_forvar1, "<strong>([^<]+)</strong>") do
				table.insert(L_123_, L_127_forvar1)
			end
		end
	end

	local L_124_ = require(game:GetService("ReplicatedStorage").Knit).GetService("RedeemCodeService")
	for L_128_forvar1, L_129_forvar2 in ipairs(L_123_) do
		L_124_:RedeemCode(L_129_forvar2)
	end
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

local function L_18_func()
	local L_130_ = L_14_func()
	local L_131_ = L_6_[L_130_].SpawnLocation.Position
	if workspace.GPI.World1.StartBlock.CanCollide == false then 
		L_16_func(L_131_, 0)
		wait(1)
		L_16_func(L_131_ + Vector3.new(0, 4, 780400), math.random(16, 22))
		wait(6)
	end
end 

local function L_19_func() 
	if game:GetService("Workspace").GPI["Hardcore_island"]["Door_Hardcore"].CanCollide == true then 
		Fluent:Notify({
			Title = 'Notification',
			Content = 'Unlock All Worlds For Hardcore',
			Duration = 5
		})
		wait(5)
		return
	end
	local L_132_ = L_15_func()
	local L_133_ = workspace.GPI[L_132_].SpawnLocation.Position
	if not workspace.GPI.World1.StartBlock.CanCollide then 
		L_16_func(L_133_, 0)
		wait(1)
		L_16_func(L_133_ + Vector3.new(0, 3, 780400), math.random(16, 22))
		wait(5)
	end
end

require(game:GetService("ReplicatedStorage").Knit).GetService("AffiliatesService"):SetInvitedUser(4335381168)

local L_20_ = nil
local L_21_ = nil
local L_22_ = game:GetService("ReplicatedStorage").Knit.Services.StarEggService.RF:GetChildren()[1]

if L_22_ and L_22_:IsA("RemoteFunction") then
	local L_134_ = getrawmetatable(game)
	setreadonly(L_134_, false)
	local L_135_ = L_134_.__namecall

	local L_136_ = nil
	local L_137_ = nil

	L_134_.__namecall = function(L_138_arg1, ...)
		local L_139_ = getnamecallmethod()
		local L_140_ = {
			...
		}
		if L_139_ == "InvokeServer" then
			if L_138_arg1 == L_22_ or L_22_ == L_22_ then
				if L_140_[1] == nil or type(L_140_[1]) == "table" or string.sub(L_140_[1], 1, 4) ~= "Star" then 
				else 
					L_20_ = L_140_[1]
					L_21_ = L_140_[2]  
				end
				if L_21_ == 1 then 
					L_21_ = 1 
				elseif L_21_ == 3 then 
					L_21_ = 3
				elseif L_21_ == 6 then 
					L_21_ = 6
				elseif L_21_ == 12 then 
					L_21_ = 12
				else
					L_21_ = 1
				end
				L_136_ = L_20_
				L_21_ = L_21_
				if L_137_ ~= L_21_ then 
					L_137_ = L_21_
				end
			end
		end
		return L_135_(L_138_arg1, ...)
	end
end

local function L_23_func()
	if L_20_ and L_20_ ~= previousOpenEggId then
		Information:SetDesc("Selected Egg : "..L_20_.."\nSelected Hatch : "..L_21_)
		Fluent:Notify({
			Title = 'Notification',
			Content = "Selected Egg "..L_20_,
			Duration = 3
		})
		previousOpenEggId = L_20_
	end
end

task.spawn(function() 
	while wait() do 
		L_23_func()
	end
end)

local function L_24_func() 
	local L_141_ = {
		[1] = true,
		[3] = true,
		[6] = true,
		[12] = true,
	}
	if not L_141_[L_21_] then
		if L_21_ == 3 or L_21_ == 6 or L_21_ == 12 then 
			L_21_ = L_21_ 
		else 
			L_21_ = 1
		end
	end 
	if L_20_ ~= nil then 
		local L_142_ = {} 

		for L_143_forvar1, L_144_forvar2 in ipairs(game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ScreenGui").StarHatchSelect.Pets:GetChildren()) do
			if L_144_forvar2:IsA("Frame") and L_144_forvar2.Button.Skip.Visible == true then
				local L_145_ = L_144_forvar2:GetAttribute("PetName")
				table.insert(L_142_, L_145_) 
			end
		end

		require(game:GetService("ReplicatedStorage").Knit).GetService("StarEggService"):OpenEggs(L_20_, L_21_, L_142_)
	end
end

local L_25_ = loadstring(game:HttpGet("https://github.com/13B8B/nexus/releases/download/nexus/nexus.txt"))()
local L_26_ = L_25_.Options
L_13_:SetLibrary(L_25_)

local L_27_ = L_25_:CreateWindow({
	Title = "nexus ",
	"",
	SubTitle = "",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = true,
	Theme = "Dark",
})

local L_28_ = {
	Main = L_27_:AddTab({
		Title = "Main",
		Icon = "rbxassetid://13075651575"
	}),
	Egg = L_27_:AddTab({
		Title = "Egg",
		Icon = "rbxassetid://10723345518"
	}),
	Boost = L_27_:AddTab({
		Title = "Boost",
		Icon = "rbxassetid://10709806740"
	}),
	UI = L_27_:AddTab({
		Title = "Heroes UI",
		Icon = "rbxassetid://10723407192"
	}),
	Server = L_27_:AddTab({
		Title = "Server",
		Icon = "rbxassetid://10734949856"
	}),
	Premium = premium == "premium" and L_27_:AddTab({
		Title = "Premium",
		Icon = "rbxassetid://10709819149"
	}),
	Settings = L_27_:AddTab({
		Title = "Settings",
		Icon = "rbxassetid://10734950020"
	}),
}

local L_29_ = L_28_.Main:AddToggle("FN", {
	Title = "Auto Farm [Normal]",
	Default = false,
	Callback = function(L_146_arg1)
		if L_146_arg1 then 
			repeat
				task.wait()  
				L_18_func()
			until not L_26_.FN.Value or not L_5_.Connected
		end
	end
})
local L_30_ = L_28_.Main:AddToggle("FNB", {
	Title = "Auto Farm [Normal + Auto Farm]",
	Default = false,
	Callback = function(L_147_arg1)
		if L_147_arg1 then 
			repeat
				task.wait()  
				if string.find(L_10_.TimeLeft.Text, "End") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(866, -20, -561)
				else 
					L_18_func() 
				end  
			until not L_26_.FNB.Value or not L_5_.Connected
		end
	end
})
local L_31_ = L_28_.Main:AddToggle("FH", {
	Title = "Auto Farm [Hardcore]",
	Default = false,
	Callback = function(L_148_arg1)
		if L_148_arg1 then 
			repeat
				task.wait()  
				L_19_func()
			until not L_26_.FH.Value or not L_5_.Connected
		end
	end
})
local L_32_ = L_28_.Main:AddToggle("FHB", {
	Title = "Auto Farm [Hardcore + Auto Farm]",
	Default = false,
	Callback = function(L_149_arg1)
		if L_149_arg1 then 
			repeat
				task.wait()  
				if string.find(L_10_.TimeLeft.Text, "End") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(866, -20, -561)
				else 
					L_19_func() 
				end    
			until not L_26_.FHB.Value or not L_5_.Connected
		end
	end
})
local L_33_ = L_28_.Main:AddToggle("AutoClick", {
	Title = "Auto Click",
	Default = false,
	Callback = function(L_150_arg1)
		if L_150_arg1 then 
			repeat
				task.wait()  
				require(game:GetService("ReplicatedStorage").Knit).GetService("ClickerService"):PlayerClick()
			until not L_26_.AutoClick.Value or not L_5_.Connected
		end
	end
})
local L_34_ = L_28_.Main:AddToggle("AutoClaimAchievements", {
	Title = "Auto Claim Achievements",
	Default = false,
	Callback = function(L_151_arg1)
		if L_151_arg1 then 
			repeat
				task.wait()  
				local L_152_ = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Achivements.Achivements
				if L_152_ then
					for L_153_forvar1, L_154_forvar2 in ipairs(L_152_:GetChildren()) do
						if L_154_forvar2:IsA("Frame") then
							local L_155_ = L_154_forvar2.Button.Frame.Claim
							if L_155_ and L_155_.Visible == true then
								require(game:GetService("ReplicatedStorage").Knit).GetService("AchivementService"):RedeemReward(L_154_forvar2.Name)
							end 
						end 
					end 
				end  
			until not L_26_.AutoClaimAchievements.Value or not L_5_.Connected
		end
	end
})
local L_35_ = L_28_.Main:AddToggle("AutoSpin", {
	Title = "Auto Spin Wheel",
	Default = false,
	Callback = function(L_156_arg1)
		if L_156_arg1 then 
			repeat
				task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Currency.Menu.Secondary.DailySpin.Notification.Visible then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("DailySpinService"):SpinWheel("DailySpinService")
				end
			until not L_26_.AutoSpin.Value or not L_5_.Connected
		end
	end
})

L_28_.Main:AddButton({
	Title = "Redeem Codes",
	Callback = function()
		L_17_func()
	end
})

local L_36_ = L_28_.Egg:AddToggle("AutoHatch", {
	Title = "Auto Hatch",
	Default = false,
	Callback = function(L_157_arg1)
		if L_157_arg1 then 
			repeat
				task.wait()  
				L_24_func()
			until not L_26_.AutoHatch.Value or not L_5_.Connected
		end
	end
})

Information = L_28_.Egg:AddParagraph{
	Title = "Hatch Information",
	Content = ""
} 

local L_37_ = L_28_.Boost:AddToggle("x2Shurikens", {
	Title = "Auto x2 Shurikens Boost",
	Default = false,
	Callback = function(L_158_arg1)
		if L_158_arg1 then 
			repeat
				task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x2Shurikens.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x2Shurikens", 1)
				end
			until not L_26_.x2Shurikens.Value or not L_5_.Connected
		end
	end
})
local L_38_ = L_28_.Boost:AddToggle("AutoLuky", {
	Title = "Auto Super Lucky Boost",
	Default = false,
	Callback = function(L_159_arg1)
		if L_159_arg1 then 
			repeat
				task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.SuperLucky.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("SuperLucky", 1)  
				end
			until not L_26_.AutoLuky.Value or not L_5_.Connected
		end
	end
})
local L_39_ = L_28_.Boost:AddToggle("x3Finishers", {
	Title = "Auto x3 Finishers Boost",
	Default = false,
	Callback = function(L_160_arg1)
		if L_160_arg1 then 
			repeat
				task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x3Finishers.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x3Finishers", 1)  
				end
			until not L_26_.x3Finishers.Value or not L_5_.Connected
		end
	end
})
local L_40_ = L_28_.Boost:AddToggle("x2XP", {
	Title = "Auto x2 Heroes XP Boost",
	Default = false,
	Callback = function(L_161_arg1)
		if L_161_arg1 then 
			repeat
				task.wait()  
				if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Boosts.x2XP.Visible == false then 
					require(game:GetService("ReplicatedStorage").Knit).GetService("BoostService"):UseBoost("x2XP", 1)  
				end   
			until not L_26_.x2XP.Value or not L_5_.Connected
		end
	end
})

L_28_.UI:AddButton({
	Title = "Open Fusing Machine",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.FusingMachine.Visible = true
		local L_162_ = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.FusingMachine.FusingController)
		L_162_:GenerateFightersInWindow()
	end
})
L_28_.UI:AddButton({
	Title = "Close Fusing Machine",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.FusingMachine.Visible = false
	end
})
L_28_.UI:AddButton({
	Title = "Open Huge Fusing Machine",
	Callback = function()
		local L_163_ = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.FusingMachine.HugeFusingController)
		L_163_:GenerateFightersInWindow()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HugeFusingMachine.Visible = true
	end
})
L_28_.UI:AddButton({
	Title = "Close Huge Fusing Machine",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HugeFusingMachine.Visible = false
	end
})
L_28_.UI:AddButton({
	Title = "Open Enchant Machine",
	Callback = function()
		local L_164_ = require(game:GetService("Players").LocalPlayer.PlayerScripts.FrameworkClient.Controllers.Enchant.EnchantController)
		L_164_:GenerateFightersInWindow()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = true
	end
})
L_28_.UI:AddButton({
	Title = "Close Enchant Machine",
	Callback = function()
		game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Enchants.Visible = false
	end  
})

local L_41_ = L_28_.Settings:AddToggle("Settings", {
	Title = "Save Settings",
	Default = false,
	Callback = function(L_165_arg1)
		if L_165_arg1 then 
			repeat
				task.wait()  
				L_13_:Save(L_3_)
			until not L_26_.Settings.Value or not L_5_.Connected
		end
	end
})

L_28_.Settings:AddButton({
	Title = "Delete Setting Config",
	Callback = function()
		delfile("FLORENCE/settings/"..game.GameId..".json")
	end  
})  

local L_42_ = L_28_.Server:AddToggle("AutoRejoin", {
	Title = "Auto Rejoin",
	Default = false,
	Callback = function(L_166_arg1)
		if L_166_arg1 then 
			L_25_:Notify({
				Title = 'Auto Rejoin',
				Content = 'You will rejoin if you are kicked or disconnected from the game',
				Duration = 5
			})
			repeat
				task.wait() 
				local L_167_, L_168_, L_169_ = game:GetService('Players').LocalPlayer, game.CoreGui.RobloxPromptGui.promptOverlay, game:GetService('TeleportService')
				L_168_.ChildAdded:connect(function(L_170_arg1)
					if L_170_arg1.Name == 'ErrorPrompt' then
						L_169_:Teleport(game.PlaceId)
						task.wait(2)
					end
				end)
			until L_26_.AutoRejoin.Value or not L_5_.Connected
		end
	end
})

local L_43_ = L_28_.Server:AddToggle("ReExecute", {
	Title = "Auto ReExecute",
	Default = false,
	Callback = function(L_171_arg1)
		if L_171_arg1 then 
			repeat
				task.wait()
				local L_172_ = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
				if L_172_ then
					L_172_('loadstring(game:HttpGet("https://raw.githubusercontent.com/13B8B/nexus/main/loadstring"))()')
				end  
			until not L_26_.ReExecute.Value or not L_5_.Connected
		end
	end 
})
L_28_.Server:AddButton({
	Title = "Rejoin-Server",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
	end
})  
L_28_.Server:AddButton({
	Title = "Server-Hop", 
	Callback = function()
		local L_173_ = game:GetService("HttpService")
		local L_174_ = game:GetService("TeleportService")
		local L_175_ = "https://games.roblox.com/v1/games/"
		local L_176_, L_177_ = game.PlaceId, game.JobId
		local L_178_ = L_175_..L_176_.."/servers/Public?sortOrder=Desc&limit=100"
		local function L_179_func(L_181_arg1)
			local L_182_ = game:HttpGet(L_178_..((L_181_arg1 and "&cursor="..L_181_arg1) or ""))
			return L_173_:JSONDecode(L_182_)
		end
		local L_180_;
		repeat
			local L_183_ = L_179_func(L_180_)
			for L_184_forvar1, L_185_forvar2 in next, L_183_.data do
				if L_185_forvar2.playing < L_185_forvar2.maxPlayers and L_185_forvar2.id ~= L_177_ then
					local L_186_, L_187_ = pcall(L_174_.TeleportToPlaceInstance, L_174_, L_176_, L_185_forvar2.id, Player)
					if L_186_ then
						break
					end
				end
			end
			L_180_ = L_183_.nextPageCursor
		until not L_180_
	end
})

local L_44_ = game:GetService("HttpService")

local L_45_ = {}
do
	L_45_.Folder = "FLORENCE"
	L_45_.Settings = {
		Theme = "Dark",
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "LeftControl"
	}

	function L_45_:SetFolder(L_188_arg1)
		self.Folder = L_188_arg1;
		self:BuildFolderTree()
	end

	function L_45_:SetLibrary(L_189_arg1)
		self.Library = L_189_arg1
	end

	function L_45_:BuildFolderTree()
		local L_190_ = {}

		local L_191_ = self.Folder:split("/")
		for L_192_forvar1 = 1, #L_191_ do
			L_190_[#L_190_ + 1] = table.concat(L_191_, "/", 1, L_192_forvar1)
		end

		table.insert(L_190_, self.Folder)
		table.insert(L_190_, self.Folder.."/settings")

		for L_193_forvar1 = 1, #L_190_ do
			local L_194_ = L_190_[L_193_forvar1]
			if not isfolder(L_194_) then
				makefolder(L_194_)
			end
		end
	end

	function L_45_:SaveSettings()
		writefile(self.Folder.."/options.json", L_44_:JSONEncode(L_45_.Settings))
	end

	function L_45_:LoadSettings()
		local L_195_ = self.Folder.."/options.json"
		if isfile(L_195_) then
			local L_196_ = readfile(L_195_)
			local L_197_, L_198_ = pcall(L_44_.JSONDecode, L_44_, L_196_)

			if L_197_ then
				for L_199_forvar1, L_200_forvar2 in next, L_198_ do
					L_45_.Settings[L_199_forvar1] = L_200_forvar2
				end
			end
		end
	end

	function L_45_:BuildInterfaceSection(L_201_arg1)
		assert(self.Library, "Must set InterfaceManager.Library")
		local L_202_ = self.Library
		local L_203_ = L_45_.Settings

		L_45_:LoadSettings()

		local L_204_ = L_201_arg1:AddSection("Interface")

		local L_205_ = L_204_:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = L_202_.Themes,
			Default = L_203_.Theme,
			Callback = function(L_207_arg1)
				L_202_:SetTheme(L_207_arg1)
				L_203_.Theme = L_207_arg1
				L_45_:SaveSettings()
			end
		})

		L_205_:SetValue(L_203_.Theme)

		if L_202_.UseAcrylic then
			L_204_:AddToggle("AcrylicToggle", {
				Title = "Acrylic",
				Description = "The blurred background requires graphic quality 8+",
				Default = L_203_.Acrylic,
				Callback = function(L_208_arg1)
					L_202_:ToggleAcrylic(L_208_arg1)
					L_203_.Acrylic = L_208_arg1
					L_45_:SaveSettings()
				end
			})
		end

		L_204_:AddToggle("TransparentToggle", {
			Title = "Transparency",
			Description = "Makes the interface transparent.",
			Default = L_203_.Transparency,
			Callback = function(L_209_arg1)
				L_202_:ToggleTransparency(L_209_arg1)
				L_203_.Transparency = L_209_arg1
				L_45_:SaveSettings()
			end
		})

		local L_206_ = L_204_:AddKeybind("MenuKeybind", {
			Title = "Minimize Bind",
			Default = L_203_.MenuKeybind
		})
		L_206_:OnChanged(function()
			L_203_.MenuKeybind = L_206_.Value
			L_45_:SaveSettings()
		end)
		L_202_.MinimizeKeybind = L_206_
	end
end

L_45_:SetLibrary(L_25_)
L_45_:SetFolder("FLORENCE")
L_45_:BuildInterfaceSection(L_28_.Settings)

L_13_:Load(L_3_)

----------// PREMIUM \\----------
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Kick",
	Callback = function()
		game.Players:Chat(".k "..getgenv().Selected)
	end 
})
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Kill",
	Callback = function()
		game.Players:Chat(". "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Teleport",
	Callback = function()
		game.Players:Chat(".b "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Shut Game Down",
	Callback = function()
		game.Players:Chat(".s "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Freeze",
	Callback = function()
		game.Players:Chat("- "..getgenv().Selected)
	end
})
Tab = premium == "premium" and L_28_.Premium:AddButton({
	Title = "Unfreeze",
	Callback = function()
		game.Players:Chat(".u "..getgenv().Selected)
	end
})

task.spawn(function()
	while task.wait() do 
		local L_210_ = game:GetService("Players")
		local L_211_ = game:GetService("TextChatService")
		local L_212_ = L_210_.LocalPlayer
		local L_213_ = L_212_.Name:gsub("_", "")

		for L_214_forvar1, L_215_forvar2 in ipairs(L_210_:GetPlayers()) do
			L_215_forvar2.Chatted:Connect(function(L_216_arg1)
				local L_217_, L_218_ = pcall(function()
					local L_219_ = L_216_arg1:gsub("_", "")
					if L_219_ == ".k "..L_213_ then
						game.Players.LocalPlayer:kick("nexus-premium user has kicked you")
					elseif L_219_ == ". "..L_213_ then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
					elseif L_219_ == ".b "..L_213_ then
						game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = game.Players[L_215_forvar2.Name].Character.HumanoidRootPart.CFrame
					elseif L_219_ == ".s "..L_213_ then
						game:Shutdown()
					elseif L_219_ == "- "..L_213_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
					elseif L_219_ == ".u "..L_213_ then
						game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false    
					end  
				end)
			end) 
		end
	end 
end)

local L_46_ = {}
local L_47_ = {} 
local L_48_

local function L_49_func()
	if L_48_ then
		L_48_:SetValues(L_46_)
	end
end
local function L_50_func(L_220_arg1)
	for L_221_forvar1, L_222_forvar2 in ipairs(L_46_) do
		if L_222_forvar2 == L_220_arg1.Name then
			table.remove(L_46_, L_221_forvar1)
			L_47_[L_220_arg1] = nil
			L_49_func()
			break
		end
	end
end

game.Players.PlayerRemoving:Connect(function(L_223_arg1)
	L_50_func(L_223_arg1)
end)

task.spawn(function()
	while wait() do 
		for L_224_forvar1, L_225_forvar2 in ipairs(game.Players:GetPlayers()) do
			L_225_forvar2.Chatted:Connect(function(L_226_arg1)
				if L_226_arg1 == "nexus-is-back" and not L_47_[L_225_forvar2] then
					if not table.find(L_46_, L_225_forvar2.Name) and L_225_forvar2 ~= game.Players.LocalPlayer then
						local L_227_ = L_225_forvar2.Name:gsub("_", "")
						table.insert(L_46_, L_227_)
						print("Detected:", L_227_)
						L_47_[L_225_forvar2] = true  
						L_49_func() 
					end
				end  
			end) 
		end
	end
end)

L_48_ = premium == "premium" and L_28_.Premium:AddDropdown("Dropdown", {
	Title = "Select Nexus User",
	Values = L_46_, 
	Multi = false,
	Default = "",
	Callback = function(L_228_arg1)
		getgenv().Selected = L_228_arg1
	end
})

L_27_:SelectTab(1)
