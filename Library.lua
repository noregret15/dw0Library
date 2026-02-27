local Input = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {
    Theme = {
        BackgroundOutline1 = Color3.fromRGB(15, 15, 15),
        BackgroundOutline2 = Color3.fromRGB(50, 50, 180),
        Background = Color3.fromRGB(30, 30, 30)
    }
}

getfenv().Objects = {}
getfenv().Options = {}

local ScreenGui__ = Instance.new("ScreenGui")
ScreenGui__.Parent = CoreGui
ScreenGui__.IgnoreGuiInset = true
ScreenGui__.ResetOnSpawn = false
ScreenGui__.DisplayOrder = 10000

local function CreateObj(Class, Parametrs)
    if not Class or not Parametrs then return end
    local Obj = Instance.new(Class)
    table.insert(getfenv().Objects, Obj)
    for p,v in pairs(Parametrs) do Obj[p]=v end
    return Obj
end

function Library:CreateWindow(Parametrs)
    if not Parametrs then return end
    if typeof(Parametrs["Name"]) ~= "string" then return end

    local WindowFrame = CreateObj("Frame",{
        Parent = ScreenGui__,
        Size = UDim2.new(0, 500, 0, 550),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Library.Theme.Background,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Visible = true
    })

    local TitleFrame = CreateObj("Frame", {
        Parent = WindowFrame,
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })

    local TitleOutline = CreateObj("Frame", {
        Parent = TitleFrame,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.BackgroundOutline2,
        BorderSizePixel = 0
    })

    local TitleInner = CreateObj("Frame", {
        Parent = TitleOutline,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.BackgroundOutline1,
        BorderSizePixel = 0
    })

    local TitleLabel = CreateObj("TextLabel", {
        Parent = TitleInner,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = Parametrs.Name,
        TextColor3 = Color3.new(1, 1, 1),
        TextScaled = false,
        TextSize = 14,
        Font = Enum.Font.Code,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local WindowOutline = CreateObj("Frame", {
        Parent = WindowFrame,
        Size = UDim2.new(1, -2, 1, -42),
        Position = UDim2.new(0, 1, 0, 41),
        BackgroundColor3 = Library.Theme.BackgroundOutline2,
        BorderSizePixel = 0
    })

    local WindowInner = CreateObj("Frame", {
        Parent = WindowOutline,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.BackgroundOutline1,
        BorderSizePixel = 0
    })
end

return Library
