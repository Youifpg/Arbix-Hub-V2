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

local AutoFarmToggle = Tab1:AddToggle({
    Name = "Auto Farm",
    Description = "Auto plants, harvests, buys, and sells for you.",
    Default = false,
    Callback = function(value)
        shared.afy = value
        print("Auto Farm: ", shared.afy)

        if shared.afy then
            task.spawn(function()
                local Players = game:GetService('Players')
                local ReplicatedStorage = game:GetService('ReplicatedStorage')
                local Client = Players.LocalPlayer
                local PlayerGui = Client:WaitForChild('PlayerGui')

                local MyFarm
                for _, v in ipairs(workspace.Farm:GetChildren()) do
                    if v.Important.Data.Owner.Value == Client.Name then
                        MyFarm = v
                        break
                    end
                end
                assert(MyFarm, 'My farm was not found.')

                
                local function GetChar(player)
                    return player and player.Character
                end

                local function GetBackpack(player)
                    return player and player:FindFirstChildWhichIsA('Backpack')
                end

                local function GetRoot(char)
                    return char and char:FindFirstChild('HumanoidRootPart')
                end

                local function GetAffordableSeed()
                    local SeedShop = PlayerGui.Seed_Shop.Frame.ScrollingFrame
                    local MyMoney = Client.leaderstats.Sheckles.Value
                    local HighestCost, BestSeed = 0

                    for _, SeedItem in pairs(SeedShop:GetChildren()) do
                        if SeedItem:IsA("Frame") then
                            local MainFrame = SeedItem:FindFirstChild("Main_Frame")
                            if MainFrame then
                                local InStock = SeedItem.Frame.Sheckles_Buy:FindFirstChild("In_Stock")
                                if InStock and InStock.Visible then
                                    local CostLabel = InStock:FindFirstChild("Cost_Text")
                                    if CostLabel then
                                        local CostValue = tonumber(string.match(CostLabel.Text, "(%d+)"))
                                        if CostValue and MyMoney >= CostValue and CostValue > HighestCost then
                                            HighestCost = CostValue
                                            BestSeed = SeedItem.Name
                                        end
                                    end
                                end
                            end
                        end
                    end

                    return BestSeed
                end

                local function GetOwnedSeed()
                    local Char = GetChar(Client)
                    for _, v in ipairs(Char and Char:GetChildren() or {}) do
                        if v:IsA('Tool') and v:FindFirstChild('Plant_Name') then
                            return v.Plant_Name.Value
                        end
                    end
                    local Backpack = GetBackpack(Client)
                    for _, v in ipairs(Backpack and Backpack:GetChildren() or {}) do
                        if v:IsA('Tool') and v:FindFirstChild('Plant_Name') then
                            v.Parent = Char
                            return v.Plant_Name.Value
                        end
                    end
                end

                local function GetSellable()
                    local Backpack = GetBackpack(Client)
                    for _, v in ipairs(Backpack and Backpack:GetChildren() or {}) do
                        if v:IsA('Tool') and v:GetAttribute('WeightMulti') then
                            return true
                        end
                    end
                end

                local function GetRandomPositionOnPart()
                    local Locations = MyFarm.Important.Plant_Locations:GetChildren()
                    local Part = Locations[math.random(1, #Locations)]
                    local RandomOffset = Vector3.new(
                        (math.random() - 0.5) * Part.Size.X,
                        (math.random() - 0.5) * Part.Size.Y,
                        (math.random() - 0.5) * Part.Size.Z
                    )
                    return Part.CFrame:PointToWorldSpace(RandomOffset)
                end

                -- Disable collisions
                for _, v in ipairs(workspace:GetChildren()) do
                    if v:IsA('BasePart') then
                        v.CanCollide = false
                    end
                end

                while shared.afy and task.wait() do
                    local Seed = GetOwnedSeed()
                    local Char = GetChar(Client)
                    local Root = GetRoot(Char)

                    if Root then
                        Root.AssemblyLinearVelocity = Vector3.zero
                    end

                    if Seed and Root then
                        local PositionPlanted = GetRandomPositionOnPart()
                        Root.CFrame = CFrame.new(PositionPlanted + Vector3.new(0, 5, 0))
                        task.wait(0.2)
                        ReplicatedStorage.GameEvents.Plant_RE:FireServer(PositionPlanted, Seed)
                    else
                        local AffordableSeed = GetAffordableSeed()
                        if AffordableSeed then
                            ReplicatedStorage.GameEvents.BuySeedStock:FireServer(AffordableSeed)
                            task.wait(0.2)
                        end
                    end

                    for _, v in ipairs(MyFarm.Important.Plants_Physical:GetDescendants()) do
                        if v:IsA('ProximityPrompt') and Root then
                            Root.CFrame = CFrame.new(v.Parent:GetPivot().Position + Vector3.new(0, 5, 0))
                            fireproximityprompt(v)
                        end
                    end

                    if GetSellable() and Root then
                        Root.CFrame = CFrame.new(62, -4, -0.6)
                        task.wait(0.2)
                        ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
                    end
                end

                -- Re-enable collisions when turned off
                for _, v in ipairs(workspace:GetChildren()) do
                    if v:IsA('BasePart') then
                        v.CanCollide = true
                    end
                end
            end)
        end
    end
})
