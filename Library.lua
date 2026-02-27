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

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local handle = dragHandle or frame
    handle = typeof(handle) == "table" and handle[1] or handle

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Input.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
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

    -- Создание контейнера для табов под TitleFrame
    local TabsContainer = CreateObj("Frame", {
        Parent = WindowFrame,
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = Library.Theme.BackgroundOutline1,
        BorderSizePixel = 0,
        ZIndex = 2
    })

    -- Внутренняя рамка для контейнера табов
    local TabsInner = CreateObj("Frame", {
        Parent = TabsContainer,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.BackgroundOutline2,
        BorderSizePixel = 0
    })

    -- Внутренняя часть контейнера
    local TabsInner2 = CreateObj("Frame", {
        Parent = TabsInner,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.Background,
        BorderSizePixel = 0
    })

    -- Контейнер для кнопок табов (будет заполняться слева направо)
    local TabsButtonsContainer = CreateObj("Frame", {
        Parent = TabsInner2,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    })

    -- UIListLayout для автоматического расположения табов
    local TabsLayout = CreateObj("UIListLayout", {
        Parent = TabsButtonsContainer,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    })

    -- Контейнер для содержимого табов
    local TabContentContainer = CreateObj("Frame", {
        Parent = WindowFrame,
        Size = UDim2.new(1, -2, 1, -74), -- 40 (Title) + 30 (Tabs) + 2 (padding) = 72
        Position = UDim2.new(0, 1, 0, 71),
        BackgroundColor3 = Library.Theme.BackgroundOutline2,
        BorderSizePixel = 0,
        Visible = true,
        ZIndex = 1
    })

    local TabContentInner = CreateObj("Frame", {
        Parent = TabContentContainer,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.BackgroundOutline1,
        BorderSizePixel = 0
    })

    local TabContentInner2 = CreateObj("Frame", {
        Parent = TabContentInner,
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Library.Theme.Background,
        BorderSizePixel = 0
    })

    MakeDraggable(WindowFrame, TitleFrame)

    -- Система управления табами
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.TabContent = TabContentInner2
    Window.TabsContainer = TabsButtonsContainer

    function Window:CreateTab(name)
        if not name then return end
        
        -- Создание кнопки таба
        local TabButton = CreateObj("TextButton", {
            Parent = TabsButtonsContainer,
            Size = UDim2.new(0, 80, 1, -4),
            Position = UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = Library.Theme.BackgroundOutline1,
            Text = name,
            TextColor3 = Color3.new(1, 1, 1),
            TextScaled = false,
            TextSize = 13,
            Font = Enum.Font.Code,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            LayoutOrder = #Window.Tabs
        })

        -- Внутренняя рамка кнопки
        local TabButtonInner = CreateObj("Frame", {
            Parent = TabButton,
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
            BackgroundColor3 = Library.Theme.BackgroundOutline2,
            BorderSizePixel = 0
        })

        local TabButtonInner2 = CreateObj("Frame", {
            Parent = TabButtonInner,
            Size = UDim2.new(1, -2, 1, -2),
            Position = UDim2.new(0, 1, 0, 1),
            BackgroundColor3 = Library.Theme.Background,
            BorderSizePixel = 0
        })

        -- Контейнер для содержимого таба
        local TabContainer = CreateObj("Frame", {
            Parent = TabContentInner2,
            Size = UDim2.new(1, -10, 1, -10),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundTransparency = 1,
            Visible = false
        })

        local Tab = {}
        Tab.Button = TabButton
        Tab.Container = TabContainer
        Tab.Name = name

        -- Функция выбора таба
        function Tab:Select()
            if Window.CurrentTab then
                Window.CurrentTab.Container.Visible = false
            end
            
            TabContainer.Visible = true
            Window.CurrentTab = Tab
            
            -- Визуальное выделение выбранного таба
            for _, t in pairs(Window.Tabs) do
                t.Button.BackgroundColor3 = Library.Theme.BackgroundOutline1
                t.Button.TextColor3 = Color3.new(1, 1, 1)
            end
            TabButton.BackgroundColor3 = Library.Theme.BackgroundOutline2
            TabButton.TextColor3 = Color3.new(1, 1, 0)
        end

        -- Обработчик нажатия
        TabButton.MouseButton1Click:Connect(function()
            Tab:Select()
        end)

        table.insert(Window.Tabs, Tab)

        -- Если это первый таб, выбираем его автоматически
        if #Window.Tabs == 1 then
            Tab:Select()
        end

        return Tab
    end

    MakeDraggable(WindowFrame, TitleFrame)

    return Window
end

return Library
