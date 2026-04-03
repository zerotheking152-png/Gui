local HamzHub = {}

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local IMAGE_ID = "rbxassetid://7733658504"

-- ==================== LOADING ====================
local LoadingGui = Instance.new("ScreenGui", game.CoreGui)
LoadingGui.IgnoreGuiInset = true

local BG = Instance.new("Frame", LoadingGui)
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = Color3.fromRGB(5,10,5)

local Title = Instance.new("TextLabel", BG)
Title.Text = "HamzHub Loading"
Title.Size = UDim2.new(1,0,0,50)
Title.Position = UDim2.new(0,0,0.4,0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0,255,120)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

local Percent = Instance.new("TextLabel", BG)
Percent.Text = "0%"
Percent.Size = UDim2.new(1,0,0,30)
Percent.Position = UDim2.new(0,0,0.48,0)
Percent.BackgroundTransparency = 1
Percent.TextColor3 = Color3.fromRGB(180,255,180)
Percent.Font = Enum.Font.Gotham

local BarBG = Instance.new("Frame", BG)
BarBG.Size = UDim2.new(0,300,0,8)
BarBG.Position = UDim2.new(0.5,-150,0.55,0)
BarBG.BackgroundColor3 = Color3.fromRGB(20,40,20)
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1,0)

local Bar = Instance.new("Frame", BarBG)
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(0,255,120)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

for i = 1,100 do
    Percent.Text = i.."%"
    TweenService:Create(Bar, TweenInfo.new(0.02), {Size = UDim2.new(i/100,0,1,0)}):Play()
    task.wait(0.02)
end

-- FIX UTAMA: Pisah tween Frame & TextLabel
TweenService:Create(BG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()

for _,v in pairs(BG:GetDescendants()) do
    if v:IsA("TextLabel") then
        TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    elseif v:IsA("Frame") then
        TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
end

task.wait(0.6)
LoadingGui:Destroy()

-- ==================== MAIN GUI ====================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HamzHub"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,400,0,240)
Main.Position = UDim2.new(0.35,0,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(15,25,15)
Main.BackgroundTransparency = 0.1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(0,255,120)
stroke.Transparency = 0.4

-- TOP
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,30)
Top.BackgroundTransparency = 1

local Title2 = Instance.new("TextLabel", Top)
Title2.Text = "hamzHub Beta tester"
Title2.Size = UDim2.new(1,-40,1,0)
Title2.Position = UDim2.new(0,10,0,0)
Title2.BackgroundTransparency = 1
Title2.TextColor3 = Color3.fromRGB(0,255,120)
Title2.Font = Enum.Font.GothamBold
Title2.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0,30,1,0)
MinBtn.Position = UDim2.new(1,-30,0,0)
MinBtn.Text = ""
MinBtn.BackgroundTransparency = 1

-- LINE
local TopLine = Instance.new("Frame", Main)
TopLine.Size = UDim2.new(1,-20,0,1)
TopLine.Position = UDim2.new(0,10,0,30)
TopLine.BackgroundColor3 = Color3.fromRGB(0,255,120)
TopLine.BackgroundTransparency = 0.6

-- SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0,120,1,-31)
Sidebar.Position = UDim2.new(0,0,0,31)
Sidebar.BackgroundColor3 = Color3.fromRGB(20,30,20)
Sidebar.BackgroundTransparency = 0.2
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,10)

local SideLine = Instance.new("Frame", Main)
SideLine.Size = UDim2.new(0,1,1,-40)
SideLine.Position = UDim2.new(0,120,0,35)
SideLine.BackgroundColor3 = Color3.fromRGB(0,255,120)
SideLine.BackgroundTransparency = 0.6

local Accent = Instance.new("Frame", Sidebar)
Accent.Size = UDim2.new(0,3,0,30)
Accent.BackgroundColor3 = Color3.fromRGB(0,255,120)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-121,1,-31)
Content.Position = UDim2.new(0,121,0,31)
Content.BackgroundTransparency = 1

-- ==================== CREATE TAB (AUTO POSISI) ====================
local tabY = 10

local function createTab(name)
    local posY = tabY

    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1,0,0,30)
    Btn.Position = UDim2.new(0,0,0,posY)
    Btn.Text = name
    Btn.BackgroundTransparency = 1
    Btn.TextColor3 = Color3.fromRGB(180,255,180)
    Btn.Font = Enum.Font.Gotham

    local Frame = Instance.new("Frame", Content)
    Frame.Size = UDim2.new(1,0,1,0)
    Frame.Visible = false
    Frame.BackgroundTransparency = 1

    Btn.MouseButton1Click:Connect(function()
        for _,v in pairs(Content:GetChildren()) do
            v.Visible = false
        end
        Frame.Visible = true
        Accent:TweenPosition(UDim2.new(0,0,0,posY), "Out", "Quad", 0.2, true)
    end)

    tabY = tabY + 30
    return Frame
end

-- Buat tab default
local PlayerTab = createTab("Player")
local MainTab = createTab("Main")
PlayerTab.Visible = true

-- Accent mulai di tab pertama
Accent.Position = UDim2.new(0,0,0,10)

-- Contoh button (bisa lo hapus nanti)
local TestBtn = Instance.new("TextButton", MainTab)
TestBtn.Size = UDim2.new(0,180,0,35)
TestBtn.Position = UDim2.new(0,20,0,20)
TestBtn.Text = "Run"
TestBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)
TestBtn.TextColor3 = Color3.new(0,0,0)
Instance.new("UICorner", TestBtn)

TestBtn.MouseButton1Click:Connect(function()
    print("WORKING")
end)

-- ==================== MINI ICON & DRAG ====================
local MiniIcon = Instance.new("ImageButton", ScreenGui)
MiniIcon.Size = UDim2.new(0,45,0,45)
MiniIcon.Position = UDim2.new(0,20,0.5,0)
MiniIcon.Image = IMAGE_ID
MiniIcon.Visible = false
Instance.new("UICorner", MiniIcon).CornerRadius = UDim.new(1,0)

local function makeDraggable(gui, dragHandle)
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local startPos = gui.Position
            local startInputPos = input.Position

            local moveConn = UIS.InputChanged:Connect(function(moveInput)
                if moveInput.UserInputType == Enum.UserInputType.MouseMovement or moveInput.UserInputType == Enum.UserInputType.Touch then
                    local delta = moveInput.Position - startInputPos
                    gui.Position = UDim2.new(
                        startPos.X.Scale,
                        startPos.X.Offset + delta.X,
                        startPos.Y.Scale,
                        startPos.Y.Offset + delta.Y
                    )
                end
            end)

            local endConn
            endConn = UIS.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
                    moveConn:Disconnect()
                    endConn:Disconnect()
                end
            end)
        end
    end)
end

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniIcon.Visible = true
end)

MiniIcon.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniIcon.Visible = false
end)

makeDraggable(Main, Top)
makeDraggable(MiniIcon, MiniIcon)

-- ==================== RETURN LIBRARY ====================
HamzHub.PlayerTab = PlayerTab
HamzHub.MainTab = MainTab
HamzHub.CreateTab = createTab
HamzHub.ScreenGui = ScreenGui
HamzHub.MainFrame = Main

return HamzHub
