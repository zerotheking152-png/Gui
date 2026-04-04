local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "HamzHubBeta"
gui.Parent = player:WaitForChild("PlayerGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

-- ====================== ELEGANT LOADING SCREEN ======================
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(8, 20, 12)
loadingFrame.BackgroundTransparency = 0

local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 0
TweenService:Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Size = 28}):Play()

-- Container tengah
local loaderContainer = Instance.new("Frame", loadingFrame)
loaderContainer.Size = UDim2.new(0, 420, 0, 240)
loaderContainer.Position = UDim2.new(0.5, -210, 0.5, -120)
loaderContainer.BackgroundTransparency = 1

-- Logo HamzHub besar neon
local logoLabel = Instance.new("TextLabel", loaderContainer)
logoLabel.Size = UDim2.new(1, 0, 0, 90)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "HamzHub"
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextSize = 58
logoLabel.TextColor3 = Color3.fromRGB(0, 255, 140)
logoLabel.TextStrokeTransparency = 0.7
logoLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 140)

-- Subtitle
local subtitle = Instance.new("TextLabel", loaderContainer)
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 95)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Is loading"
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 22
subtitle.TextColor3 = Color3.fromRGB(180, 255, 200)
subtitle.TextTransparency = 0.1

-- Progress Bar elegan
local progressBg = Instance.new("Frame", loaderContainer)
progressBg.Size = UDim2.new(0, 340, 0, 18)
progressBg.Position = UDim2.new(0.5, -170, 0, 165)
progressBg.BackgroundColor3 = Color3.fromRGB(20, 35, 25)
progressBg.BorderSizePixel = 0
Instance.new("UICorner", progressBg).CornerRadius = UDim.new(1, 0)

local progressFill = Instance.new("Frame", progressBg)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
progressFill.BorderSizePixel = 0
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

local progressGlow = Instance.new("UIStroke", progressFill)
progressGlow.Color = Color3.fromRGB(0, 255, 140)
progressGlow.Thickness = 3
progressGlow.Transparency = 0.4

local percentLabel = Instance.new("TextLabel", loaderContainer)
percentLabel.Size = UDim2.new(1, 0, 0, 30)
percentLabel.Position = UDim2.new(0.5, -170, 0, 190)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 19
percentLabel.TextColor3 = Color3.fromRGB(0, 255, 140)

-- Animasi progress 0% - 100%
task.spawn(function()
	for i = 0, 100 do
		TweenService:Create(progressFill, TweenInfo.new(0.028, Enum.EasingStyle.Linear), {
			Size = UDim2.new(i / 100, 0, 1, 0)
		}):Play()
		percentLabel.Text = i .. "%"
		task.wait(0.028)
	end
	
	-- Fade out loading
	TweenService:Create(loadingFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
	TweenService:Create(blur, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = 0}):Play()
	task.wait(0.8)
	loadingFrame:Destroy()
	blur:Destroy()
	
	print("✅ HamzHub Beta Tester loaded successfully!")
end)

-- ====================== MAIN GUI ======================
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 360, 0, 270)
main.Position = UDim2.new(0.5, -180, 0.5, -135)
main.BackgroundColor3 = Color3.fromRGB(18, 35, 18)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local border = Instance.new("UIStroke", main)
border.Color = Color3.fromRGB(0, 255, 140)
border.Thickness = 3

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundColor3 = Color3.fromRGB(20, 45, 20)
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 14)

-- Logo shield
local logoFrame = Instance.new("Frame", top)
logoFrame.Size = UDim2.new(0, 52, 0, 52)
logoFrame.Position = UDim2.new(0.5, -26, -0.2, 0)
logoFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", logoFrame).CornerRadius = UDim.new(0, 14)

local logoInner = Instance.new("Frame", logoFrame)
logoInner.Size = UDim2.new(0.85, 0, 0.85, 0)
logoInner.Position = UDim2.new(0.075, 0, 0.075, 0)
logoInner.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
Instance.new("UICorner", logoInner).CornerRadius = UDim.new(0, 12)

local logoText = Instance.new("TextLabel", logoInner)
logoText.Size = UDim2.new(1,0,1,0)
logoText.BackgroundTransparency = 1
logoText.Text = "🛡️"
logoText.Font = Enum.Font.GothamBold
logoText.TextSize = 32
logoText.TextColor3 = Color3.fromRGB(8, 20, 12)

