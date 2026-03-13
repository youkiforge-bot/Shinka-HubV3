--[[
    ShinkaHub v3.0 - PARTE 1/4
    Estrutura principal + Abas Home e Local
    Execute esta parte primeiro.
--]]

-- Tabela global para compartilhamento entre as partes
_G.ShinkaHub = _G.ShinkaHub or {
    functionsActive = {},
    connections = {},
    waypoints = {},
    espSettings = {
        color = Color3.fromRGB(255, 0, 0),
        transparency = 0.5,
        showDistance = true,
    },
    autoFarmSettings = {
        delay = 0.5,
    },
    collectItemsSettings = {
        range = 50,
        ignoreList = {},
    },
    tabs = {},
    gui = nil,
    mainFrame = nil,
    minimizedFrame = nil,
}

local SH = _G.ShinkaHub

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
SH.gui = gui

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 480)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.Active = true
mainFrame.Draggable = false
mainFrame.Parent = gui
SH.mainFrame = mainFrame

-- Cantos arredondados
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Barra superior
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ShinkaHub v3"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Botões da barra
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(20, 20, 30)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)
minimizeBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.Parent = topBar

-- Arraste na topBar
local dragging = false
local dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Frame minimizado
local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 60, 0, 60)
minimizedFrame.Position = UDim2.new(0, 20, 0, 100)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
minimizedFrame.BorderSizePixel = 2
minimizedFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
minimizedFrame.Visible = false
minimizedFrame.Parent = gui
SH.minimizedFrame = minimizedFrame
Instance.new("UICorner", minimizedFrame).CornerRadius = UDim.new(0, 30)
local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "S"
minIcon.TextColor3 = Color3.fromRGB(20, 20, 30)
minIcon.TextScaled = true
minIcon.Font = Enum.Font.GothamBold
minIcon.Parent = minimizedFrame

-- Arraste do minimizado
local draggingMin = false
local dragMinStart, startMinPos
minimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        draggingMin = true
        dragMinStart = input.Position
        startMinPos = minimizedFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMin = false
            end
        end)
    end
end)
minimizedFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and draggingMin then
        local delta = input.Position - dragMinStart
        minimizedFrame.Position = UDim2.new(startMinPos.X.Scale, startMinPos.X.Offset + delta.X, startMinPos.Y.Scale, startMinPos.Y.Offset + delta.Y)
    end
end)

-- Alternar minimizar/restaurar
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedFrame.Visible = true
end)
minimizedFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        minimizedFrame.Visible = false
        mainFrame.Visible = true
    end
end)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Rodapé com créditos
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -20, 0, 25)
footer.Position = UDim2.new(0, 10, 1, -30)
footer.BackgroundTransparency = 0.5
footer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
footer.Text = "Shinka & Gemini"
footer.TextColor3 = Color3.fromRGB(255, 215, 0)
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.BorderSizePixel = 0
Instance.new("UICorner", footer).CornerRadius = UDim.new(0, 6)
footer.Parent = mainFrame

-- Sistema de abas
local tabButtonsFrame = Instance.new("Frame")
tabButtonsFrame.Size = UDim2.new(1, -20, 0, 40)
tabButtonsFrame.Position = UDim2.new(0, 10, 0, 45)
tabButtonsFrame.BackgroundTransparency = 1
tabButtonsFrame.Parent = mainFrame

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 1, -120)
tabContainer.Position = UDim2.new(0, 10, 0, 90)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame
tabContainer.ClipsDescendants = true

