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
-- tabs
local Tab1 = Window:MakeTab({"Discord", "Info"})
local Tab2 = Window:MakeTab({"Auto Things", "Home"})
local Tab3 = Window:MakeTab({"Skills", "Sword"})
local Tab4 = Window:MakeTab({"Flow And Style", "Signal"})
local Tab5 = Window:MakeTab({"Items", "Locate"})
local Tab6 = Window:MakeTab({"Misc", "Settings"})
-- auto farm starting
local Section = Tab2:AddSection({"Auto Farm"})

local isAutoGoalEnabled = false
local isAutoBallEnabled = false

local function AutoGoal()
    local character = player.Character or player.CharacterAdded:Wait()
    local football = workspace:FindFirstChild("Football")

    if football then
        while isAutoGoalEnabled do
            if character:FindFirstChild("Football") then
                -- Teleport to the goal based on the player's team
                local goalPosition
                if player.Team.Name == "Away" then
                    goalPosition = workspace.Goals.Away.CFrame
                elseif player.Team.Name == "Home" then
                    goalPosition = workspace.Goals.Home.CFrame
                end

                if goalPosition then
                    character:SetPrimaryPartCFrame(goalPosition) -- Teleport to the goal
                    wait(0.1) -- Short wait to ensure teleportation is processed
                    -- Immediately shoot the ball after teleporting
                    local args = {
                        [1] = 30,
                        [4] = Vector3.new(0, 0, 0)
                    }
                    replicatedStorage.Packages.Knit.Services.BallService.RE.Shoot:FireServer()
                end

                wait(1) -- Wait before the next action to avoid spamming
            else
                wait(0.5) -- Shorter wait if the player doesn't have the football
            end
        end
    end
end

local Toggle1 = Tab2:AddToggle({
    Name = "Auto Goal",
    Description = "Automatically goes to the goal when you have the football.",
    Default = false,
    Callback = function(value)
        isAutoGoalEnabled = value
        if isAutoGoalEnabled then
            AutoGoal() -- Start the AutoGoal function
        end
    end
})

local function trackFootball()
    local character = player.Character or player.CharacterAdded:Wait()

    while isAutoBallEnabled do
        local football = workspace:FindFirstChild("Football")
        if football then
            if not character:FindFirstChild("Football") then
                character:SetPrimaryPartCFrame(football.CFrame) -- Teleport to the football
            end
        else
            print("Football is not in workspace anymore")
        end
        wait(0.1) -- Wait for 0.1 seconds before checking again
    end
end

local Toggle2 = Tab2:AddToggle({
    Name = "Auto Teleport to Football",
    Description = "Automatically teleports to the football until you get it.",
    Default = false,
    Callback = function(value)
        isAutoBallEnabled = value
        if isAutoBallEnabled then
            trackFootball() -- Start tracking the football
        end
    end
})
-- done
-- speed start :
local slider1 = Tab3:AddSlider({
  Name = "Speed",
  Min = 1,
  Max = 100,
  Increase = 1,
  Default = 16,
  Callback = function(Value)
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end
})
-- speed end
