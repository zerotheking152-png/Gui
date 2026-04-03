local HamzHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/zerotheking152-png/Gui/main/HamzGui.lua"))()

-- STATES
local AutoFarmEnabled = false
local AutoQuestEnabled = false
local FastAttackEnabled = false
local AutoFruitEnabled = false

local player = game.Players.LocalPlayer

-- REMOVE MAIN TAB (ga guna)
HamzHub.MainTab:Destroy()

-- CREATE TAB
local AutomationTab = HamzHub.CreateTab("Automation")

-- SCROLL FRAME FIX
local container = Instance.new("ScrollingFrame", AutomationTab)
container.Size = UDim2.new(1, -10, 1, -10)
container.Position = UDim2.new(0, 5, 0, 5)
container.CanvasSize = UDim2.new(0, 0, 0, 0)
container.ScrollBarThickness = 4
container.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 8)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- TOGGLE CREATOR
local function createToggle(name, callback)
    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name .. " OFF"
    
    Instance.new("UICorner", btn)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. (state and " ON" or " OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0,255,120) or Color3.fromRGB(60,60,60)
        callback(state)
    end)
end

-- SAFE NPC FINDER
local function getTarget()
    local myLevel = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value or 1
    local closest = nil
    local dist = math.huge

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local name = v.Name:lower()

            -- FILTER
            if not name:find("boss") and not name:find("dummy") then
                local level = v:FindFirstChild("Level")
                if level and level.Value <= myLevel + 5 then
                    local mag = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if mag < dist then
                        dist = mag
                        closest = v
                    end
                end
            end
        end
    end

    return closest
end

-- AUTO FARM
task.spawn(function()
    while true do
        task.wait(0.1)

        if AutoFarmEnabled and player.Character then
            local target = getTarget()
            if target then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame =
                        target.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

                    game:GetService("ReplicatedStorage")
                        :WaitForChild("CombatSystem")
                        :WaitForChild("Remotes")
                        :WaitForChild("RequestHit")
                        :FireServer()
                end)

                task.wait(FastAttackEnabled and 0.05 or 0.15)
            end
        end
    end
end)

-- AUTO QUEST
task.spawn(function()
    while true do
        task.wait(3)

        if AutoQuestEnabled then
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("QuestAccept")
                    :FireServer("QuestNPC1")
            end)
        end
    end
end)

-- AUTO FRUIT
local function findFruit()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Handle") then
            return obj
        end
    end
end

task.spawn(function()
    while true do
        task.wait(2)

        if AutoFruitEnabled and AutoFarmEnabled then
            local fruit = findFruit()
            if fruit and player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local old = root.CFrame
                    root.CFrame = fruit:GetPivot() * CFrame.new(0,5,0)
                    task.wait(1)
                    root.CFrame = old
                end
            end
        end
    end
end)

-- TOGGLES
createToggle("Auto Farm", function(v) AutoFarmEnabled = v end)
createToggle("Auto Quest", function(v) AutoQuestEnabled = v end)
createToggle("Fast Attack", function(v) FastAttackEnabled = v end)
createToggle("Auto Fruit", function(v) AutoFruitEnabled = v end)

print("HamzHub Fixed Loaded")