local function createTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 50, 1, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.new(1,1,1)
    tabButton.TextScaled = true
    tabButton.Font = Enum.Font.GothamSemibold
    tabButton.BorderSizePixel = 0
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabButton
    tabButton.Parent = tabButtonsFrame

    local function resize()
        local textSize = tabButton.TextBounds.X + 20
        tabButton.Size = UDim2.new(0, math.max(50, textSize), 1, 0)
    end
    resize()
    tabButton:GetPropertyChangedSignal("TextBounds"):Connect(resize)

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name.."Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 4
    tabContent.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.Visible = false
    tabContent.Parent = tabContainer
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = tabContent
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 10)
    end)

    SH.tabs[name] = {button = tabButton, content = tabContent, layout = layout}

    tabButton.MouseButton1Click:Connect(function()
        if SH.currentTab then
            SH.tabs[SH.currentTab].content.Visible = false
            SH.tabs[SH.currentTab].button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
        SH.currentTab = name
        tabContent.Visible = true
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    end)
end

-- Criar abas da parte 1
createTab("Home")
createTab("Local")
-- As outras serão criadas nas partes seguintes

-- Ativar primeira aba
SH.currentTab = "Home"
SH.tabs["Home"].content.Visible = true
SH.tabs["Home"].button.BackgroundColor3 = Color3.fromRGB(255, 215, 0)

-- Funções auxiliares
local function notify(text, color)
    color = color or Color3.fromRGB(0,200,0)
    local notify = Instance.new("TextLabel")
    notify.Size = UDim2.new(0, 200, 0, 50)
    notify.Position = UDim2.new(0.5, -100, 0.5, -25)
    notify.BackgroundColor3 = color
    notify.Text = text
    notify.TextColor3 = Color3.new(1,1,1)
    notify.TextScaled = true
    notify.Font = Enum.Font.GothamBold
    notify.ZIndex = 10
    notify.Parent = gui
    Instance.new("UICorner", notify).CornerRadius = UDim.new(0, 10)
    TweenService:Create(notify, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    wait(1)
    notify:Destroy()
end

local function createButton(tab, text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 50)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.Parent = SH.tabs[tab].content
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createInputBox(tab, placeholder, buttonText, color, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 90)
    frame.BackgroundTransparency = 1
    frame.Parent = SH.tabs[tab].content

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 0, 40)
    box.Position = UDim2.new(0, 0, 0, 0)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(180,180,180)
    box.TextScaled = true
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    box.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 1, -40)
    btn.BackgroundColor3 = color
    btn.Text = buttonText
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.Parent = frame

    btn.MouseButton1Click:Connect(function()
        callback(box.Text)
    end)
    return frame, box, btn
end

local function createToggleButton(tab, text, color, varName, onToggle)
    local btn = createButton(tab, text, color, function()
        SH.functionsActive[varName] = not SH.functionsActive[varName]
        if SH.functionsActive[varName] then
            btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
            if onToggle then onToggle(true) end
        else
            btn.BackgroundColor3 = color
            if onToggle then onToggle(false) end
        end
    end)
    return btn
end

-- ============================================
-- ABA HOME
-- ============================================
createButton("Home", "Copiar Discord", Color3.fromRGB(100, 100, 255), function()
    setclipboard("https://discord.gg/SNutmtu6x")
    notify("Link copiado!", Color3.fromRGB(0,200,0))
end)

createButton("Home", "Desativar Tudo", Color3.fromRGB(255, 50, 50), function()
    for k, v in pairs(SH.functionsActive) do
        if v then
            if k == "noclip" and SH.connections.noclip then SH.connections.noclip:Disconnect() SH.connections.noclip = nil end
            if k == "infJump" and SH.connections.infJump then SH.connections.infJump:Disconnect() SH.connections.infJump = nil end
            if k == "godMode" and SH.connections.godMode then SH.connections.godMode:Disconnect() SH.connections.godMode = nil end
            if k == "antiAFK" and SH.connections.antiAFK then SH.connections.antiAFK:Disconnect() SH.connections.antiAFK = nil end
            if k == "esp" then
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then
                        local highlight = player.Character:FindFirstChildOfClass("Highlight")
                        if highlight and highlight.Name == "ShinkaESP" then highlight:Destroy() end
                        local billboard = player.Character:FindFirstChildOfClass("BillboardGui")
                        if billboard and billboard.Name == "DistanceGUI" then billboard:Destroy() end
                    end
                end
                if SH.connections.playerAdded then SH.connections.playerAdded:Disconnect() end
                if SH.connections.playerRemoving then SH.connections.playerRemoving:Disconnect() end
            end
            if k == "autoFarm" and SH.connections.autoFarm then SH.connections.autoFarm:Disconnect() SH.connections.autoFarm = nil end
            if k == "collectItems" and SH.connections.collectItems then SH.connections.collectItems:Disconnect() SH.connections.collectItems = nil end
            SH.functionsActive[k] = false
        end
    end
    notify("Todas as funções desativadas", Color3.fromRGB(255,100,0))
end)

