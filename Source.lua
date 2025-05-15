local replicated_storage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local teams = game:GetService("Teams")
local user_input_service = game:GetService("UserInputService")
local run_service = game:GetService("RunService")
local player = players.LocalPlayer

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()

local Window = redzlib:MakeWindow({
  Title = "ARBIX HUB | GROW A GARDEN",
  SubTitle = "by touka",
  SaveFolder = "arbixhub"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://122413984562434", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 6) },
})


local Tab1 = Window:MakeTab({"Auto Things", "Home"})

local Section = Tab1:AddSection({"Auto Collect [ Not Finished ]"})

local Toggle1 = Tab1:AddToggle({
    Name = "Auto Collect",
    Description = "",
    Default = false
})
