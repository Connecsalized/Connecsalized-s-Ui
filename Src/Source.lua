local function GetService(name)
    local service = game:GetService(name)
    if cloneref then return cloneref(service) end
    return service
end

local UserInputService = GetService("UserInputService")
local TweenService = GetService("TweenService")
local CoreGui = GetService("CoreGui")
local Players = GetService("Players")

local Library = {}

function Library:CreateWindow(titleText, cfg)
    local config = cfg or {}
    local WindowSize = config.Size or UDim2.fromOffset(400, 300)
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local ContentHolder = Instance.new("CanvasGroup") 
    local Title = Instance.new("TextLabel")
    
    ScreenGui.Name = "Connecsalized"
    if gethui then ScreenGui.Parent = gethui()
    elseif CoreGui then ScreenGui.Parent = CoreGui
    else ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end
    
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) 
    MainFrame.Size = WindowSize
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    ContentHolder.Name = "Content"
    ContentHolder.Parent = MainFrame
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.Position = UDim2.new(0, 0, 0, 40)
    ContentHolder.Size = UDim2.new(1, 0, 1, -40)

    local TitleSquare = Instance.new("Frame", MainFrame)
    TitleSquare.BackgroundColor3 = Color3.fromRGB(0, 255, 255); TitleSquare.BackgroundTransparency = 0.88; TitleSquare.Position = UDim2.new(0, 15, 0, 12); TitleSquare.Size = UDim2.new(0, 16, 0, 16)
    Instance.new("UICorner", TitleSquare).CornerRadius = UDim.new(0, 4)
    local TSOutline = Instance.new("UIStroke", TitleSquare); TSOutline.Color = Color3.fromRGB(0, 255, 255); TSOutline.Thickness = 1; TSOutline.Transparency = 0.5

    Title.Parent = MainFrame; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 38, 0, 0); Title.Size = UDim2.new(1, -100, 0, 40)
    Title.Font = Enum.Font.GothamBold; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 14; Title.Text = titleText or "PROJECT BLUE"; Title.TextXAlignment = Enum.TextXAlignment.Left
    local TG = Instance.new("UIGradient", Title); TG.Rotation = 90; TG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.501, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))})

    local MinBtn = Instance.new("TextButton", MainFrame)
    MinBtn.Size = UDim2.new(0, 30, 0, 30); MinBtn.Position = UDim2.new(1, -35, 0, 5); MinBtn.BackgroundTransparency = 1; MinBtn.Text = "-"; MinBtn.TextColor3 = Color3.fromRGB(150, 150, 150); MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 18
    
    local isMinimized = false
    MinBtn.Activated:Connect(function()
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(WindowSize.X.Scale, WindowSize.X.Offset, 0, 40) or WindowSize
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        TweenService:Create(ContentHolder, TweenInfo.new(0.2), {GroupTransparency = isMinimized and 1 or 0}):Play()
        MinBtn.Text = isMinimized and "+" or "-"
    end)

    local TabBar = Instance.new("Frame", ContentHolder); TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0); TabBar.BackgroundTransparency = 0.98; TabBar.Position = UDim2.new(0, 8, 0, 0); TabBar.Size = UDim2.new(0, 100, 1, -8)
    Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)
    Instance.new("UIListLayout", TabBar).Padding = UDim.new(0, 5)
    Instance.new("UIPadding", TabBar).PaddingTop = UDim.new(0, 5); TabBar.UIPadding.PaddingLeft = UDim.new(0, 5)

    local PageFolder = Instance.new("Frame", ContentHolder); PageFolder.BackgroundTransparency = 1; PageFolder.Position = UDim2.new(0, 115, 0, 0); PageFolder.Size = UDim2.new(1, -123, 1, -8)

    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input) 
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and input.Position.Y - MainFrame.AbsolutePosition.Y < 40 then 
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position 
        end 
    end)
    UserInputService.InputChanged:Connect(function(input) 
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then 
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

    local Tabs = {FirstTab = nil}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabBar)
        TabBtn.Size = UDim2.new(1, -10, 0, 30); TabBtn.BackgroundTransparency = 1; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 11
        local TabDesign = Instance.new("Frame", TabBtn); TabDesign.Size = UDim2.new(1, 0, 1, 0); TabDesign.BackgroundColor3 = Color3.fromRGB(0, 255, 255); TabDesign.BackgroundTransparency = 1; Instance.new("UICorner", TabDesign).CornerRadius = UDim.new(0, 4)
        local TO = Instance.new("UIStroke", TabDesign); TO.Color = Color3.fromRGB(0, 255, 255); TO.Thickness = 1; TO.Transparency = 1

        local Page = Instance.new("Frame", PageFolder); Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false
        local LeftSec = Instance.new("ScrollingFrame", Page); LeftSec.Size = UDim2.new(0.5, -5, 1, 0); LeftSec.BackgroundTransparency = 1; LeftSec.ScrollBarThickness = 0; LeftSec.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local RightSec = Instance.new("ScrollingFrame", Page); RightSec.Size = UDim2.new(0.5, -5, 1, 0); RightSec.Position = UDim2.new(0.5, 5, 0, 0); RightSec.BackgroundTransparency = 1; RightSec.ScrollBarThickness = 0; RightSec.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Instance.new("UIListLayout", LeftSec).Padding = UDim.new(0, 10); Instance.new("UIListLayout", RightSec).Padding = UDim.new(0, 10)

        TabBtn.Activated:Connect(function()
            for _, v in pairs(PageFolder:GetChildren()) do v.Visible = false end
            Page.Visible = true
            for _, v in pairs(TabBar:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(140, 140, 140); v.Frame.BackgroundTransparency = 1; v.Frame.UIStroke.Transparency = 1 end end
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255); TabDesign.BackgroundTransparency = 0.88; TO.Transparency = 0.5
        end)

        local Sections = {}
        function Sections:CreateSection(secConfig)
            local side = (secConfig.Side == "Right" and RightSec or LeftSec)
            local SMain = Instance.new("Frame", side); SMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20); SMain.Size = UDim2.new(1, 0, 0, 0); SMain.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", SMain).CornerRadius = UDim.new(0, 5)
            local SContent = Instance.new("Frame", SMain); SContent.Position = UDim2.new(0, 5, 0, 5); SContent.Size = UDim2.new(1, -10, 0, 0); SContent.BackgroundTransparency = 1; SContent.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UIListLayout", SContent).Padding = UDim.new(0, 6); Instance.new("UIPadding", SContent).PaddingBottom = UDim.new(0, 5)

            local Elements = {}
            local function CreateElementBase(parent, name, desc)
                local F = Instance.new("Frame", parent); F.BackgroundColor3 = Color3.fromRGB(28, 28, 28); F.Size = UDim2.new(1, 0, 0, 0); F.AutomaticSize = Enum.AutomaticSize.Y
                Instance.new("UICorner", F).CornerRadius = UDim.new(0, 4)
                local C = Instance.new("Frame", F); C.BackgroundTransparency = 1; C.Size = UDim2.new(1, -10, 0, 0); C.Position = UDim2.new(0, 8, 0, 6); C.AutomaticSize = Enum.AutomaticSize.Y
                Instance.new("UIListLayout", C).Padding = UDim.new(0, 2)
                Instance.new("TextLabel", C).Name = "Title"; C.Title.BackgroundTransparency = 1; C.Title.Size = UDim2.new(1, 0, 0, 12); C.Title.Font = Enum.Font.GothamBold; C.Title.TextColor3 = Color3.fromRGB(240, 240, 240); C.Title.TextSize = 10; C.Title.Text = name; C.Title.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("TextLabel", C).Name = "Desc"; C.Desc.BackgroundTransparency = 1; C.Desc.Size = UDim2.new(1, 0, 0, 0); C.Desc.AutomaticSize = Enum.AutomaticSize.Y; C.Desc.Font = Enum.Font.Gotham; C.Desc.TextColor3 = Color3.fromRGB(140, 140, 140); C.Desc.TextSize = 8; C.Desc.Text = desc or ""; C.Desc.TextXAlignment = Enum.TextXAlignment.Left; C.Desc.TextWrapped = true
                Instance.new("UIPadding", F).PaddingBottom = UDim.new(0, 6)
                return F, C
            end

            function Elements:CreateToggle(tConfig)
                local current = tConfig.Default or false
                local TFrame, Container = CreateElementBase(SContent, tConfig.Name, tConfig.Description)
                local TS = Instance.new("UIStroke", TFrame); TS.Color = Color3.fromRGB(0, 255, 255); TS.Thickness = 1; TS.Transparency = current and 0.5 or 1
                local TBox = Instance.new("Frame", TFrame); TBox.Size = UDim2.new(0, 22, 0, 11); TBox.Position = UDim2.new(1, -30, 0, 10); TBox.BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50); Instance.new("UICorner", TBox).CornerRadius = UDim.new(1, 0)
                local TCircle = Instance.new("Frame", TBox); TCircle.Size = UDim2.new(0, 9, 0, 9); TCircle.Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4); TCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", TCircle).CornerRadius = UDim.new(1, 0)
                local B = Instance.new("TextButton", TFrame); B.Size = UDim2.new(1,0,1,0); B.BackgroundTransparency = 1; B.Text = ""
                B.Activated:Connect(function() current = not current; TweenService:Create(TBox, TweenInfo.new(0.15), {BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50)}):Play(); TweenService:Create(TCircle, TweenInfo.new(0.15), {Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4)}):Play(); TS.Transparency = current and 0.5 or 1; tConfig.Callback(current) end)
                if current then task.spawn(function() tConfig.Callback(current) end) end
            end
            return Elements
        end
        if Tabs.FirstTab == nil then Tabs.FirstTab = Page; task.delay(0.1, function() Page.Visible = true; TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255); TabDesign.BackgroundTransparency = 0.88; TO.Transparency = 0.5 end) end
        return Sections
    end
    return Tabs
end
return Library
