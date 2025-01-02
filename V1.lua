-- locals
local replicatedStorage = game:GetService("ReplicatedStorage")
local player = players.LocalPlayer
local player = players.LocalPlayerlocal players = game:GetService("Players")
local teams = game:GetService("Teams")
local player = players.LocalPlayer
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()
-- ^^^^^^^^^^^^
local Window = redzlib:MakeWindow({
    Title = "Arbix Hub : Blue Lock",
    SubTitle = "by TOUKA",
    SaveFolder = "arbix hub | blue lock "
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://122413984562434", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 6) },
})

local Tab1 = Window:MakeTab({"Discord", "Info"})
local Tab2 = Window:MakeTab({"Auto Things", "Home"})
local Tab3 = Window:MakeTab({"Skills", "Sword"})
local Tab4 = Window:MakeTab({"Flow And Style", "Signal"})
local Tab5 = Window:MakeTab({"Items", "Locate"})
local Tab6 = Window:MakeTab({"Misc", "Settings"})