-- Title
local title = Instance.new("TextLabel", top)
title.Text = "HamzHub Beta Tester"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0, 255, 140)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 14, 0, 0)
title.Size = UDim2.new(0, 200, 1, 0)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar
local side = Instance.new("Frame", main)
side.Size = UDim2.new(0, 105, 1, -48)
side.Position = UDim2.new(0, 0, 0, 48)
side.BackgroundColor3 = Color3.fromRGB(15, 30, 15)

local greenBar = Instance.new("Frame", side)
greenBar.Size = UDim2.new(0, 5, 1, 0)
greenBar.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
greenBar.Position = UDim2.new(0, 0, 0, 0)

local layout = Instance.new("UIListLayout", side)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function createTab(name)
	local btn = Instance.new("TextButton", side)
	btn.Size = UDim2.new(1, 0, 0, 42)
	btn.BackgroundTransparency = 1
	btn.Text = name
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(190, 190, 190)
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.TextWrapped = true
	return btn
end

local tabPlayerBtn = createTab("Player")
local tabMainBtn   = createTab("Main")

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -105, 1, -48)
content.Position = UDim2.new(0, 105, 0, 48)
content.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
	local frame = Instance.new("Frame", content)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.Visible = false
	frame.BackgroundTransparency = 1

	local header = Instance.new("TextLabel", frame)
	header.Size = UDim2.new(1, 0, 0, 34)
	header.BackgroundTransparency = 1
	header.Text = name:upper()
	header.Font = Enum.Font.GothamBold
	header.TextSize = 18
	header.TextColor3 = Color3.fromRGB(255, 255, 255)
	header.TextXAlignment = Enum.TextXAlignment.Left
	header.Position = UDim2.new(0, 18, 0, 0)

	local listLayout = Instance.new("UIListLayout", frame)
	listLayout.Padding = UDim.new(0, 8)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder

	pages[name] = frame
	return frame
end

local playerPage = createPage("Player")
local mainPage   = createPage("Main")

local currentTab = nil
local function highlight(btn, active)
	if active then
		btn.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
		btn.BackgroundTransparency = 0.85
		btn.TextColor3 = Color3.fromRGB(0, 255, 140)
	else
		btn.BackgroundTransparency = 1
		btn.TextColor3 = Color3.fromRGB(190, 190, 190)
	end
end

local function switch(page)
	for k, v in pairs(pages) do v.Visible = (k == page) end
	if currentTab then highlight(currentTab, false) end
	if page == "Player" then currentTab = tabPlayerBtn
	elseif page == "Main" then currentTab = tabMainBtn end
	highlight(currentTab, true)
end

tabPlayerBtn.MouseButton1Click:Connect(function() switch("Player") end)
tabMainBtn.MouseButton1Click:Connect(function() switch("Main") end)
switch("Main")

-- Test Button + Avatar
local testButton = Instance.new("TextButton", mainPage)
testButton.Size = UDim2.new(0, 260, 0, 58)
testButton.Position = UDim2.new(0.5, -130, 0.28, 0)
testButton.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
testButton.Text = "Test Button"
testButton.Font = Enum.Font.GothamBold
testButton.TextSize = 26
testButton.TextColor3 = Color3.fromRGB(8, 20, 12)
Instance.new("UICorner", testButton).CornerRadius = UDim.new(0, 14)

testButton.MouseButton1Click:Connect(function()
	print("✅ Test Button clicked - HamzHub Beta Tester")
end)

local avatarViewport = Instance.new("ViewportFrame", mainPage)
avatarViewport.Size = UDim2.new(0, 210, 0, 160)
avatarViewport.Position = UDim2.new(0.5, -105, 0.58, 0)
avatarViewport.BackgroundTransparency = 1
avatarViewport.BorderSizePixel = 0

local viewportCam = Instance.new("Camera")
avatarViewport.CurrentCamera = viewportCam

task.spawn(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local clone = char:Clone()
	clone.Parent = avatarViewport
	for _, obj in ipairs(clone:GetDescendants()) do
		if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy() end
	end
	viewportCam.CFrame = CFrame.new(Vector3.new(0, 2.5, 6)) * CFrame.Angles(math.rad(-15), math.rad(180), 0)
	clone:PivotTo(CFrame.new(0, 0, 0))
end)