-- ============================================
-- ABA LOCAL
-- ============================================
createInputBox("Local", "Digite velocidade (ex: 16)", "Aplicar Speed", Color3.fromRGB(0, 120, 255), function(value)
    local speed = tonumber(value)
    if speed and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = speed end
    end
end)

createToggleButton("Local", "NoClip", Color3.fromRGB(200, 0, 200), "noclip", function(active)
    if active then
        SH.connections.noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if SH.connections.noclip then SH.connections.noclip:Disconnect() SH.connections.noclip = nil end
    end
end)

createToggleButton("Local", "Infinito Jump", Color3.fromRGB(0, 200, 100), "infJump", function(active)
    if active then
        SH.connections.infJump = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if SH.connections.infJump then SH.connections.infJump:Disconnect() SH.connections.infJump = nil end
    end
end)

createToggleButton("Local", "God Mode", Color3.fromRGB(255, 0, 0), "godMode", function(active)
    if active then
        SH.connections.godMode = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Health = humanoid.MaxHealth end
            end
        end)
    else
        if SH.connections.godMode then SH.connections.godMode:Disconnect() SH.connections.godMode = nil end
    end
end)

createToggleButton("Local", "Anti AFK", Color3.fromRGB(100, 100, 200), "antiAFK", function(active)
    if active then
        SH.connections.antiAFK = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Velocity = root.Velocity + Vector3.new(0.01,0,0)
                end
            end
        end)
    else
        if SH.connections.antiAFK then SH.connections.antiAFK:Disconnect() SH.connections.antiAFK = nil end
    end
end)

print("Parte 1/4 carregada. Execute a parte 2 agora.")--[[
    ShinkaHub v3.0 - PARTE 2/4
    Aba Teleports + parte da aba Visual
    Execute após a parte 1.
--]]

local SH = _G.ShinkaHub
if not SH or not SH.gui then
    warn("Execute a parte 1 primeiro!")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Criar abas que faltam (se não existirem)
if not SH.tabs["Teleports"] then
    createTab("Teleports")  -- função createTab já definida na parte 1
end
if not SH.tabs["Visual"] then
    createTab("Visual")
end

-- ============================================
-- ABA TELEPORTS
-- ============================================
createButton("Teleports", "Teleport para Mouse", Color3.fromRGB(255, 50, 50), function()
    local target = Mouse.Hit
    if target and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then root.CFrame = target end
    end
end)

