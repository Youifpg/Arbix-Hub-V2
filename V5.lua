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
    Button = { Image = "rbxassetid://126511980185658", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 6) },
})

-- tabs
local Tab1 = Window:MakeTab({"Discord", "Info"})
local Tab2 = Window:MakeTab({"Auto Things", "Home"})
local Tab3 = Window:MakeTab({"Skills", "Sword"})
local Tab4 = Window:MakeTab({"Flow And Style", "Signal"})
local Tab5 = Window:MakeTab({"Items", "Locate"})
local Tab6 = Window:MakeTab({"Misc", "Settings"})
--
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

local Section = Tab3:AddSection({"SPEED ( buggy )"})

local slider1 = Tab3:AddSlider({
    Name = "Speed",
    Min = 1,
    Max = 100,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        -- Set the speed based on the slider value
        tspeed = Value
    end
})

local tspeed = 16 -- Default speed
local hb = game:GetService("RunService").Heartbeat
local tpwalking = true
local player = game:GetService("Players")
local lplr = player.LocalPlayer

-- Ensure the character and humanoid are set up correctly
local function getCharacterAndHumanoid()
    local chr = lplr.Character or lplr.CharacterAdded:Wait()
    local hum = chr:WaitForChild("Humanoid")
    return chr, hum
end

-- Main loop to adjust player speed
while tpwalking do
    local chr, hum = getCharacterAndHumanoid()
    hb:Wait() -- Wait for the next heartbeat

    if hum and hum.Parent then
        if hum.MoveDirection.Magnitude > 0 then
            -- Translate the character based on the speed
            chr:TranslateBy(hum.MoveDirection * (tspeed / 16)) -- Adjust speed scaling
        end
    end
end
})

local Section = Tab3:AddSection({"INF Staimna"})

Tab3:AddButton({ 
    Name = "INF STAIMNA", -- Fixed the button name
    Callback = function() 
    local args = {
    [1] = 0/0
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.StaminaService.RE.DecreaseStamina:FireServer(unpack(args))
        end
    })

-- speed end
-- notes:
Tab3:AddParagraph({"Note", "Skills soon"})
Tab2:AddParagraph({"Note", "Don't enable auto get ball and the auto goal at the same time"})
Tab4:AddParagraph({"Note", "The flow is prodigy; it gives you a curve shot."})
Tab4:AddParagraph({"Note", "The Styles soon"})
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

local Section = Tab5:AddSection({"Style and flow"})

local FlowButton = Tab4:AddButton({
    Name = "Get prodigy (not perm)",
    Callback = function()
        set_flow("Prodigy") -- Corrected the quotation marks
    end
})

-- end
local Section = Tab5:AddSection({"Goal effects"})

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
-- 2
local Section = Tab5:AddSection({"Cards"})

local card_text = ""
local CardTextBox = Tab5:AddTextBox({ 
    Title = "Card name", 
    Default = "", 
    PlaceholderText = "Enter Card name", 
    ClearText = true, 
    Callback = function(value) 
        card_text = value 
    end 
}) 

Tab5:AddButton({ 
    Name = "Get", -- Fixed the button name
    Callback = function() 
        if card_text and card_text ~= "" then 
            local args = {
                [1] = "Cards",
                [2] = card_text
            }
            game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        else
            print("Please enter a valid card name.") -- Optional: feedback for empty input
        end
    end 
})
-- 3
local Section = Tab5:AddSection({"Cosmetics"})

local cos_text = ""
local cosTextBox = Tab5:AddTextBox({ 
    Title = "Cosmetic name", 
    Default = "", 
    PlaceholderText = "Enter Cosmetic name", 
    ClearText = true, 
    Callback = function(value) 
        cos_text = value 
    end 
}) 

Tab5:AddButton({ 
    Name = "Get", -- Fixed the button name
    Callback = function() 
        if cos_text and cos_text ~= "" then 
            local args = {
                [1] = "Cosmetics",
                [2] = cos_text
            }
            game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        else
            print("Please enter a valid Cosmetic name.") -- Optional: feedback for empty input
        end
    end 
})
-- 
local Section = Tab5:AddSection({"Goal effects one click"})
Tab5:AddButton({ 
    Name = "get Wonderland effect", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "GoalEffects",
    [2] = "Wonderland"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })


Tab5:AddButton({ 
    Name = "get Conquer effect", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "GoalEffects",
    [2] = "Conquer"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })


Tab5:AddButton({ 
    Name = "get Time Stop effect", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "GoalEffects",
    [2] = "Time Stop"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))       
        end          
    })


Tab5:AddButton({ 
    Name = "get Presents Effect", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "GoalEffects",
    [2] = "Presents"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })
                       
--
local Section = Tab5:AddSection({"Cards One click"})
Tab5:AddButton({ 
    Name = "get VIP card", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cards",
    [2] = "VIP"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })
Tab5:AddButton({ 
    Name = "get Legend card", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cards",
    [2] = "Legend"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })


Tab5:AddButton({ 
    Name = "get Crystal card ( best )", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cards",
    [2] = "Crystal"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })


Tab5:AddButton({ 
    Name = "get Admin card", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cards",
    [2] = "YingYang"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })
--- stoppp
local Section = Tab5:AddSection({"Cosmetics Ine click"})
Tab5:AddButton({ 
    Name = "Get admin SHADOW Aura ( the best )", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cosmetics",
    [2] = "SHADOW"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })

Tab5:AddButton({ 
    Name = "get Snowman Cape", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cosmetics",
    [2] = "Snowman Cape"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })

Tab5:AddButton({ 
    Name = "get Peppermint Cape ( best normal )", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cosmetics",
    [2] = "Peppermint Cape"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })

Tab5:AddButton({ 
    Name = "get Christmas Aura", -- Fixed the button name
    Callback = function()
    local args = {
    [1] = "Cosmetics",
    [2] = "Christmas Aura"
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.CustomizationService.RE.Customize:FireServer(unpack(args))
        end          
    })
