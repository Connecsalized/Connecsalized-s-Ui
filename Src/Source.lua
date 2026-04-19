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

function Library:Notification(nConfig)
    local Title = nConfig.Title or "Notification"
    local Content = nConfig.Content or "No content provided."
    local Duration = nConfig.Duration or 5
    
    local NotifyGui = CoreGui:FindFirstChild("ONG BRUH")
    if not NotifyGui then
        NotifyGui = Instance.new("ScreenGui")
        NotifyGui.Name = "ProjectBlue_Notifications"
        if gethui then NotifyGui.Parent = gethui() else NotifyGui.Parent = CoreGui end
    end

    local Holder = NotifyGui:FindFirstChild("Holder")
    if not Holder then
        Holder = Instance.new("Frame", NotifyGui)
        Holder.Name = "Holder"
        Holder.Size = UDim2.new(0, 240, 1, -20)
        Holder.Position = UDim2.new(1, -250, 0, 10)
        Holder.BackgroundTransparency = 1
        local Layout = Instance.new("UIListLayout", Holder)
        Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        Layout.Padding = UDim.new(0, 8)
    end

    local Main = Instance.new("Frame", Holder)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.Size = UDim2.new(1, 0, 0, 0)
    Main.ClipsDescendants = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", Main)
    Stroke.Color = Color3.fromRGB(0, 255, 255); Stroke.Thickness = 1; Stroke.Transparency = 0.6

    local T = Instance.new("TextLabel", Main)
    T.Text = Title; T.Size = UDim2.new(1, -20, 0, 25); T.Position = UDim2.new(0, 10, 0, 5)
    T.TextColor3 = Color3.fromRGB(0, 255, 255); T.Font = Enum.Font.GothamBold; T.TextSize = 13
    T.TextXAlignment = "Left"; T.BackgroundTransparency = 1

    local C = Instance.new("TextLabel", Main)
    C.Text = Content; C.Size = UDim2.new(1, -20, 0, 30); C.Position = UDim2.new(0, 10, 0, 25)
    C.TextColor3 = Color3.fromRGB(200, 200, 200); C.Font = Enum.Font.Gotham; C.TextSize = 11
    C.TextXAlignment = "Left"; C.TextWrapped = true; C.BackgroundTransparency = 1

    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 65)}):Play()

    task.delay(Duration, function()
        local out = TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 0)})
        out:Play()
        out.Completed:Connect(function() Main:Destroy() end)
    end)
end

