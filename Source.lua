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

local Client = game.Players.LocalPlayer
local Character = Client.Character or Client.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

local running = false
local collecting = false

local function freezeCharacter()
    Root.Anchored = true
    Humanoid.WalkSpeed = 0
    Humanoid.JumpPower = 0
    Humanoid.PlatformStand = true
end

local function unfreezeCharacter()
    Root.Anchored = false
    Humanoid.PlatformStand = false
    Humanoid.WalkSpeed = 16
    Humanoid.JumpPower = 50
    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

local function findMyFarm()
    for _, v in pairs(workspace.Farm:GetChildren()) do
        if v:FindFirstChild("Important") and v.Important:FindFirstChild("Data") and v.Important.Data:FindFirstChild("Owner") then
            if v.Important.Data.Owner.Value == Client.Name then
                return v
            end
        end
    end
    return nil
end

local function autoCollectOnce()
    if running then return end
    running = true

    local MyFarm = findMyFarm()
    if not MyFarm then
        running = false
        return
    end

    for _, v in pairs(MyFarm.Important.Plants_Physical:GetDescendants()) do
        if not running then break end
        if v:IsA("ProximityPrompt") then
            freezeCharacter()
            Root.CFrame = CFrame.new(v.Parent:GetPivot().Position + Vector3.new(0, 5, 0))
            wait(0.1)
            fireproximityprompt(v)
            wait(0.3)
            unfreezeCharacter()
            wait(0.2)

            -- YOUR SNIPPET ADDED HERE EXACTLY AS YOU SENT IT:
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")

            local MAX_DISTANCE = 40

            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    local promptPart = v.Parent:IsA("BasePart") and v.Parent or v.Parent:FindFirstChildWhichIsA("BasePart")
                    if promptPart then
                        local distance = (promptPart.Position - hrp.Position).Magnitude
                        if distance <= MAX_DISTANCE then
                            pcall(function()
                                fireproximityprompt(v)
                            end)
                        end
                    end
                end
            end
            -- END OF YOUR SNIPPET
        end
    end

    running = false
end

local Toggle1 = Tab1:AddToggle({
    Name = "Auto Collect",
    Description = "",
    Default = false
})

Toggle1:OnChanged(function(value)
    collecting = value
    if collecting then
        spawn(function()
            while collecting do
                autoCollectOnce()
                wait(1)
            end
        end)
    end
end)
