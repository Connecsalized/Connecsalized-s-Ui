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

function Library:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabBar = Instance.new("Frame")
    local PageFolder = Instance.new("Frame")
    
    ScreenGui.Name = "Connecsalized"
    if gethui then ScreenGui.Parent = gethui()
    elseif CoreGui then ScreenGui.Parent = CoreGui
    else ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end
    
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local TitleSquare = Instance.new("Frame", MainFrame)
    TitleSquare.BackgroundColor3 = Color3.fromRGB(0, 255, 255); TitleSquare.BackgroundTransparency = 0.88; TitleSquare.Position = UDim2.new(0, 15, 0, 12); TitleSquare.Size = UDim2.new(0, 16, 0, 16)
    Instance.new("UICorner", TitleSquare).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", TitleSquare).Color = Color3.fromRGB(0, 255, 255); TitleSquare.UIStroke.Thickness = 1; TitleSquare.UIStroke.Transparency = 0.5

    Title.Parent = MainFrame; Title.BackgroundTransparency = 1; Title.Position = UDim2.new(0, 38, 0, 0); Title.Size = UDim2.new(1, -50, 0, 40)
    Title.Font = Enum.Font.GothamBold; Title.TextColor3 = Color3.fromRGB(255, 255, 255); Title.TextSize = 14; Title.Text = titleText or "PROJECT BLUE"; Title.TextXAlignment = Enum.TextXAlignment.Left
    local TG = Instance.new("UIGradient", Title); TG.Rotation = 90; TG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.501, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))})

    TabBar.Parent = MainFrame; TabBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0); TabBar.BackgroundTransparency = 0.98; TabBar.Position = UDim2.new(0, 8, 0, 40); TabBar.Size = UDim2.new(0, 85, 1, -48)
    Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)
    Instance.new("UIListLayout", TabBar).Padding = UDim.new(0, 5)

    PageFolder.Parent = MainFrame; PageFolder.BackgroundTransparency = 1; PageFolder.Position = UDim2.new(0, 100, 0, 40); PageFolder.Size = UDim2.new(1, -108, 1, -48)

    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then dragging = true; dragStart = input.Position; startPos = MainFrame.Position end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStart; MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)

    local Tabs = {FirstTab = nil}

    function Tabs:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabBar)
        local Page = Instance.new("Frame", PageFolder)
        local LeftSec = Instance.new("ScrollingFrame")
        local RightSec = Instance.new("ScrollingFrame")
        
        local TabDesign = Instance.new("Frame", TabBtn); TabDesign.Size = UDim2.new(1, 0, 1, 0); TabDesign.BackgroundColor3 = Color3.fromRGB(0, 255, 255); TabDesign.BackgroundTransparency = 1; Instance.new("UICorner", TabDesign).CornerRadius = UDim.new(0, 4)
        local TO = Instance.new("UIStroke", TabDesign); TO.Color = Color3.fromRGB(0, 255, 255); TO.Thickness = 1; TO.Transparency = 1

        TabBtn.Size = UDim2.new(1, -8, 0, 30); TabBtn.BackgroundTransparency = 1; TabBtn.Text = name; TabBtn.TextColor3 = Color3.fromRGB(140, 140, 140); TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 11

        Page.Size = UDim2.new(1, 0, 1, 0); Page.BackgroundTransparency = 1; Page.Visible = false

        local function CreateSectionHolder(sec, pos)
            sec.Parent = Page; sec.Size = UDim2.new(0.5, -4, 1, 0); sec.Position = pos; sec.BackgroundTransparency = 1; sec.ScrollBarThickness = 0; sec.AutomaticCanvasSize = Enum.AutomaticSize.Y
            Instance.new("UIListLayout", sec).Padding = UDim.new(0, 10)
        end
        CreateSectionHolder(LeftSec, UDim2.new(0, 0, 0, 0)); CreateSectionHolder(RightSec, UDim2.new(0.5, 4, 0, 0))

        TabBtn.Activated:Connect(function()
            for _, v in pairs(PageFolder:GetChildren()) do v.Visible = false end
            Page.Visible = true
            for _, v in pairs(TabBar:GetChildren()) do if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(140, 140, 140); v.Frame.BackgroundTransparency = 1; v.Frame.UIStroke.Transparency = 1 end end
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255); TabDesign.BackgroundTransparency = 0.88; TO.Transparency = 0.5
        end)

        local Sections = {}
        function Sections:CreateSection(secConfig)
            local side = (secConfig.Side == "Right" and RightSec or LeftSec)
            local SMain = Instance.new("Frame", side)
            SMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20); SMain.Size = UDim2.new(1, 0, 0, 0); SMain.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", SMain).CornerRadius = UDim.new(0, 5)
            
            local SContent = Instance.new("Frame", SMain); SContent.Position = UDim2.new(0, 5, 0, 5); SContent.Size = UDim2.new(1, -10, 0, 0); SContent.BackgroundTransparency = 1; SContent.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UIListLayout", SContent).Padding = UDim.new(0, 6)
            Instance.new("UIPadding", SContent).PaddingBottom = UDim.new(0, 5)

            local Elements = {}

            local function CreateElementBase(parent, name, desc)
                local F = Instance.new("Frame", parent)
                F.BackgroundColor3 = Color3.fromRGB(28, 28, 28); F.Size = UDim2.new(1, 0, 0, 0); F.AutomaticSize = Enum.AutomaticSize.Y
                Instance.new("UICorner", F).CornerRadius = UDim.new(0, 4)
                
                local C = Instance.new("Frame", F); C.BackgroundTransparency = 1; C.Size = UDim2.new(1, -10, 0, 0); C.Position = UDim2.new(0, 8, 0, 6); C.AutomaticSize = Enum.AutomaticSize.Y
                Instance.new("UIListLayout", C).Padding = UDim.new(0, 2)
                
                local T = Instance.new("TextLabel", C); T.BackgroundTransparency = 1; T.Size = UDim2.new(1, 0, 0, 12); T.Font = Enum.Font.GothamBold; T.TextColor3 = Color3.fromRGB(240, 240, 240); T.TextSize = 10; T.Text = name; T.TextXAlignment = Enum.TextXAlignment.Left
                local D = Instance.new("TextLabel", C); D.BackgroundTransparency = 1; D.Size = UDim2.new(1, 0, 0, 0); D.AutomaticSize = Enum.AutomaticSize.Y; D.Font = Enum.Font.Gotham; D.TextColor3 = Color3.fromRGB(140, 140, 140); D.TextSize = 8; D.Text = desc or "No description provided."; D.TextXAlignment = Enum.TextXAlignment.Left; D.TextWrapped = true
                
                Instance.new("UIPadding", F).PaddingBottom = UDim.new(0, 6)
                return F, C
            end

            function Elements:CreateButton(bConfig)
                local BFrame, Container = CreateElementBase(SContent, bConfig.Name, bConfig.Description)
                local B = Instance.new("TextButton", BFrame); B.Size = UDim2.new(1,0,1,0); B.BackgroundTransparency = 1; B.Text = ""
                local Stroke = Instance.new("UIStroke", BFrame); Stroke.Color = Color3.fromRGB(0, 255, 255); Stroke.Thickness = 1; Stroke.Transparency = 0.8
                B.Activated:Connect(function() bConfig.Callback() end)
            end

            function Elements:CreateToggle(tConfig)
                local current = tConfig.Default or false
                local TFrame, Container = CreateElementBase(SContent, tConfig.Name, tConfig.Description)
                local TS = Instance.new("UIStroke", TFrame); TS.Color = Color3.fromRGB(0, 255, 255); TS.Thickness = 1; TS.Transparency = current and 0.5 or 1
                
                local TBox = Instance.new("Frame", TFrame); TBox.Size = UDim2.new(0, 22, 0, 11); TBox.Position = UDim2.new(1, -30, 0, 10); TBox.BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50); Instance.new("UICorner", TBox).CornerRadius = UDim.new(1, 0)
                local TCircle = Instance.new("Frame", TBox); TCircle.Size = UDim2.new(0, 9, 0, 9); TCircle.Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4); TCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", TCircle).CornerRadius = UDim.new(1, 0)
                
                local B = Instance.new("TextButton", TFrame); B.Size = UDim2.new(1,0,1,0); B.BackgroundTransparency = 1; B.Text = ""
                B.Activated:Connect(function()
                    current = not current
                    TweenService:Create(TBox, TweenInfo.new(0.15), {BackgroundColor3 = current and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(50, 50, 50)}):Play()
                    TweenService:Create(TCircle, TweenInfo.new(0.15), {Position = current and UDim2.new(1, -11, 0.5, -4) or UDim2.new(0, 2, 0.5, -4)}):Play()
                    TS.Transparency = current and 0.5 or 1; tConfig.Callback(current)
                end)
                if current then task.spawn(function() tConfig.Callback(current) end) end
            end

            function Elements:CreateSlider(sConfig)
                local SFrame, Container = CreateElementBase(SContent, sConfig.Name, sConfig.Description)
                local SVal = Instance.new("TextLabel", SFrame); SVal.BackgroundTransparency = 1; SVal.Position = UDim2.new(1, -40, 0, 10); SVal.Size = UDim2.new(0, 32, 0, 12); SVal.Font = Enum.Font.GothamBold; SVal.TextColor3 = Color3.fromRGB(0, 255, 255); SVal.TextSize = 9; SVal.Text = tostring(sConfig.Default or sConfig.Min); SVal.TextXAlignment = Enum.TextXAlignment.Right
                
                local SBack = Instance.new("Frame", Container); SBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45); SBack.Size = UDim2.new(1, 0, 0, 4); Instance.new("UICorner", SBack)
                local SFill = Instance.new("Frame", SBack); SFill.BackgroundColor3 = Color3.fromRGB(0, 255, 255); SFill.Size = UDim2.new(0, 0, 1, 0); Instance.new("UICorner", SFill)
                
                local function Update(input)
                    local perc = math.clamp((input.Position.X - SBack.AbsolutePosition.X) / SBack.AbsoluteSize.X, 0, 1)
                    local val = math.floor(sConfig.Min + (sConfig.Max - sConfig.Min) * perc)
                    SFill.Size = UDim2.new(perc, 0, 1, 0); SVal.Text = tostring(val); sConfig.Callback(val)
                end
                local dragging = false
                SFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true; Update(i) end end)
                UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
                UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
            end

            function Elements:CreateDropdown(dConfig)
                local current = dConfig.Default or "Select..."
                local DFrame, Container = CreateElementBase(SContent, dConfig.Name, dConfig.Description)
                DFrame.ClipsDescendants = true
                
                local Display = Instance.new("TextLabel", Container); Display.BackgroundTransparency = 1; Display.Size = UDim2.new(1, 0, 0, 18); Display.Font = Enum.Font.GothamBold; Display.TextColor3 = Color3.fromRGB(0, 255, 255); Display.TextSize = 9; Display.Text = "Selected: "..current; Display.TextXAlignment = Enum.TextXAlignment.Left

                local open = false
                local DB = Instance.new("TextButton", DFrame); DB.Size = UDim2.new(1,0,0,35); DB.BackgroundTransparency = 1; DB.Text = ""
                
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
                    local OB = Instance.new("TextButton", OptionHolder); OB.BackgroundColor3 = Color3.fromRGB(35, 35, 35); OB.Size = UDim2.new(1, 0, 0, 20); OB.Font = Enum.Font.Gotham; OB.TextSize = 9; OB.Text = opt; Instance.new("UICorner", OB)
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