createButton("Teleports", "Teleport para Jogador", Color3.fromRGB(255, 120, 0), function()
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0, 200, 0, 300)
    listFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
    listFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    listFrame.BorderSizePixel = 2
    listFrame.BorderColor3 = Color3.fromRGB(255,215,0)
    listFrame.Parent = SH.gui
    Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 10)
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Size = UDim2.new(1, -10, 1, -45)
    listContainer.Position = UDim2.new(0,5,0,5)
    listContainer.BackgroundTransparency = 1
    listContainer.ScrollBarThickness = 4
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listContainer.Parent = listFrame
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0,5)
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.Parent = listContainer

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 40)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
            btn.Text = player.Name
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextScaled = true
            btn.Font = Enum.Font.Gotham
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.Parent = listContainer
            btn.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = player.Character.HumanoidRootPart
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetRoot.CFrame + Vector3.new(0,3,0)
                        listFrame:Destroy()
                    end
                end
            end)
        end
    end

    local closeList = Instance.new("TextButton")
    closeList.Size = UDim2.new(1, -20, 0, 30)
    closeList.Position = UDim2.new(0,10,1,-35)
    closeList.BackgroundColor3 = Color3.fromRGB(255,70,70)
    closeList.Text = "Fechar"
    closeList.TextColor3 = Color3.new(1,1,1)
    closeList.TextScaled = true
    closeList.Font = Enum.Font.Gotham
    Instance.new("UICorner", closeList).CornerRadius = UDim.new(0,6)
    closeList.Parent = listFrame
    closeList.MouseButton1Click:Connect(function() listFrame:Destroy() end)
end)

-- Salvar posição (waypoint)
createInputBox("Teleports", "Nome do waypoint", "Salvar Posição", Color3.fromRGB(0, 200, 0), function(name)
    if name and name ~= "" and LocalPlayer.Character then
        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            table.insert(SH.waypoints, {name = name, cframe = root.CFrame})
            notify("Waypoint '"..name.."' salvo!", Color3.fromRGB(0,200,0))
        end
    end
end)

-- Teleport para waypoint (lista)
createButton("Teleports", "Teleport para Waypoint", Color3.fromRGB(255, 200, 0), function()
    if #SH.waypoints == 0 then notify("Nenhum waypoint salvo", Color3.fromRGB(255,0,0)) return end
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0, 200, 0, 300)
    listFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
    listFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    listFrame.BorderSizePixel = 2
    listFrame.BorderColor3 = Color3.fromRGB(255,215,0)
    listFrame.Parent = SH.gui
    Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 10)
    local listContainer = Instance.new("ScrollingFrame")
    listContainer.Size = UDim2.new(1, -10, 1, -45)
    listContainer.Position = UDim2.new(0,5,0,5)
    listContainer.BackgroundTransparency = 1
    listContainer.ScrollBarThickness = 4
    listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listContainer.Parent = listFrame
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0,5)
    listLayout.Parent = listContainer

    for i, wp in ipairs(SH.waypoints) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
        btn.Text = wp.name
        btn.TextColor3 = Color3.new(1,1,1)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.Parent = listContainer
        btn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = wp.cframe
                listFrame:Destroy()
            end
        end)
    end

    local closeList = Instance.new("TextButton")
    closeList.Size = UDim2.new(1, -20, 0, 30)
    closeList.Position = UDim2.new(0,10,1,-35)
    closeList.BackgroundColor3 = Color3.fromRGB(255,70,70)
    closeList.Text = "Fechar"
    closeList.TextColor3 = Color3.new(1,1,1)
    closeList.TextScaled = true
    closeList.Font = Enum.Font.Gotham
    Instance.new("UICorner", closeList).CornerRadius = UDim.new(0,6)
    closeList.Parent = listFrame
    closeList.MouseButton1Click:Connect(function() listFrame:Destroy() end)
end)

