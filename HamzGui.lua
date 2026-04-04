-- =============================================
-- HamzHub GUI - Custom by Grok (100% mirip request lu)
-- Warna hijau, 2 tab, HamzPanel dengan FPS+Ping real
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HamzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui") -- ganti ke CoreGui kalau executor lu butuh

-- ================== MAIN FRAME ==================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.Size = UDim2.new(0, 600, 0, 400)
local mainCorner = Instance.new("UICorner"); mainCorner.CornerRadius = UDim.new(0, 10); mainCorner.Parent = mainFrame
local mainStroke = Instance.new("UIStroke"); mainStroke.Color = Color3.fromRGB(0, 255, 100); mainStroke.Thickness = 1.5; mainStroke.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Parent = mainFrame
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.Size = UDim2.new(1, 0, 0, 50)
local topCorner = Instance.new("UICorner"); topCorner.CornerRadius = UDim.new(0, 10); topCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Parent = topBar
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 20, 0, 0)
title.Size = UDim2.new(0, 200, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "HamzHub"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left

-- Icon kecil (mirip Lynx)
local icon = Instance.new("Frame")
icon.Parent = topBar
icon.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
icon.Position = UDim2.new(0, 160, 0.5, -10)
icon.Size = UDim2.new(0, 20, 0, 20)
local iconCorner = Instance.new("UICorner"); iconCorner.CornerRadius = UDim.new(1, 0); iconCorner.Parent = icon

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = topBar
closeBtn.BackgroundTransparency = 1
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 28
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- Draggable
local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ================== SIDEBAR (2 TAB ONLY) ==================
local sidebar = Instance.new("Frame")
sidebar.Parent = mainFrame
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.Size = UDim2.new(0, 160, 1, -50)
local sidebarCorner = Instance.new("UICorner"); sidebarCorner.CornerRadius = UDim.new(0, 10); sidebarCorner.Parent = sidebar

local function createTabButton(name, yPos)
    local btn = Instance.new("TextButton")
    btn.Parent = sidebar
    btn.BackgroundTransparency = 1
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.Size = UDim2.new(1, -30, 0, 50)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 18
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local iconLbl = Instance.new("TextLabel")
    iconLbl.Parent = btn
    iconLbl.BackgroundTransparency = 1
    iconLbl.Size = UDim2.new(0, 30, 1, 0)
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.Text = name == "Main" and "🏠" or "⚙️"
    iconLbl.TextColor3 = Color3.fromRGB(0, 255, 100)
    iconLbl.TextSize = 24
    return btn
end

local mainTabBtn = createTabButton("Main", 20)
local miscTabBtn = createTabButton("Misc", 80)

-- ================== CONTENT AREA ==================
local content = Instance.new("Frame")
content.Parent = mainFrame
content.BackgroundTransparency = 1
content.Position = UDim2.new(0, 170, 0, 60)
content.Size = UDim2.new(1, -180, 1, -80)

local contentList = Instance.new("UIListLayout")
contentList.Parent = content
contentList.SortOrder = Enum.SortOrder.LayoutOrder
contentList.Padding = UDim.new(0, 8)

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end
end

-- Toggle Creator
local function createToggle(text, defaultOn, parent, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = parent
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Size = UDim2.new(1, 0, 0, 45)
    
    local label = Instance.new("TextLabel")
    label.Parent = toggleFrame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 17
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local switch = Instance.new("Frame")
    switch.Parent = toggleFrame
    switch.BackgroundColor3 = defaultOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(80, 80, 80)
    switch.Position = UDim2.new(0.7, 0, 0.5, -10)
    switch.Size = UDim2.new(0, 52, 0, 20)
    local switchCorner = Instance.new("UICorner"); switchCorner.CornerRadius = UDim.new(1, 0); switchCorner.Parent = switch
    
    local knob = Instance.new("Frame")
    knob.Parent = switch
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Position = defaultOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.Size = UDim2.new(0, 16, 0, 16)
    local knobCorner = Instance.new("UICorner"); knobCorner.CornerRadius = UDim.new(1, 0); knobCorner.Parent = knob
    
    local toggled = defaultOn
    
    local function updateVisual()
        if toggled then
            switch.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            switch.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
    end
    
    switch.MouseButton1Click:Connect(function()
        toggled = not toggled
        updateVisual()
        if callback then callback(toggled) end
    end)
    
    updateVisual()
    return toggleFrame
end

-- ================== LOAD TAB FUNCTIONS ==================
local currentTab = "Main"

local function loadMainTab()
    clearContent()
    currentTab = "Main"
    
    local titleMain = Instance.new("TextLabel")
    titleMain.Parent = content
    titleMain.BackgroundTransparency = 1
    titleMain.Size = UDim2.new(1, 0, 0, 35)
    titleMain.Font = Enum.Font.GothamBold
    titleMain.Text = "Main"
    titleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleMain.TextSize = 22
    titleMain.TextXAlignment = Enum.TextXAlignment.Left
    
    Instance.new("TextLabel").Parent = content -- Ini Blatant kayaknya
    local blatant = content:FindFirstChildWhichIsA("TextLabel", true) or Instance.new("TextLabel")
    blatant.Text = "Ini Blatant kayaknya"
    blatant.TextColor3 = Color3.fromRGB(255, 255, 255)
    blatant.TextSize = 17
    blatant.Size = UDim2.new(1, 0, 0, 30)
    blatant.BackgroundTransparency = 1
    blatant.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Complete Delay
    local delayFrame = Instance.new("Frame")
    delayFrame.Parent = content
    delayFrame.BackgroundTransparency = 1
    delayFrame.Size = UDim2.new(1, 0, 0, 30)
    local delayLbl = Instance.new("TextLabel")
    delayLbl.Parent = delayFrame
    delayLbl.BackgroundTransparency = 1
    delayLbl.Size = UDim2.new(0.65, 0, 1, 0)
    delayLbl.Text = "Complete Delay"
    delayLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    delayLbl.TextSize = 17
    delayLbl.TextXAlignment = Enum.TextXAlignment.Left
    local delayVal = Instance.new("TextLabel")
    delayVal.Parent = delayFrame
    delayVal.BackgroundTransparency = 1
    delayVal.Position = UDim2.new(0.65, 0, 0, 0)
    delayVal.Size = UDim2.new(0.35, 0, 1, 0)
    delayVal.Text = "0.4S"
    delayVal.TextColor3 = Color3.fromRGB(0, 255, 100)
    delayVal.TextSize = 17
    delayVal.TextXAlignment = Enum.TextXAlignment.Right
    
    createToggle("Enable Ultra Blatant", true, content) -- default ON seperti foto
    
    Instance.new("TextLabel").Parent = content -- Legit Fishing
    local legit = content:FindFirstChildWhichIsA("TextLabel", true) or Instance.new("TextLabel")
    legit.Text = "Legit Fishing"
    legit.TextColor3 = Color3.fromRGB(255, 255, 255)
    legit.TextSize = 17
    legit.Size = UDim2.new(1, 0, 0, 30)
    legit.BackgroundTransparency = 1
    legit.TextXAlignment = Enum.TextXAlignment.Left
    
    Instance.new("TextLabel").Parent = content -- Instant Fishing
    local instant = content:FindFirstChildWhichIsA("TextLabel", true) or Instance.new("TextLabel")
    instant.Text = "Instant Fishing"
    instant.TextColor3 = Color3.fromRGB(255, 255, 255)
    instant.TextSize = 17
    instant.Size = UDim2.new(1, 0, 0, 30)
    instant.BackgroundTransparency = 1
    instant.TextXAlignment = Enum.TextXAlignment.Left
end

local function loadMiscTab()
    clearContent()
    currentTab = "Misc"
    
    local titleMisc = Instance.new("TextLabel")
    titleMisc.Parent = content
    titleMisc.BackgroundTransparency = 1
    titleMisc.Size = UDim2.new(1, 0, 0, 35)
    titleMisc.Font = Enum.Font.GothamBold
    titleMisc.Text = "Misc"
    titleMisc.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleMisc.TextSize = 22
    titleMisc.TextXAlignment = Enum.TextXAlignment.Left
    
    createToggle("Ultra FPS Booster", false, content)
    createToggle("ESP", false, content)
    createToggle("Anti AFK", false, content)
    
    -- Panel Toggle (spesial)
    createToggle("Panel", false, content, function(state)
        hamzPanel.Visible = state
    end)
end

-- Tab Click
mainTabBtn.MouseButton1Click:Connect(loadMainTab)
miscTabBtn.MouseButton1Click:Connect(loadMiscTab)

-- ================== HAMZPANEL (GUI KECIL) ==================
local hamzPanel = Instance.new("Frame")
hamzPanel.Name = "HamzPanel"
hamzPanel.Parent = screenGui
hamzPanel.BackgroundColor3 = Color3.fromRGB(0, 140, 80) -- hijau sesuai request
hamzPanel.Position = UDim2.new(0.5, -160, 0.1, 0)
hamzPanel.Size = UDim2.new(0, 320, 0, 190)
hamzPanel.Visible = false
local pCorner = Instance.new("UICorner"); pCorner.CornerRadius = UDim.new(0, 14); pCorner.Parent = hamzPanel
local pStroke = Instance.new("UIStroke"); pStroke.Color = Color3.fromRGB(255,255,255); pStroke.Thickness = 2; pStroke.Parent = hamzPanel

-- Logo kiri atas
local logo = Instance.new("Frame")
logo.Parent = hamzPanel
logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logo.Position = UDim2.new(0, 15, 0, 12)
logo.Size = UDim2.new(0, 42, 0, 42)
local lCorner = Instance.new("UICorner"); lCorner.CornerRadius = UDim.new(0, 8); lCorner.Parent = logo
local lText = Instance.new("TextLabel")
lText.Parent = logo
lText.BackgroundTransparency = 1
lText.Size = UDim2.new(1,0,1,0)
lText.Font = Enum.Font.GothamBold
lText.Text = "H"
lText.TextColor3 = Color3.fromRGB(0, 255, 100)
lText.TextSize = 28

-- Title
local titlePanel = Instance.new("TextLabel")
titlePanel.Parent = hamzPanel
titlePanel.BackgroundTransparency = 1
titlePanel.Position = UDim2.new(0, 70, 0, 15)
titlePanel.Size = UDim2.new(1, -90, 0, 30)
titlePanel.Font = Enum.Font.GothamBold
titlePanel.Text = "HAMZ MONITOR KETUA"
titlePanel.TextColor3 = Color3.fromRGB(255, 255, 255)
titlePanel.TextSize = 19

-- AUTO text (faint besar)
local autoText = Instance.new("TextLabel")
autoText.Parent = hamzPanel
autoText.BackgroundTransparency = 0.85
autoText.Position = UDim2.new(0, 20, 0, 45)
autoText.Size = UDim2.new(1, -40, 0, 55)
autoText.Font = Enum.Font.GothamBlack
autoText.Text = "AUTO"
autoText.TextColor3 = Color3.fromRGB(255, 255, 255)
autoText.TextSize = 58
autoText.TextTransparency = 0.65

-- Stats
local pingLbl = Instance.new("TextLabel")
pingLbl.Parent = hamzPanel
pingLbl.BackgroundTransparency = 1
pingLbl.Position = UDim2.new(0, 25, 0, 105)
pingLbl.Size = UDim2.new(0.5, 0, 0, 30)
pingLbl.Font = Enum.Font.Gotham
pingLbl.Text = "Ping: 56 ms"
pingLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLbl.TextSize = 19
pingLbl.TextXAlignment = Enum.TextXAlignment.Left

local fpsLbl = Instance.new("TextLabel")
fpsLbl.Parent = hamzPanel
fpsLbl.BackgroundTransparency = 1
fpsLbl.Position = UDim2.new(0.5, 5, 0, 105)
fpsLbl.Size = UDim2.new(0.5, -30, 0, 30)
fpsLbl.Font = Enum.Font.Gotham
fpsLbl.Text = "FPS: 62"
fpsLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLbl.TextSize = 19
fpsLbl.TextXAlignment = Enum.TextXAlignment.Right

local divider = Instance.new("Frame")
divider.Parent = hamzPanel
divider.BackgroundColor3 = Color3.fromRGB(255,255,255)
divider.Position = UDim2.new(0.5, 0, 0, 108)
divider.Size = UDim2.new(0, 2, 0, 24)

local notifLbl = Instance.new("TextLabel")
notifLbl.Parent = hamzPanel
notifLbl.BackgroundTransparency = 1
notifLbl.Position = UDim2.new(0, 25, 0, 145)
notifLbl.Size = UDim2.new(1, -50, 0, 30)
notifLbl.Font = Enum.Font.Gotham
notifLbl.Text = "Notifications: 8"
notifLbl.TextColor3 = Color3.fromRGB(255, 220, 0)
notifLbl.TextSize = 19
notifLbl.TextXAlignment = Enum.TextXAlignment.Center

-- ================== REAL FPS & PING LOGIC ==================
local fpsCount = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    fpsCount += 1
    if tick() - lastTime >= 1 then
        fpsLbl.Text = "FPS: " .. fpsCount
        fpsCount = 0
        lastTime = tick()
    end
end)

RunService.RenderStepped:Connect(function()
    local serverStats = Stats.Network.ServerStatsItem
    local pingObj = serverStats and serverStats:FindFirstChild("Ping")
    if pingObj then
        pingLbl.Text = "Ping: " .. math.floor(pingObj.Value) .. " ms"
    else
        pingLbl.Text = "Ping: -- ms"
    end
end)

-- ================== DEFAULT LOAD ==================
loadMainTab()

print("✅ HamzHub GUI berhasil dimuat! Panel hijau + FPS/Ping work.")
