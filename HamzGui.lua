local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HamzHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingScreen"
loadingFrame.Parent = screenGui
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.Position = UDim2.new(0, 0, 0, 0)

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 16)
loadingCorner.Parent = loadingFrame

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Parent = loadingFrame
loadingTitle.BackgroundTransparency = 1
loadingTitle.Position = UDim2.new(0.5, -250, 0.4, -40)
loadingTitle.Size = UDim2.new(0, 500, 0, 80)
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Text = "HamzHub Is Loading"
loadingTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
loadingTitle.TextSize = 32
loadingTitle.TextStrokeTransparency = 0.8

local progressOuter = Instance.new("Frame")
progressOuter.Parent = loadingFrame
progressOuter.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
progressOuter.Position = UDim2.new(0.5, -250, 0.6, 0)
progressOuter.Size = UDim2.new(0, 500, 0, 12)
local outerCorner = Instance.new("UICorner")
outerCorner.CornerRadius = UDim.new(1, 0)
outerCorner.Parent = progressOuter

local progressInner = Instance.new("Frame")
progressInner.Parent = progressOuter
progressInner.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
progressInner.Size = UDim2.new(0, 0, 1, 0)
local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(1, 0)
innerCorner.Parent = progressInner

local progressText = Instance.new("TextLabel")
progressText.Parent = loadingFrame
progressText.BackgroundTransparency = 1
progressText.Position = UDim2.new(0.5, -250, 0.65, 10)
progressText.Size = UDim2.new(0, 500, 0, 30)
progressText.Font = Enum.Font.Gotham
progressText.Text = "0%"
progressText.TextColor3 = Color3.fromRGB(220, 220, 220)
progressText.TextSize = 18