function Library:CreateWindow(titleText, cfg)
    local config = cfg or {}
    local WindowSize = config.Size or UDim2.fromOffset(580, 460)
    local MinSize = Vector2.new(300, 200)
    
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
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.ClipsDescendants = true
    MainFrame.Position = UDim2.new(0.5, -WindowSize.X.Offset/2, 0.5, -WindowSize.Y.Offset/2) 
    MainFrame.Size = WindowSize
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    ContentHolder.Name = "Content"
    ContentHolder.Parent = MainFrame
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.Position = UDim2.new(0, 0, 0, 40)
    ContentHolder.Size = UDim2.new(1, 0, 1, -40)
    ContentHolder.GroupTransparency = 0

    local ResizeHandle = Instance.new("Frame", MainFrame)
    ResizeHandle.Name = "ResizeHandle"
    ResizeHandle.Size = UDim2.new(0, 30, 0, 30)
    ResizeHandle.Position = UDim2.new(1, -30, 1, -30)
    ResizeHandle.BackgroundTransparency = 1
    ResizeHandle.ZIndex = 10

    local ResizeIcon = Instance.new("TextLabel", ResizeHandle)
    ResizeIcon.Size = UDim2.new(1, 0, 1, 0)
    ResizeIcon.BackgroundTransparency = 1
    ResizeIcon.Text = "◢"
    ResizeIcon.TextColor3 = Color3.fromRGB(0, 255, 255)
    ResizeIcon.TextTransparency = 0.6; ResizeIcon.TextSize = 18
    ResizeIcon.TextXAlignment = Enum.TextXAlignment.Right; ResizeIcon.TextYAlignment = Enum.TextYAlignment.Bottom

    local TitleSquare = Instance.new("Frame", MainFrame)
    TitleSquare.BackgroundColor3 = Color3.fromRGB(0, 255, 255); TitleSquare.BackgroundTransparency = 0.88; TitleSquare.Position = UDim2.new(0, 15, 0, 12); TitleSquare.Size = UDim2.new(0, 16, 0, 16)
    Instance.new("UICorner", TitleSquare).CornerRadius = UDim.new(0, 4)

    Title.Parent = MainFrame; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 38, 0, 0); Title.Size = UDim2.new(1, -100, 0, 40)
    Title.Font = Enum.Font.GothamBold; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 14; Title.Text = titleText or "PROJECT BLUE"; Title.TextXAlignment = Enum.TextXAlignment.Left
    local TG = Instance.new("UIGradient", Title); TG.Rotation = 90; TG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.501, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))})

    local MinBtn = Instance.new("TextButton", MainFrame)
    MinBtn.Size = UDim2.new(0, 30, 0, 30); MinBtn.Position = UDim2.new(1, -35, 0, 5); MinBtn.BackgroundTransparency = 1; MinBtn.Text = "-"; MinBtn.TextColor3 = Color3.fromRGB(150, 150, 150); MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 18; MinBtn.ZIndex = 11
    
    local isMinimized = false
    MinBtn.Activated:Connect(function()
        isMinimized = not isMinimized
        local targetSize = isMinimized and UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 40) or WindowSize
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        TweenService:Create(ContentHolder, TweenInfo.new(0.2), {GroupTransparency = isMinimized and 1 or 0}):Play()
        ContentHolder.Visible = not isMinimized
        ResizeHandle.Visible = not isMinimized
        MinBtn.Text = isMinimized and "+" or "-"
    end)

    local dragging, resizing = false, false
    local dragStart, startPos, startSize

    MainFrame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local mousePos = input.Position
            local framePos = MainFrame.AbsolutePosition
            local frameSize = MainFrame.AbsoluteSize
            if mousePos.X >= (framePos.X + frameSize.X - 35) and mousePos.Y >= (framePos.Y + frameSize.Y - 35) then
                resizing = true
                dragStart = input.Position
                startSize = frameSize
            else
                dragging = true
                dragStart = input.Position
                startPos = framePos
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if (dragging or resizing) and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if dragging then
                MainFrame.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
            elseif resizing then
                local newX = math.max(MinSize.X, startSize.X + delta.X)
                local newY = math.max(MinSize.Y, startSize.Y + delta.Y)
                MainFrame.Size = UDim2.fromOffset(newX, newY)
                if not isMinimized then WindowSize = MainFrame.Size end
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging, resizing = false, false
        end
    end)

    local TabBar = Instance.new("Frame", ContentHolder); TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0); TabBar.BackgroundTransparency = 0.98; TabBar.Position = UDim2.new(0, 8, 0, 0); TabBar.Size = UDim2.new(0, 100, 1, -8)
    Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)
    Instance.new("UIListLayout", TabBar).Padding = UDim.new(0, 5)
    Instance.new("UIPadding", TabBar).PaddingTop = UDim.new(0, 5); TabBar.UIPadding.PaddingLeft = UDim.new(0, 5)

    local PageFolder = Instance.new("Frame", ContentHolder); PageFolder.BackgroundTransparency = 1; PageFolder.Position = UDim2.new(0, 115, 0, 0); PageFolder.Size = UDim2.new(1, -123, 1, -8)

    local Tabs = {FirstTab = nil}
    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabBar); TabBtn.Size = UDim2.new(1, -10, 0, 30); TabBtn.BackgroundTransparency = 1; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 11; TabBtn.ZIndex = 5
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
                local T = Instance.new("TextLabel", C); T.Name = "Title"; T.BackgroundTransparency = 1; T.Size = UDim2.new(1, 0, 0, 12); T.Font = Enum.Font.GothamBold; T.TextColor3 = Color3.fromRGB(240, 240, 240); T.TextSize = 10; T.Text = name; T.TextXAlignment = Enum.TextXAlignment.Left
                local D = Instance.new("TextLabel", C); D.Name = "Desc"; D.BackgroundTransparency = 1; D.Size = UDim2.new(1, 0, 0, 0); D.AutomaticSize = Enum.AutomaticSize.Y; D.Font = Enum.Font.Gotham; D.TextColor3 = Color3.fromRGB(140, 140, 140); D.TextSize = 8; D.Text = desc or ""; D.TextXAlignment = Enum.TextXAlignment.Left; D.TextWrapped = true
                Instance.new("UIPadding", F).PaddingBottom = UDim.new(0, 6)
                return F, C
            end

            function Elements:CreateButton(bConfig)
                local BFrame, Container = CreateElementBase(SContent, bConfig.Name, bConfig.Description)
                local B = Instance.new("TextButton", BFrame); B.Size = UDim2.new(1,0,1,0); B.BackgroundTransparency = 1; B.Text = ""; B.ZIndex = 5
                local Stroke = Instance.new("UIStroke", BFrame); Stroke.Color = Color3.fromRGB(0, 255, 255); Stroke.Thickness = 1; Stroke.Transparency = 0.8
                B.Activated:Connect(function() bConfig.Callback() end)
            end

            function Elements:CreateToggle(tConfig)
                local current = tConfig.Default or false
                local TFrame, Container = CreateElementBase(SContent, tConfig.Name, tConfig.Description)
                local TS = Instance.new("UIStroke", TFrame); TS.Color = Color3.fromRGB(0, 255, 255); TS.Thickness = 1; TS.Transparency = current and 0.5 or 1
                local TBox = Instance.new("Frame", TFrame); TBox.Size = UDim2.new(0, 22, 0, 11); TBox.Position = UDim2.new(1, -30, 0, 10); TBox.BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50); Instance.new("UICorner", TBox).CornerRadius = UDim.new(1, 0)
                local TCircle = Instance.new("Frame", TBox); TCircle.Size = UDim2.new(0, 9, 0, 9); TCircle.Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4); TCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", TCircle).CornerRadius = UDim.new(1, 0)
                local B = Instance.new("TextButton", TFrame); B.Size = UDim2.new(1,0,1,0); B.BackgroundTransparency = 1; B.Text = ""; B.ZIndex = 5
                B.Activated:Connect(function() current = not current; TweenService:Create(TBox, TweenInfo.new(0.15), {BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50)}):Play(); TweenService:Create(TCircle, TweenInfo.new(0.15), {Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4)}):Play(); TS.Transparency = current and 0.5 or 1; tConfig.Callback(current) end)
                if current then task.spawn(function() tConfig.Callback(current) end) end
            end

            function Elements:CreateSlider(sConfig)
                local SFrame, Container = CreateElementBase(SContent, sConfig.Name, sConfig.Description)
                local SVal = Instance.new("TextLabel", SFrame); SVal.BackgroundTransparency = 1; SVal.Position = UDim2.new(1, -40, 0, 10); SVal.Size = UDim2.new(0, 32, 0, 12); SVal.Font = Enum.Font.GothamBold; SVal.TextColor3 = Color3.fromRGB(0, 255, 255); SVal.TextSize = 9; SVal.Text = tostring(sConfig.Default or sConfig.Min); SVal.TextXAlignment = Enum.TextXAlignment.Right
                local SBack = Instance.new("Frame", Container); SBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45); SBack.Size = UDim2.new(1, 0, 0, 4); Instance.new("UICorner", SBack)
                local SFill = Instance.new("Frame", SBack); SFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255); SFill.Size = UDim2.new(0, 0, 1, 0); Instance.new("UICorner", SFill)
                local function Update(input) local perc = math.clamp((input.Position.X - SBack.AbsolutePosition.X) / SBack.AbsoluteSize.X, 0, 1); local val = math.floor(sConfig.Min + (sConfig.Max - sConfig.Min) * perc); SFill.Size = UDim2.new(perc, 0, 1, 0); SVal.Text = tostring(val); sConfig.Callback(val) end
                local sliding = false
                SFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sliding = true; Update(i) end end)
                UserInputService.InputChanged:Connect(function(i) if sliding and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then sliding = false end end)
                local startPerc = math.clamp(((sConfig.Default or sConfig.Min) - sConfig.Min) / (sConfig.Max - sConfig.Min), 0, 1)
                SFill.Size = UDim2.new(startPerc, 0, 1, 0)
            end

            function Elements:CreateDropdown(dConfig)
                local current = dConfig.Default or "Select..."
                local DFrame, Container = CreateElementBase(SContent, dConfig.Name, dConfig.Description)
                DFrame.ClipsDescendants = true
                local Display = Instance.new("TextLabel", Container); Display.BackgroundTransparency = 1; Display.Size = UDim2.new(1, 0, 0, 18); Display.Font = Enum.Font.GothamBold; Display.TextColor3 = Color3.fromRGB(0, 255, 255); Display.TextSize = 9; Display.Text = "Selected: "..current; Display.TextXAlignment = Enum.TextXAlignment.Left
                local open = false
                local DB = Instance.new("TextButton", DFrame); DB.Size = UDim2.new(1,0,0,35); DB.BackgroundTransparency = 1; DB.Text = ""; DB.ZIndex = 5
                local OptionHolder = Instance.new("Frame", Container); OptionHolder.BackgroundTransparency = 1; OptionHolder.Size = UDim2.new(1, 0, 0, 0); OptionHolder.Visible = false; OptionHolder.AutomaticSize = Enum.AutomaticSize.Y
                Instance.new("UIListLayout", OptionHolder).Padding = UDim.new(0, 4)
                DB.Activated:Connect(function() open = not open; OptionHolder.Visible = open end)
                local function Refresh()
                    for _, opt in pairs(OptionHolder:GetChildren()) do
                        if opt:IsA("TextButton") then
                            local isSel = (opt.Text == current)
                            opt.TextColor3 = isSel and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(180, 180, 180)
                            opt.BackgroundColor3 = isSel and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(35, 35, 35)
                        end
                    end
                end
                for _, opt in pairs(dConfig.Options) do
                    local OB = Instance.new("TextButton", OptionHolder); OB.BackgroundColor3 = Color3.fromRGB(35, 35, 35); OB.Size = UDim2.new(1, 0, 0, 20); OB.Font = Enum.Font.Gotham; OB.TextSize = 9; OB.Text = opt; Instance.new("UICorner", OB); OB.ZIndex = 6
                    OB.Activated:Connect(function()
                        current = opt; Display.Text = "Selected: "..opt; open = false; OptionHolder.Visible = false; Refresh(); dConfig.Callback(opt)
                    end)
                end
                Refresh()
                if dConfig.Default then task.spawn(function() dConfig.Callback(current) end) end
            end

            return Elements
        end
        if Tabs.FirstTab == nil then Tabs.FirstTab = Page; task.delay(0.1, function() Page.Visible = true; TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255); TabDesign.BackgroundTransparency = 0.88; TO.Transparency = 0.5 end) end
        return Sections
    end
    return Tabs
end

return Library
