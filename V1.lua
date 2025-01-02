local players = game:GetService("Players")
local teams = game:GetService("Teams")
local player = players.LocalPlayer
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()
-- ^^^^^^^^^^^^
local Window = redzlib:MakeWindow({
    Title = "redz Hub : Blox Fruits",
    SubTitle = "by redz9999",
    SaveFolder = "testando | redz lib v5.lua"
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

local Section = Tab6:AddSection({"Themes"})

Tab6:AddButton({"Dark Theme", function()
    redzlib:SetTheme("Dark")
end})

Tab6:AddButton({"Darker Theme", function()
    redzlib:SetTheme("Darker")
end})

Tab6:AddButton({"Dark Purple", function()
    redzlib:SetTheme("Purple")
end})

Window:SelectTab(Tab2)
local Section = Tab2:AddSection({"Auto Goal"})

local isAutoGoalEnabled = false

local function AutoGoal()
    local character = player.Character or player.CharacterAdded:Wait()
    if character:FindFirstChild("Football") then
        wait(3)

        local teleporting = true

        while teleporting do
            if not character:FindFirstChild("Football") then
                wait(3)
                return
            end
            
            if player.Team.Name == "Away" then
                character:SetPrimaryPartCFrame(workspace.Goals.Away.CFrame)
            elseif player.Team.Name == "Home" then
                character:SetPrimaryPartCFrame(workspace.Goals.Home.CFrame)
                print("Home Team = Away Goal")
            end
            
            wait(0.1)
        end

        local args = {
            [1] = 30,
            [4] = Vector3.new(0, 0, 0)
        }

        replicated_storage.Packages.Knit.Services.BallService.RE.Shoot:FireServer()

        teleporting = false
        wait(2)
    end
end

local Toggle1 = Tab2:AddToggle({
    Name = "Auto Goal",
    Description = "Automatically goes to the goal when you have the football.",
    Default = false,
    Callback = function(value)
        isAutoGoalEnabled = value
        if isAutoGoalEnabled then
            while isAutoGoalEnabled do
                AutoGoal()
                wait(0.1) -- Prevents the loop from running too fast
            end
        end
    end
})