task.spawn(function()
    for i = 0, 100 do
        progressInner:TweenSize(UDim2.new(i / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.02, true)
        progressText.Text = i .. "%"
        task.wait(0.018)
    end
    
    local fadeTween = TweenService:Create(loadingFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {BackgroundTransparency = 1})
    local titleTween = TweenService:Create(loadingTitle, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {TextTransparency = 1})
    local progressTween = TweenService:Create(progressOuter, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {BackgroundTransparency = 1})
    fadeTween:Play()
    titleTween:Play()
    progressTween:Play()
    progressInner.BackgroundTransparency = 1
    
    fadeTween.Completed:Connect(function()
        loadingFrame:Destroy()
        createMainGUI()
    end)
end)

local function createMainGUI()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
    mainFrame.Size = UDim2.new(0, 520, 0, 420)
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 14)
    mainCorner.Parent = mainFrame
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(0, 255, 100)
    mainStroke.Thickness = 1.8
    mainStroke.Parent = mainFrame

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = mainFrame
    topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topBar.Size = UDim2.new(1, 0, 0, 56)
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 14)
    topCorner.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Parent = topBar
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 24, 0, 0)
    title.Size = UDim2.new(0, 200, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "HamzHub"
    title.TextColor3 = Color3.fromRGB(0, 255, 100)
    title.TextSize = 24
    title.TextXAlignment = Enum.TextXAlignment.Left

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Parent = topBar
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Position = UDim2.new(1, -88, 0.5, -14)
    minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    minimizeBtn.TextSize = 26

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = topBar
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position = UDim2.new(1, -46, 0.5, -14)
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextSize = 28

    local content = Instance.new("ScrollingFrame")
    content.Parent = mainFrame
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, 24, 0, 72)
    content.Size = UDim2.new(1, -48, 1, -88)
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)
    content.CanvasSize = UDim2.new(0, 0, 0, 240)

    local contentList = Instance.new("UIListLayout")
    contentList.Parent = content
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    contentList.Padding = UDim.new(0, 12)

    local miscHeader = Instance.new("TextLabel")
    miscHeader.Parent = content
    miscHeader.BackgroundTransparency = 1
    miscHeader.Size = UDim2.new(1, 0, 0, 38)
    miscHeader.Font = Enum.Font.GothamBold
    miscHeader.Text = "Misc"
    miscHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    miscHeader.TextSize = 26
    miscHeader.TextXAlignment = Enum.TextXAlignment.Left

    local function createToggle(text, defaultOn, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Parent = content
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.Size = UDim2.new(1, 0, 0, 52)

        local label = Instance.new("TextLabel")
        label.Parent = toggleFrame
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0.72, 0, 1, 0)
        label.Font = Enum.Font.GothamSemibold
        label.Text = text
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Left

        local switch = Instance.new("Frame")
        switch.Parent = toggleFrame
        switch.BackgroundColor3 = defaultOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
        switch.Position = UDim2.new(0.78, 0, 0.5, -13)
        switch.Size = UDim2.new(0, 62, 0, 26)
        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(1, 0)
        switchCorner.Parent = switch

        local knob = Instance.new("Frame")
        knob.Parent = switch
        knob.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        knob.Position = defaultOn and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        knob.Size = UDim2.new(0, 18, 0, 18)
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(1, 0)
        knobCorner.Parent = knob

        local toggled = defaultOn

        local function updateVisual()
            if toggled then
                switch.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
                TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Position = UDim2.new(1, -22, 0.5, -9)}):Play()
            else
                switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
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

    createToggle("Ultra FPS Booster", false, function(state)
        if state then
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 1000000
                settings().Rendering.QualityLevel = 1
            end)
            print("✅ Ultra FPS Booster: ON")
        else
            pcall(function()
                Lighting.GlobalShadows = true
                Lighting.FogEnd = 100000
            end)
            print("❌ Ultra FPS Booster: OFF")
        end
    end)

    createToggle("ESP", false, nil)
    createToggle("Anti AFK", false, nil)

    createToggle("Panel", false, function(state)
        hamzPanel.Visible = state
    end)

    local dragging, dragInput, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local isMinimized = false
    local originalSize = mainFrame.Size
    local originalPosition = mainFrame.Position

    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            minimizeBtn.Text = "＋"
            TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 520, 0, 56)
            }):Play()
            content.Visible = false
        else
            minimizeBtn.Text = "−"
            TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
                Size = originalSize
            }):Play()
            task.wait(0.2)
            content.Visible = true
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local closeTween = TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, -10, 0.5, -10)
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)

    local hamzPanel = Instance.new("Frame")
    hamzPanel.Name = "HamzPanel"
    hamzPanel.Parent = screenGui
    hamzPanel.BackgroundColor3 = Color3.fromRGB(0, 130, 75)
    hamzPanel.Position = UDim2.new(0.5, -160, 0.08, 0)
    hamzPanel.Size = UDim2.new(0, 320, 0, 190)
    hamzPanel.Visible = false
    local pCorner = Instance.new("UICorner")
    pCorner.CornerRadius = UDim.new(0, 16)
    pCorner.Parent = hamzPanel
    local pStroke = Instance.new("UIStroke")
    pStroke.Color = Color3.fromRGB(255, 255, 255)
    pStroke.Thickness = 2
    pStroke.Parent = hamzPanel

    local logo = Instance.new("Frame")
    logo.Parent = hamzPanel
    logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    logo.Position = UDim2.new(0, 18, 0, 14)
    logo.Size = UDim2.new(0, 42, 0, 42)
    local lCorner = Instance.new("UICorner")
    lCorner.CornerRadius = UDim.new(0, 10)
    lCorner.Parent = logo
    local lText = Instance.new("TextLabel")
    lText.Parent = logo
    lText.BackgroundTransparency = 1
    lText.Size = UDim2.new(1, 0, 1, 0)
    lText.Font = Enum.Font.GothamBold
    lText.Text = "H"
    lText.TextColor3 = Color3.fromRGB(0, 255, 100)
    lText.TextSize = 30

    local titlePanel = Instance.new("TextLabel")
    titlePanel.Parent = hamzPanel
    titlePanel.BackgroundTransparency = 1
    titlePanel.Position = UDim2.new(0, 72, 0, 17)
    titlePanel.Size = UDim2.new(1, -100, 0, 32)
    titlePanel.Font = Enum.Font.GothamBold
    titlePanel.Text = "HAMZ MONITOR KETUA"
    titlePanel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titlePanel.TextSize = 19
    titlePanel.TextXAlignment = Enum.TextXAlignment.Left

    local autoText = Instance.new("TextLabel")
    autoText.Parent = hamzPanel
    autoText.BackgroundTransparency = 0.8
    autoText.Position = UDim2.new(0, 22, 0, 52)
    autoText.Size = UDim2.new(1, -44, 0, 52)
    autoText.Font = Enum.Font.GothamBlack
    autoText.Text = "AUTO"
    autoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoText.TextSize = 54
    autoText.TextTransparency = 0.7

    local pingLbl = Instance.new("TextLabel")
    pingLbl.Parent = hamzPanel
    pingLbl.BackgroundTransparency = 1
    pingLbl.Position = UDim2.new(0, 28, 0, 112)
    pingLbl.Size = UDim2.new(0.48, 0, 0, 28)
    pingLbl.Font = Enum.Font.Gotham
    pingLbl.Text = "Ping: 56 ms"
    pingLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    pingLbl.TextSize = 19
    pingLbl.TextXAlignment = Enum.TextXAlignment.Left

    local fpsLbl = Instance.new("TextLabel")
    fpsLbl.Parent = hamzPanel
    fpsLbl.BackgroundTransparency = 1
    fpsLbl.Position = UDim2.new(0.5, 8, 0, 112)
    fpsLbl.Size = UDim2.new(0.48, 0, 0, 28)
    fpsLbl.Font = Enum.Font.Gotham
    fpsLbl.Text = "FPS: 62"
    fpsLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLbl.TextSize = 19
    fpsLbl.TextXAlignment = Enum.TextXAlignment.Right

    local divider = Instance.new("Frame")
    divider.Parent = hamzPanel
    divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    divider.Position = UDim2.new(0.5, 0, 0, 114)
    divider.Size = UDim2.new(0, 2, 0, 24)

    local notifLbl = Instance.new("TextLabel")
    notifLbl.Parent = hamzPanel
    notifLbl.BackgroundTransparency = 1
    notifLbl.Position = UDim2.new(0, 26, 0, 148)
    notifLbl.Size = UDim2.new(1, -52, 0, 28)
    notifLbl.Font = Enum.Font.Gotham
    notifLbl.Text = "Notifications: 8"
    notifLbl.TextColor3 = Color3.fromRGB(255, 230, 0)
    notifLbl.TextSize = 19
    notifLbl.TextXAlignment = Enum.TextXAlignment.Center

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
        local ping = Stats.Network.ServerStatsItem:FindFirstChild("Ping")
        if ping then
            pingLbl.Text = "Ping: " .. math.floor(ping.Value) .. " ms"
        else
            pingLbl.Text = "Ping: -- ms"
        end
    end)

    local panelDragging = false
    titlePanel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            panelDragging = true
            local dragStartPos = input.Position
            local startPanelPos = hamzPanel.Position
            local conn
            conn = UserInputService.InputChanged:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseMovement and panelDragging then
                    local delta = inp.Position - dragStartPos
                    hamzPanel.Position = UDim2.new(startPanelPos.X.Scale, startPanelPos.X.Offset + delta.X, startPanelPos.Y.Scale, startPanelPos.Y.Offset + delta.Y)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    panelDragging = false
                    conn:Disconnect()
                end
            end)
        end
    end)
end