-- ============================================
-- ABA VISUAL (parte 1)
-- ============================================
-- ESP (toggle) com opções
createToggleButton("Visual", "ESP", Color3.fromRGB(255, 255, 0), "esp", function(active)
    if active then
        local function addESP(player)
            if player == LocalPlayer then return end
            local function apply(character)
                local highlight = Instance.new("Highlight")
                highlight.Name = "ShinkaESP"
                highlight.FillColor = SH.espSettings.color
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.FillTransparency = SH.espSettings.transparency
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.Parent = character
                if SH.espSettings.showDistance then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "DistanceGUI"
                    billboard.Size = UDim2.new(0, 100, 0, 30)
                    billboard.StudsOffset = Vector3.new(0,3,0)
                    billboard.AlwaysOnTop = true
                    local text = Instance.new("TextLabel")
                    text.Size = UDim2.new(1,0,1,0)
                    text.BackgroundTransparency = 1
                    text.TextColor3 = Color3.new(1,1,1)
                    text.TextStrokeTransparency = 0
                    text.Text = "??m"
                    text.TextScaled = true
                    text.Font = Enum.Font.GothamBold
                    text.Parent = billboard
                    billboard.Parent = character
                    local conn
                    conn = RunService.RenderStepped:Connect(function()
                        if character and character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            text.Text = math.floor(dist).."m"
                        else
                            conn:Disconnect()
                        end
                    end)
                end
            end
            if player.Character then
                apply(player.Character)
            end
            player.CharacterAdded:Connect(apply)
        end
        for _, player in pairs(Players:GetPlayers()) do
            addESP(player)
        end
        SH.connections.playerAdded = Players.PlayerAdded:Connect(addESP)
        SH.connections.playerRemoving = Players.PlayerRemoving:Connect(function(player)
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight and highlight.Name == "ShinkaESP" then highlight:Destroy() end
                local billboard = player.Character:FindFirstChildOfClass("BillboardGui")
                if billboard and billboard.Name == "DistanceGUI" then billboard:Destroy() end
            end
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight and highlight.Name == "ShinkaESP" then highlight:Destroy() end
                local billboard = player.Character:FindFirstChildOfClass("BillboardGui")
                if billboard and billboard.Name == "DistanceGUI" then billboard:Destroy() end
            end
        end
        if SH.connections.playerAdded then SH.connections.playerAdded:Disconnect() end
        if SH.connections.playerRemoving then SH.connections.playerRemoving:Disconnect() end
    end
end)

print("Parte 2/4 carregada. Execute a parte 3 agora.")--[[
    ShinkaHub v3.0 - PARTE 3/4
    Continuação da aba Visual + aba World
    Execute após a parte 2.
--]]

local SH = _G.ShinkaHub
if not SH or not SH.gui then
    warn("Execute a parte 1 primeiro!")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Criar aba World se não existir
if not SH.tabs["World"] then
    createTab("World")
end

-- ============================================
-- ABA VISUAL (continuação)
-- ============================================
-- Botão para configurar ESP (cor, transparência, distância)
createButton("Visual", "Configurar ESP", Color3.fromRGB(150, 150, 150), function()
    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(0, 250, 0, 200)
    configFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
    configFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
    configFrame.BorderSizePixel = 2
    configFrame.BorderColor3 = Color3.fromRGB(255,215,0)
    configFrame.Parent = SH.gui
    Instance.new("UICorner", configFrame).CornerRadius = UDim.new(0, 10)

    local y = 10
    local function createLabel(text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 25)
        lbl.Position = UDim2.new(0,10,0,y)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.TextScaled = true
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = configFrame
        y = y + 30
        return lbl
    end

    createLabel("Cor (R,G,B) exemplo: 255,0,0")
    local colorBox = Instance.new("TextBox")
    colorBox.Size = UDim2.new(1, -20, 0, 30)
    colorBox.Position = UDim2.new(0,10,0,y)
    colorBox.BackgroundColor3 = Color3.fromRGB(50,50,60)
    colorBox.TextColor3 = Color3.new(1,1,1)
    colorBox.PlaceholderText = "255,0,0"
    colorBox.TextScaled = true
    colorBox.Font = Enum.Font.Gotham
    Instance.new("UICorner", colorBox).CornerRadius = UDim.new(0,6)
    colorBox.Parent = configFrame
    y = y + 40

    createLabel("Transparência (0-1)")
    local transBox = Instance.new("TextBox")
    transBox.Size = UDim2.new(1, -20, 0, 30)
    transBox.Position = UDim2.new(0,10,0,y)
    transBox.BackgroundColor3 = Color3.fromRGB(50,50,60)
    transBox.TextColor3 = Color3.new(1,1,1)
    transBox.PlaceholderText = "0.5"
    transBox.TextScaled = true
    transBox.Font = Enum.Font.Gotham
    Instance.new("UICorner", transBox).CornerRadius = UDim.new(0,6)
    transBox.Parent = configFrame
    y = y + 40

    local distToggle = Instance.new("TextButton")
    distToggle.Size = UDim2.new(1, -20, 0, 30)
    distToggle.Position = UDim2.new(0,10,0,y)
    distToggle.BackgroundColor3 = SH.espSettings.showDistance and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    distToggle.Text = SH.espSettings.showDistance and "Distância: ON" or "Distância: OFF"
    distToggle.TextColor3 = Color3.new(1,1,1)
    distToggle.TextScaled = true
    distToggle.Font = Enum.Font.Gotham
    Instance.new("UICorner", distToggle).CornerRadius = UDim.new(0,6)
    distToggle.Parent = configFrame
    distToggle.MouseButton1Click:Connect(function()
        SH.espSettings.showDistance = not SH.espSettings.showDistance
        distToggle.BackgroundColor3 = SH.espSettings.showDistance and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        distToggle.Text = SH.espSettings.showDistance and "Distância: ON" or "Distância: OFF"
    end)
    y = y + 40

    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(1, -20, 0, 40)
    applyBtn.Position = UDim2.new(0,10,0,y)
    applyBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
    applyBtn.Text = "Aplicar"
    applyBtn.TextColor3 = Color3.new(1,1,1)
    applyBtn.TextScaled = true
    applyBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0,6)
    applyBtn.Parent = configFrame
    applyBtn.MouseButton1Click:Connect(function()
        -- Ler cor
        local r,g,b = colorBox.Text:match("(%d+),%s*(%d+),%s*(%d+)")
        if r and g and b then
            SH.espSettings.color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        end
        local t = tonumber(transBox.Text)
        if t then SH.espSettings.transparency = math.clamp(t,0,1) end
        -- Se ESP estiver ativo, recriar
        if SH.functionsActive.esp then
            -- Desativar primeiro
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChildOfClass("Highlight")
                    if highlight and highlight.Name == "ShinkaESP" then highlight:Destroy() end
                    local billboard = player.Character:FindFirstChildOfClass("BillboardGui")
                    if billboard and billboard.Name == "DistanceGUI" then billboard:Destroy() end
                end
            end
            -- Reativar
            local function addESP(player)
                if player == LocalPlayer then return end
                local function apply(character)
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ShinkaESP"
                    highlight.FillColor = SH.espSettings.color
                    highlight.OutlineColor = Color3.fromRGB(255,255,255)
                    highlight.FillTransparency = SH.espSettings.transparency
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = character
                    if SH.espSettings.showDistance then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "DistanceGUI"
                        billboard.Size = UDim2.new(0, 100, 0, 30)
                        billboard.StudsOffset = Vector3.new(0,3,0)
                        billboard.AlwaysOnTop = true
                        local text = Instance.new("TextLabel")
                        text.Size = UDim2.new(1,0,1,0)
                        text.BackgroundTransparency = 1
                        text.TextColor3 = Color3.new(1,1,1)
                        text.TextStrokeTransparency = 0
                        text.Text = "??m"
                        text.TextScaled = true
                        text.Font = Enum.Font.GothamBold
                        text.Parent = billboard
                        billboard.Parent = character
                        local conn
                        conn = RunService.RenderStepped:Connect(function()
                            if character and character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = (character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                                text.Text = math.floor(dist).."m"
                            else
                                conn:Disconnect()
                            end
                        end)
                    end
                end
                if player.Character then
                    apply(player.Character)
                end
                player.CharacterAdded:Connect(apply)
            end
            for _, player in pairs(Players:GetPlayers()) do
                addESP(player)
            end
        end
        configFrame:Destroy()
        notify("Configurações ESP aplicadas", Color3.fromRGB(0,200,0))
    end)
end)

-- Remover neblina
createButton("Visual", "Remover Neblina", Color3.fromRGB(0, 150, 255), function()
    local lighting = game:GetService("Lighting")
    lighting.FogEnd = 1e9
    lighting.FogStart = 1e9
    lighting.Brightness = 2
    notify("Neblina removida", Color3.fromRGB(0,200,0))
end)

-- Zoom infinito
createButton("Visual", "Zoom Infinito", Color3.fromRGB(255, 200, 100), function()
    LocalPlayer.CameraMaxZoomDistance = 999999
    LocalPlayer.CameraMinZoomDistance = 0
    notify("Zoom infinito ativado", Color3.fromRGB(0,200,0))
end)

-- ============================================
-- ABA WORLD
-- ============================================
-- Fly (carrega externo)
createButton("World", "Fly (Ativar)", Color3.fromRGB(255, 120, 0), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- Btools
createButton("World", "Btools (Construir)", Color3.fromRGB(100, 200, 255), function()
    local hammer = Instance.new("HopperBin")
    hammer.BinType = Enum.BinType.Hammer
    hammer.Parent = LocalPlayer.Backpack
    local clone = Instance.new("HopperBin")
    clone.BinType = Enum.BinType.Clone
    clone.Parent = LocalPlayer.Backpack
    local grip = Instance.new("HopperBin")
    grip.BinType = Enum.BinType.Grip
    grip.Parent = LocalPlayer.Backpack
    notify("Ferramentas adicionadas", Color3.fromRGB(0,200,0))
end)

-- Auto Farm (genérico - clica em botões)
createToggleButton("World", "Auto Farm (Botões)", Color3.fromRGB(255, 100, 100), "autoFarm", function(active)
    if active then
        SH.connections.autoFarm = RunService.Heartbeat:Connect(function()
            for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") then
                    for _, btn in pairs(gui:GetDescendants()) do
                        if btn:IsA("TextButton") and btn.Visible and btn.Active and btn.Text ~= "" then
                            btn:Fire("MouseButton1Click", nil)
                            wait(SH.autoFarmSettings.delay)
                        end
                    end
                end
            end
        end)
    else
        if SH.connections.autoFarm then SH.connections.autoFarm:Disconnect() SH.connections.autoFarm = nil end
    end
end)

-- Configurar Auto Farm (delay)
createInputBox("World", "Delay (segundos)", "Set Delay", Color3.fromRGB(150,150,150), function(value)
    local d = tonumber(value)
    if d then SH.autoFarmSettings.delay = d end
end)

-- Coletar itens automaticamente
createToggleButton("World", "Coletar Itens", Color3.fromRGB(0, 255, 100), "collectItems", function(active)
    if active then
        SH.connections.collectItems = RunService.Heartbeat:Connect(function()
            if not LocalPlayer.Character then return end
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("item") and not SH.collectItemsSettings.ignoreList[obj.Name] then
                    local dist = (obj.Position - root.Position).Magnitude
                    if dist < SH.collectItemsSettings.range then
                        root.CFrame = CFrame.new(obj.Position)
                        wait(0.1)
                        if obj:FindFirstChild("TouchInterest") then
                            firetouchinterest(root, obj, 0)
                            wait(0.1)
                            firetouchinterest(root, obj, 1)
                        end
                    end
                end
            end
        end)
    else
        if SH.connections.collectItems then SH.connections.collectItems:Disconnect() SH.connections.collectItems = nil end
    end
end)

-- Configurar alcance da coleta
createInputBox("World", "Alcance (ex: 50)", "Set Alcance", Color3.fromRGB(150,150,150), function(value)
    local r = tonumber(value)
    if r then SH.collectItemsSettings.range = r end
end)

print("Parte 3/4 carregada. Execute a parte 4 agora.")--[[
    ShinkaHub v3.0 - PARTE 4/4
    Aba Scripts + Finalização
    Execute por último.
--]]

local SH = _G.ShinkaHub
if not SH or not SH.gui then
    warn("Execute a parte 1 primeiro!")
    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Criar aba Scripts se não existir
if not SH.tabs["Scripts"] then
    createTab("Scripts")
end

-- ============================================
-- ABA SCRIPTS
-- ============================================
-- Executar script externo (loadstring)
createInputBox("Scripts", "URL do script", "Executar", Color3.fromRGB(255, 100, 0), function(url)
    if url and url ~= "" then
        local success, result = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if success then notify("Script executado", Color3.fromRGB(0,200,0))
        else notify("Erro ao executar", Color3.fromRGB(255,0,0)) end
    end
end)

-- Salvar script favorito (copia template para clipboard)
createInputBox("Scripts", "Nome do script", "Copiar Template", Color3.fromRGB(100,100,255), function(name)
    local template = '{"'..name..'":"https://exemplo.com/script.lua"}'
    setclipboard(template)
    notify("Template copiado! Edite e cole novamente para importar.", Color3.fromRGB(0,200,0))
end)

-- Importar scripts salvos (ler clipboard)
createButton("Scripts", "Importar Scripts", Color3.fromRGB(0,200,100), function()
    local success, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readclipboard()) end)
    if success and type(data) == "table" then
        local listFrame = Instance.new("Frame")
        listFrame.Size = UDim2.new(0, 250, 0, 300)
        listFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
        listFrame.BackgroundColor3 = Color3.fromRGB(30,30,40)
        listFrame.BorderSizePixel = 2
        listFrame.BorderColor3 = Color3.fromRGB(255,215,0)
        listFrame.Parent = SH.gui
        Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 10)
        local listContainer = Instance.new("ScrollingFrame")
        listContainer.Size = UDim2.new(1, -10, 1, -45)
        listContainer.Position = UDim2.new(0,5,0,5)
        listContainer.BackgroundTransparency = 1
        listContainer.ScrollBarThickness = 4
        listContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        listContainer.Parent = listFrame
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0,5)
        listLayout.Parent = listContainer

        for nome, url in pairs(data) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 40)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
            btn.Text = nome
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextScaled = true
            btn.Font = Enum.Font.Gotham
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            btn.Parent = listContainer
            btn.MouseButton1Click:Connect(function()
                local s, e = pcall(function() loadstring(game:HttpGet(url))() end)
                if s then notify("Script executado", Color3.fromRGB(0,200,0))
                else notify("Erro", Color3.fromRGB(255,0,0)) end
                listFrame:Destroy()
            end)
        end

        local closeList = Instance.new("TextButton")
        closeList.Size = UDim2.new(1, -20, 0, 30)
        closeList.Position = UDim2.new(0,10,1,-35)
        closeList.BackgroundColor3 = Color3.fromRGB(255,70,70)
        closeList.Text = "Fechar"
        closeList.TextColor3 = Color3.new(1,1,1)
        closeList.TextScaled = true
        closeList.Font = Enum.Font.Gotham
        Instance.new("UICorner", closeList).CornerRadius = UDim.new(0,6)
        closeList.Parent = listFrame
        closeList.MouseButton1Click:Connect(function() listFrame:Destroy() end)
    else
        notify("Nenhum script válido no clipboard", Color3.fromRGB(255,0,0))
    end
end)

-- Botão para limpar memória (opcional)
createButton("Scripts", "Limpar Memória", Color3.fromRGB(200, 0, 0), function()
    -- Tenta limpar conexões órfãs (já fazemos no desativar tudo)
    collectgarbage()
    notify("Memória limpa", Color3.fromRGB(0,200,0))
end)

print("ShinkaHub v3.0 carregado completamente! Todas as 4 partes executadas.")
