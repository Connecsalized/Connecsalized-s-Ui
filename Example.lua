local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Connecsalized/Connecsalized-s-Ui/refs/heads/main/Src/Source.lua"))()

local Win = Library:CreateWindow("Connecsalized's Ui Library")
local Tab = Win:CreateTab("Main")
local Section1 = Tab:CreateSection({Name = "Section Left", Side = "Left"})
local Section2= Tab:CreateSection({Name = "Section Right", Side = "Right"})

Section1:CreateToggle({
    Name = "Toggle", 
    Description = "Toggle.", 
    Default = true, 
    Callback = function(v) 
    print(v)
    end
})

Section2:CreateSlider({
    Name = "Slide", 
    Description = "Slider.", 
    Min = 5, Max = 50, Default = 15, 
    Callback = function(v) 
    print(v)
    end
})

Section1:CreateDropdown({
    Name = "DropDown", 
    Description = "DropDown.", 
    Options = {"Table 1", "Table 2", "Table 3", "Table 4"}, 
    Default = "Table 1", 
    Callback = function(v) 
    print(v)
    end
})

Section2:CreateButton({
    Name = "Button", 
    Description = "Button.", 
    Callback = function()
    print(v)
    end
})
