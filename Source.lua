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

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = Players.LocalPlayer

local AutoPlant = false

local Toggle1 = Tab1:AddToggle({
    Name = "Auto Plant",
    Description = "",
    Default = false,
    Callback = function(value)
        AutoPlant = value

        task.spawn(function()
            while AutoPlant do
                local Tool = Client.Character and Client.Character:FindFirstChildOfClass("Tool")
                if Tool and Tool.Name:find("Seed") then
                    
                    local nameParts = Tool.Name:split(" ")
                    if nameParts[#nameParts] == "Seed" then
                        table.remove(nameParts) 
                    end
                    local CropName = table.concat(nameParts, " ")

                    
                    local MyFarm
                    for _, v in pairs(workspace.Farm:GetChildren()) do
                        if v:FindFirstChild("Important") and v.Important:FindFirstChild("Data") then
                            if v.Important.Data:FindFirstChild("Owner") and v.Important.Data.Owner.Value == Client.Name then
                                MyFarm = v
                                break
                            end
                        end
                    end

                    if MyFarm then
                        local function GetRandomPositionOnPart()
                            local Locations = MyFarm.Important.Plant_Locations:GetChildren()
                            if #Locations == 0 then return nil end

                            local Part = Locations[math.random(1, #Locations)]
                            local RandomOffset = Vector3.new(
                                (math.random() - 0.5) * Part.Size.X,
                                (math.random() - 0.5) * Part.Size.Y,
                                (math.random() - 0.5) * Part.Size.Z
                            )
                            return Part.CFrame:PointToWorldSpace(RandomOffset)
                        end

                        local pos = GetRandomPositionOnPart()
                        if pos then
                            local args = {
                                pos,
                                CropName
                            }
                            ReplicatedStorage.GameEvents.Plant_RE:FireServer(unpack(args))
                        end
                    end
                end

                task.wait()
            end
        end)
    end
})