-- ====================== FITUR ======================
local vu = game:GetService("VirtualUser")
local antiAfkEnabled = false
local idledConn = nil

task.spawn(function()
	while true do
		task.wait(40)
		if antiAfkEnabled then
			local cam = workspace.CurrentCamera
			vu:Button2Down(Vector2.new(0,0), cam.CFrame)
			task.wait(0.15)
			vu:Button2Up(Vector2.new(0,0), cam.CFrame)
		end
	end
end)

local function createToggle(parent, text, callback)
	local frame = Instance.new("Frame", parent)
	frame.Size = UDim2.new(1, 0, 0, 38)
	frame.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(0.65, 0, 1, 0)
	label.Position = UDim2.new(0, 18, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local toggleBtn = Instance.new("TextButton", frame)
	toggleBtn.Size = UDim2.new(0, 48, 0, 24)
	toggleBtn.Position = UDim2.new(1, -66, 0.5, -12)
	toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
	toggleBtn.Text = ""
	Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame", toggleBtn)
	knob.Size = UDim2.new(0, 20, 0, 20)
	knob.Position = UDim2.new(0, 2, 0.5, -10)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local state = false
	toggleBtn.MouseButton1Click:Connect(function()
		state = not state
		TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
			Position = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
		}):Play()
		toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(30, 50, 30)
		if callback then callback(state) end
	end)
end

createToggle(mainPage, "Anti AFK", function(v)
	antiAfkEnabled = v
	if v and not idledConn then
		idledConn = player.Idled:Connect(function()
			if antiAfkEnabled then
				local cam = workspace.CurrentCamera
				vu:Button2Down(Vector2.new(0,0), cam.CFrame)
				task.wait(1)
				vu:Button2Up(Vector2.new(0,0), cam.CFrame)
			end
		end)
	end
end)

createToggle(mainPage, "FPS Booster", function(v)
	Lighting.GlobalShadows = not v
	Lighting.FogEnd = v and 1e9 or 100000
end)

-- ESP FIXED
local espEnabled = false
local highlights = {}
local npcConnection = nil

local function addHighlight(char)
	if char:FindFirstChild("Highlight") then return end
	local hl = Instance.new("Highlight")
	hl.Adornee = char
	hl.FillColor = Color3.fromRGB(0, 255, 140)
	hl.OutlineColor = Color3.fromRGB(255, 255, 255)
	hl.FillTransparency = 0.65
	hl.OutlineTransparency = 0
	hl.Parent = char
	table.insert(highlights, hl)
end

local function toggleESP(v)
	espEnabled = v
	for _, hl in ipairs(highlights) do hl:Destroy() end
	highlights = {}

	if not v then
		if npcConnection then npcConnection:Disconnect() npcConnection = nil end
		return
	end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr \~= player and plr.Character then addHighlight(plr.Character) end
		plr.CharacterAdded:Connect(function(char) if espEnabled then addHighlight(char) end end)
	end

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
			addHighlight(obj)
		end
	end

	npcConnection = workspace.DescendantAdded:Connect(function(desc)
		if desc:IsA("Model") and desc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(desc) then
			task.wait(0.1)
			if espEnabled then addHighlight(desc) end
		end
	end)
end

createToggle(mainPage, "ESP", toggleESP)

-- Panel FPS/Ping
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 320, 0, 138)
panel.Position = UDim2.new(0.5, -160, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(0, 190, 90)
panel.Visible = false
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 18)

local logoBg = Instance.new("Frame", panel)
logoBg.Size = UDim2.new(0, 46, 0, 46)
logoBg.Position = UDim2.new(0, 16, 0, 14)
logoBg.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", logoBg).CornerRadius = UDim.new(0, 12)

local logoTxt = Instance.new("TextLabel", logoBg)
logoTxt.Size = UDim2.new(1,0,1,0)
logoTxt.BackgroundTransparency = 1
logoTxt.Text = "HAMZ"
logoTxt.Font = Enum.Font.GothamBold
logoTxt.TextSize = 21
logoTxt.TextColor3 = Color3.fromRGB(0, 255, 140)

