local HamzHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/zerotheking152-png/Gui/main/HamzGui.lua"))()

-- STATES
local AutoFarm, AutoQuest, FastAttack, AutoFruit = false, false, false, false
local ESPEnabled, AntiAFK, FPSBoost = false, false, false

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- REMOVE MAIN TAB
HamzHub.MainTab:Destroy()

-- CREATE TABS
local AutoTab = HamzHub.CreateTab("Automation")
local MiscTab = HamzHub.CreateTab("Misc")

-- UI CONTAINER (clean scrolling)
local function makeContainer(tab)
    local scroll = Instance.new("ScrollingFrame", tab)
    scroll.Size = UDim2.new(1, -10, 1, -10)
    scroll.Position = UDim2.new(0, 5, 0, 5)
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234) -- neon purple accent

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)

    return scroll
end

local AutoContainer = makeContainer(AutoTab)
local MiscContainer = makeContainer(MiscTab)

-- ELEGANT TOGGLE (dark + neon, match HamzGui vibe)
local function toggle(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48) -- elegant dark
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "  " .. text
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextSize = 15
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 10)

    -- neon left accent
    local accent = Instance.new("Frame", btn)
    accent.Size = UDim2.new(0, 5, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 10)

    local state = false

    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
            accent.BackgroundColor3 = Color3.fromRGB(0, 255, 170) -- neon teal-green ON
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
            accent.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
        end
        callback(state)
    end)
end

-- NOCLIP (underground farm)
task.spawn(function()
    while true do
        task.wait()
        if AutoFarm and player.Character then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- IMPROVED TARGET DETECTION (fix utama: hanya NPC musuh, level sesuai/sedikit di atas)
local function getTarget()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end

    local myLevel = (player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value) or 1
    local closest, dist = nil, math.huge

    -- Prioritas folder Enemies kalau ada (banyak game Sailor Piece pake ini)
    local searchAreas = {workspace}
    if workspace:FindFirstChild("Enemies") then table.insert(searchAreas, workspace.Enemies) end
    if workspace:FindFirstChild("Mobs") then table.insert(searchAreas, workspace.Mobs) end

    for _, area in ipairs(searchAreas) do
        for _, v in pairs(area:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                local hum = v.Humanoid
                local root = v.HumanoidRootPart
                local nameLower = v.Name:lower()

                if hum.Health > 0 and not nameLower:find("boss") and not nameLower:find("dummy") and v \~= character then
                    local lvlObj = v:FindFirstChild("Level") or (hum:FindFirstChild("Level") or hum:FindFirstChild("level"))
                    local npcLevel = lvlObj and lvlObj.Value or 1

                    -- Sesuai level atau sedikit di atas (range realistis)
                    if npcLevel >= myLevel - 15 and npcLevel <= myLevel + 12 then
                        local mag = (character.HumanoidRootPart.Position - root.Position).Magnitude
                        if mag < dist and mag < 700 then
                            dist = mag
                            closest = v
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- AUTO EQUIP SENJATA (hotbar)
local function equipBestWeapon()
    if not player.Character or not player.Character:FindFirstChild("Humanoid") then return end
    if player.Character:FindFirstChildWhichIsA("Tool") then return end

    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            player.Character.Humanoid:EquipTool(tool)
            break
        end
    end
end

-- IMPROVED AUTO FARM (fix TP random + auto equip + hit + skill)
task.spawn(function()
    while true do
        task.wait(0.055)
        if AutoFarm and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            equipBestWeapon()

            local target = getTarget()
            if target and target:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                
                -- TP tepat di bawah NPC (underground style)
                root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, -5.8, 0) * CFrame.Angles(0, math.rad(180), 0)

                -- Hit
                pcall(function()
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("CombatSystem")
                        :WaitForChild("Remotes")
                        :WaitForChild("RequestHit")
                        :FireServer()
                end)

                -- Skills (Z X C V)
                pcall(function()
                    for _, key in ipairs({"Z", "X", "C", "V"}) do
                        VirtualInputManager:SendKeyEvent(true, key, false, game)
                        task.wait(0.04)
                        VirtualInputManager:SendKeyEvent(false, key, false, game)
                    end
                end)

                task.wait(FastAttack and 0.032 or 0.085)
            end
        end
    end
end)

-- IMPROVED AUTO QUEST
task.spawn(function()
    while true do
        task.wait(3.5)
        if AutoQuest then
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("QuestAccept")
                    :FireServer("QuestNPC1")
            end)
        end
    end
end)

-- IMPROVED AUTO FRUIT (lebih reliable)
local function findFruit()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:lower():find("fruit") or v:FindFirstChild("Handle")) then
            local handle = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart")
            if handle then
                return handle
            end
        end
    end
    return nil
end

task.spawn(function()
    while true do
        task.wait(1.2)
        if AutoFruit and AutoFarm and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local fruit = findFruit()
            if fruit then
                local root = player.Character.HumanoidRootPart
                local oldCFrame = root.CFrame
                root.CFrame = fruit.CFrame * CFrame.new(0, 4, 0)
                task.wait(1.1) -- lebih lama biar pickup berhasil
                root.CFrame = oldCFrame
            end
        end
    end
end)

-- IMPROVED ESP (tampilkan level + jarak, lebih bersih)
local espCache = {}
task.spawn(function()
    while true do
        task.wait(1.2)
        if ESPEnabled then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and not espCache[v] then
                    local hum = v:FindFirstChild("Humanoid")
                    if hum then
                        local bill = Instance.new("BillboardGui", v)
                        bill.Name = "ESP"
                        bill.Size = UDim2.new(0, 140, 0, 55)
                        bill.AlwaysOnTop = true
                        bill.StudsOffset = Vector3.new(0, 4, 0)

                        local txt = Instance.new("TextLabel", bill)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = v.Name .. "\nLv." .. (hum.Level and hum.Level.Value or "?")
                        txt.TextColor3 = Color3.fromRGB(255, 60, 60)
                        txt.TextStrokeTransparency = 0.4
                        txt.Font = Enum.Font.GothamBold
                        txt.TextScaled = true

                        espCache[v] = bill
                    end
                end
            end
        else
            -- Cleanup ESP pas mati
            for obj, gui in pairs(espCache) do
                if gui and gui.Parent then gui:Destroy() end
            end
            espCache = {}
        end
    end
end)

-- IMPROVED FPS BOOST (lebih agresif)
local function boostFPS()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Graphics.QualityLevel = Enum.QualityLevel.Level01

    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 999999
    lighting.Brightness = 1
    lighting.ClockTime = 14

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            if v:FindFirstChild("Mesh") then v.Mesh:Destroy() end
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
    print("✅ FPS Boost Activated (Ultra Optimized)")
end

-- IMPROVED ANTI AFK
player.Idled:Connect(function()
    if AntiAFK then
        pcall(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.6)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- TOGGLES
toggle(AutoContainer, "Auto Farm", function(v) 
    AutoFarm = v 
    if v then equipBestWeapon() end
end)
toggle(AutoContainer, "Auto Quest", function(v) AutoQuest = v end)
toggle(AutoContainer, "Fast Attack", function(v) FastAttack = v end)
toggle(AutoContainer, "Auto Fruit", function(v) AutoFruit = v end)

toggle(MiscContainer, "ESP", function(v) ESPEnabled = v end)
toggle(MiscContainer, "Anti AFK", function(v) AntiAFK = v end)
toggle(MiscContainer, "FPS Boost", function(v) 
    FPSBoost = v 
    if v then boostFPS() end 
end)

print("✅ HamzHub Ultra - FIXED & IMPROVED Loaded!")
