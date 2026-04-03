local HamzHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/zerotheking152-png/Gui/main/HamzGui.lua"))()

-- STATES
local AutoFarm, AutoQuest, FastAttack, AutoFruit = false, false, false, false
local ESPEnabled, AntiAFK, FPSBoost = false, false, false

local player = game.Players.LocalPlayer

-- REMOVE MAIN
HamzHub.MainTab:Destroy()

-- CREATE TABS
local AutoTab = HamzHub.CreateTab("Automation")
local MiscTab = HamzHub.CreateTab("Misc")

-- UI CREATOR
local function makeContainer(tab)
    local scroll = Instance.new("ScrollingFrame", tab)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,8)

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
    end)

    return scroll
end

local AutoContainer = makeContainer(AutoTab)
local MiscContainer = makeContainer(MiscTab)

local function toggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1,-10,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text.." OFF"
    Instance.new("UICorner", btn)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and " ON" or " OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(0,255,120) or Color3.fromRGB(60,60,60)
        callback(state)
    end)
end

-- NOCLIP
task.spawn(function()
    while true do
        task.wait()
        if AutoFarm and player.Character then
            for _,v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- TARGET
local function getTarget()
    local myLevel = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value or 1
    local closest, dist = nil, math.huge

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local name = v.Name:lower()
            if not name:find("boss") and not name:find("dummy") then
                local lvl = v:FindFirstChild("Level")
                if lvl and lvl.Value <= myLevel + 5 then
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

-- AUTO FARM (UNDERGROUND)
task.spawn(function()
    while true do
        task.wait(0.08)

        if AutoFarm and player.Character then
            local target = getTarget()
            if target then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0,-6,0)

                    -- HIT
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("CombatSystem")
                        :WaitForChild("Remotes")
                        :WaitForChild("RequestHit")
                        :FireServer()

                    -- SKILLS
                    pcall(function()
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
                    end)

                    task.wait(FastAttack and 0.03 or 0.1)
                end
            end
        end
    end
end)

-- AUTO QUEST
task.spawn(function()
    while true do
        task.wait(3)
        if AutoQuest then
            game:GetService("ReplicatedStorage")
                :WaitForChild("RemoteEvents")
                :WaitForChild("QuestAccept")
                :FireServer("QuestNPC1")
        end
    end
end)

-- AUTO FRUIT
local function findFruit()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Handle") then
            return v
        end
    end
end

task.spawn(function()
    while true do
        task.wait(2)
        if AutoFruit and AutoFarm then
            local fruit = findFruit()
            if fruit and player.Character then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                local old = root.CFrame
                root.CFrame = fruit:GetPivot()
                task.wait(1)
                root.CFrame = old
            end
        end
    end
end)

-- ESP
task.spawn(function()
    while true do
        task.wait(2)
        if ESPEnabled then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                    if not v:FindFirstChild("ESP") then
                        local bill = Instance.new("BillboardGui", v)
                        bill.Name = "ESP"
                        bill.Size = UDim2.new(0,100,0,40)
                        bill.AlwaysOnTop = true

                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1,0,1,0)
                        txt.Text = v.Name
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.new(1,0,0)
                    end
                end
            end
        end
    end
end)

-- FPS BOOST
local function boostFPS()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        end
    end
end

-- ANTI AFK
player.Idled:Connect(function()
    if AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

-- TOGGLES AUTO
toggle(AutoContainer,"Auto Farm",function(v) AutoFarm = v end)
toggle(AutoContainer,"Auto Quest",function(v) AutoQuest = v end)
toggle(AutoContainer,"Fast Attack",function(v) FastAttack = v end)
toggle(AutoContainer,"Auto Fruit",function(v) AutoFruit = v end)

-- TOGGLES MISC
toggle(MiscContainer,"ESP",function(v) ESPEnabled = v end)
toggle(MiscContainer,"Anti AFK",function(v) AntiAFK = v end)
toggle(MiscContainer,"FPS Boost",function(v) FPSBoost = v if v then boostFPS() end end)

print("HamzHub Ultra Loaded")
