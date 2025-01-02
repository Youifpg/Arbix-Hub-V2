-- locals
local players = game:GetService("Players") -- Corrected the order of declaration
local player = players.LocalPlayer -- Moved this line after players is defined
local teams = game:GetService("Teams")
local replicatedStorage = game:GetService("ReplicatedStorage") -- Added this for the ReplicatedStorage reference
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
-- notes:
Tab3:AddParagraph({"Note", "Skills soon"})
Tab2:AddParagraph({"Note", "Don't enable auto get ball and the auto goal at the same time"})
Tab4:AddParagraph({"Note", "The flow is prodigy; it gives you a curve shot."})
Tab4:AddParagraph({"Note", "The Styles soon"})
Tab3:AddParagraph({"Note", "Skills soon"})
Tab3:AddParagraph({"Note", "Skills soon"})
Tab3:AddParagraph({"Note", "Skills soon"})
Tab3:AddParagraph({"Note", "Skills soon"})

-- end
-- style and flow
local function set_flow(desired_flow)
    if player:FindFirstChild("PlayerStats") then
        local playerStats = player.PlayerStats
        if playerStats:FindFirstChild("Flow") then
            playerStats.Flow.Value = desired_flow
        end
    end
end

local FlowButton = Tab4:AddButton({
    Name = "Get prodigy (not perm)",
    Callback = function()
        set_flow("Prodigy") -- Corrected the quotation marks
    end
})

-- end
local goal_text = ""
-- items
local GoalTextBox = Tab5:AddTextBox({ 
    Title = "Goal effect name", 
    Default = "", 
    PlaceholderText = "Enter goal effect name", 
    ClearText = true, 
    Callback = function(value) 
        goal_text = value 
    end 
}) 

Tab5:AddButton({ 
    Name = "Get", -- Fixed the button name
    Callback = function() 
        if goal_text and goal_text ~= "" then 
            local args = {
                [1] = "GoalEffects",
                [2] = goal_text
            }
            game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        else
            print("Please enter a valid goal effect name.") -- Optional: feedback for empty input
        end
    end 
})