local panelTitle = Instance.new("TextLabel", panel)
panelTitle.Text = "Panel HAMZ"
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 24
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.BackgroundTransparency = 1
panelTitle.Position = UDim2.new(0, 74, 0, 18)
panelTitle.Size = UDim2.new(0, 220, 0, 30)
panelTitle.TextXAlignment = Enum.TextXAlignment.Left

local div1 = Instance.new("Frame", panel)
div1.Size = UDim2.new(1, -32, 0, 2)
div1.Position = UDim2.new(0, 16, 0, 68)
div1.BackgroundColor3 = Color3.fromRGB(255,255,255)
div1.BackgroundTransparency = 0.65

local statsArea = Instance.new("Frame", panel)
statsArea.Size = UDim2.new(1, -32, 0, 42)
statsArea.Position = UDim2.new(0, 16, 0, 76)
statsArea.BackgroundTransparency = 1

local pingLabel = Instance.new("TextLabel", statsArea)
pingLabel.Size = UDim2.new(0.48, 0, 1, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: -- ms"
pingLabel.Font = Enum.Font.Gotham
pingLabel.TextSize = 20
pingLabel.TextColor3 = Color3.fromRGB(255,255,255)
pingLabel.TextXAlignment = Enum.TextXAlignment.Left

local fpsLabel = Instance.new("TextLabel", statsArea)
fpsLabel.Size = UDim2.new(0.48, 0, 1, 0)
fpsLabel.Position = UDim2.new(0.52, 0, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 20
fpsLabel.TextColor3 = Color3.fromRGB(255,255,255)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right

local vDiv = Instance.new("Frame", statsArea)
vDiv.Size = UDim2.new(0, 2, 0, 30)
vDiv.Position = UDim2.new(0.5, -1, 0, 6)
vDiv.BackgroundColor3 = Color3.fromRGB(255,255,255)
vDiv.BackgroundTransparency = 0.6

local div2 = Instance.new("Frame", panel)
div2.Size = UDim2.new(1, -32, 0, 2)
div2.Position = UDim2.new(0, 16, 0, 124)
div2.BackgroundColor3 = Color3.fromRGB(255,255,255)
div2.BackgroundTransparency = 0.65

createToggle(mainPage, "Panel FPS/Ping", function(v)
	panel.Visible = v
end)

local fpsCount = 0
RunService.RenderStepped:Connect(function() fpsCount += 1 end)

task.spawn(function()
	while true do
		task.wait(1)
		local color = fpsCount >= 55 and Color3.fromRGB(0, 255, 140) or fpsCount >= 35 and Color3.fromRGB(255, 240, 80) or Color3.fromRGB(255, 90, 90)
		fpsLabel.Text = "FPS: " .. fpsCount
		fpsLabel.TextColor3 = color
		fpsCount = 0
	end
end)

task.spawn(function()
	while true do
		task.wait(0.5)
		local pingObj = Stats.Network.ServerStatsItem:FindFirstChild("Data Ping")
		if pingObj then
			local val = math.floor(pingObj:GetValue())
			local color = val <= 70 and Color3.fromRGB(0, 255, 140) or val <= 140 and Color3.fromRGB(255, 240, 80) or Color3.fromRGB(255, 90, 90)
			pingLabel.Text = "Ping: " .. val .. " ms"
			pingLabel.TextColor3 = color
		end
	end
end)

-- DRAGGABLE MAIN GUI
local dragging, dragStart, startPos = false, nil, nil
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)
main.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)
RunService.RenderStepped:Connect(function()
	if dragging and dragStart then
		local currentPos = UserInputService:GetMouseLocation()
		local delta = currentPos - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		dragStart = currentPos
	end
end)

-- DRAGGABLE PANEL
local draggingPanel, dragStartPanel, startPosPanel = false, nil, nil
panel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = true
		dragStartPanel = input.Position
		startPosPanel = panel.Position
	end
end)
panel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingPanel = false
	end
end)
RunService.RenderStepped:Connect(function()
	if draggingPanel and dragStartPanel then
		local currentPos = UserInputService:GetMouseLocation()
		local delta = currentPos - dragStartPanel
		panel.Position = UDim2.new(startPosPanel.X.Scale, startPosPanel.X.Offset + delta.X, startPosPanel.Y.Scale, startPosPanel.Y.Offset + delta.Y)
		dragStartPanel = currentPos
	end
end)

print("🚀 HamzHub Beta Tester siap! Loading screen baru + semua fitur fixed.")
