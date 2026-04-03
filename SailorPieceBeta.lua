local HamzHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/zerotheking152-png/Gui/main/HamzGui.lua"))()

local AutoFarmEnabled = false
local AutoQuestEnabled = false
local FastAttackEnabled = false
local AutoFruitEnabled = false

local LastFarmPosition = nil

local function createButton(parent, name, posY, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0,180,0,35)
    btn.Position = UDim2.new(0,20,0,posY)
    btn.BackgroundColor3 = Color3.fromRGB(0,255,120)
    btn.TextColor3 = Color3.new(0,0,0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local yMain = 70

createButton(HamzHub.MainTab, "Claim Events", yMain, function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EventRemotes"):WaitForChild("GetEvents"):InvokeServer()
end)

yMain = yMain + 45
createButton(HamzHub.MainTab, "Get Titles Data", yMain, function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GetTitlesData"):InvokeServer()
end)

yMain = yMain + 45
createButton(HamzHub.MainTab, "Get Boosts", yMain, function()
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ShopRemotes"):WaitForChild("GetBoosts"):InvokeServer()
end)

local AutomationTab = HamzHub.CreateTab("Automation")

local yAuto = 20

local function createToggle(parent, name, defaultState, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.Size = UDim2.new(0,340,0,40)
    toggleBtn.Position = UDim2.new(0,20,0,yAuto)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0,255,120) or Color3.fromRGB(60,60,60)
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.Text = name .. " : " .. (defaultState and "ON" or "OFF")
    toggleBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)
    
    local state = defaultState
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0,255,120) or Color3.fromRGB(60,60,60)
        toggleBtn.Text = name .. " : " .. (state and "ON" or "OFF")
        callback(state)
    end)
    yAuto = yAuto + 50
    return toggleBtn
end

createToggle(AutomationTab, "Auto Farm (NPC Bawah Tanah)", false, function(state)
    AutoFarmEnabled = state
    if state and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LastFarmPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end)

createToggle(AutomationTab, "Auto Quest", false, function(state)
    AutoQuestEnabled = state
end)

createToggle(AutomationTab, "Fast Attack", false, function(state)
    FastAttackEnabled = state
end)

createToggle(AutomationTab, "Auto Fruit (TP + Collect)", false, function(state)
    AutoFruitEnabled = state
end)

local function findFruit()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Handle") then
            local name = obj.Name:lower()
            if name:find("fruit") or name:find("devil") or name:find("bomb") or name:find("flame") or name:find("light") then
                if obj.PrimaryPart or obj:FindFirstChild("Handle") then
                    return obj
                end
            end
        end
    end
    return nil
end

task.spawn(function()
    while true do
        task.wait()
        if AutoFarmEnabled then
            game:GetService("ReplicatedStorage"):WaitForChild("CombatSystem"):WaitForChild("Remotes"):WaitForChild("RequestHit"):FireServer()
            if FastAttackEnabled then
                task.wait(0.03)
            else
                task.wait(0.12)
            end
        else
            task.wait(0.2)
        end
    end
end)

task.spawn(function()
    while true do
        if AutoQuestEnabled then
            local args = {"QuestNPC1"}
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(unpack(args))
            task.wait(4)
        else
            task.wait(1)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if AutoFruitEnabled and AutoFarmEnabled then
            local fruit = findFruit()
            if fruit then
                local plr = game.Players.LocalPlayer
                local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if root and LastFarmPosition then
                    local oldPos = root.CFrame
                    root.CFrame = fruit:GetPivot() * CFrame.new(0, 5, 0)
                    task.wait(1.2)
                    root.CFrame = oldPos
                end
            end
        end
    end
end)

print("HamzHub Sailor Piece LOADED - Auto Farm + Auto Fruit READY")
print("Auto Fruit: otomatis TP ke fruit spawn, collect, lalu balik farming")
print("Pastikan di area NPC bawah tanah yang sesuai level")
