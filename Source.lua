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

local Section = Tab1:AddSection({"Auto Plant"})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeedLooping = false

local function GetRandomPositionOnPart(MyFarm)
    local Locations = MyFarm.Important.Plant_Locations:GetChildren()
    local Part = Locations[math.random(1, #Locations)]

    local RandomOffset = Vector3.new(
        (math.random() - 0.5) * Part.Size.X,
        (math.random() - 0.5) * Part.Size.Y,
        (math.random() - 0.5) * Part.Size.Z
    )

    return Part.CFrame:PointToWorldSpace(RandomOffset)
end

local function GetOwnedSeed(Client)
    local Character = Client.Character
    local Backpack = Client:FindFirstChildOfClass("Backpack")

    for _, v in ipairs(Character:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Plant_Name") then
            return v
        end
    end

    for _, v in ipairs(Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Plant_Name") then
            v.Parent = Character
            return v
        end
    end

    return nil
end

local function AutoPlantSeed()
    local MyFarm = findMyFarm()
    if not MyFarm then return end

    local Seed = GetOwnedSeed(Client)
    local Root = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
    if Seed and Root then
        Root.AssemblyLinearVelocity = Vector3.zero
        local pos = GetRandomPositionOnPart(MyFarm)
        Root.CFrame = CFrame.new(pos + Vector3.new(0, -5, 0))
        task.wait(0.2)
        ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(pos, Seed)
    end
end

Tab1:AddToggle({
    Name = "Auto Plant Seed",
    Default = false,
    Callback = function(value)
        SeedLooping = value
        if SeedLooping then
            spawn(function()
                while SeedLooping do
                    AutoPlantSeed()
                    wait(0.5)
                end
            end)
        end
    end
})
