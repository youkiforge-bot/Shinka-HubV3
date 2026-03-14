--[[
    ShinkaHub V3.0 - PARTE 1/4
    Estrutura principal, abas Home e Local
    Execute primeiro.
--]]

_G.ShinkaHub = _G.ShinkaHub or {
    FA = {}, -- funções ativas
    C = {}, -- conexões
    WP = {}, -- waypoints
    ESP = {color = Color3.fromRGB(255,0,0), transp = 0.5, dist = true},
    FARM = {delay = 0.5},
    COLETA = {range = 50, ignore = {}},
    AIM = {team = false, hit = "Head"},
    tabs = {},
}

local SH = _G.ShinkaHub
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LP:WaitForChild("PlayerGui")
SH.gui = gui

-- Frame principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 480)
main.Position = UDim2.new(0.5, -160, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(20,20,30)
main.BorderSizePixel = 2
main.BorderColor3 = Color3.fromRGB(255,215,0)
main.Active = true
main.Draggable = false
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)
SH.main = main

-- Barra superior
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,40)
top.BackgroundColor3 = Color3.fromRGB(30,30,40)
top.BorderSizePixel = 0
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "ShinkaHub V3.0"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

-- Botões
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-70,0,5)
minBtn.BackgroundColor3 = Color3.fromRGB(255,215,0)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(20,20,30)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,6)
minBtn.Parent = top

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)
closeBtn.Parent = top

-- Arrastar
local dragging, dragStart, startPos
top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = main.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
top.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and dragging then
        local delta = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Frame minimizado
local mini = Instance.new("Frame")
mini.Size = UDim2.new(0,60,0,60)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(255,215,0)
mini.BorderSizePixel = 2
mini.BorderColor3 = Color3.fromRGB(255,255,255)
mini.Visible = false
mini.Parent = gui
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,30)
local miniIcon = Instance.new("TextLabel")
miniIcon.Size = UDim2.new(1,0,1,0)
miniIcon.BackgroundTransparency = 1
miniIcon.Text = "S"
miniIcon.TextColor3 = Color3.fromRGB(20,20,30)
miniIcon.TextScaled = true
miniIcon.Font = Enum.Font.GothamBold
miniIcon.Parent = mini

-- Arrastar minimizado
local dMin, dMinStart, dMinPos
mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dMin = true
        dMinStart = i.Position
        dMinPos = mini.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dMin = false end
        end)
    end
end)
mini.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and dMin then
        local delta = i.Position - dMinStart
        mini.Position = UDim2.new(dMinPos.X.Scale, dMinPos.X.Offset + delta.X, dMinPos.Y.Scale, dMinPos.Y.Offset + delta.Y)
    end
end)

-- Minimizar/Restaurar
minBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)
mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        mini.Visible = false
        main.Visible = true
    end
end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Rodapé
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1,-20,0,25)
footer.Position = UDim2.new(0,10,1,-30)
footer.BackgroundTransparency = 0.5
footer.BackgroundColor3 = Color3.fromRGB(30,30,40)
footer.Text = "Shinka & Gemini"
footer.TextColor3 = Color3.fromRGB(255,215,0)
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.BorderSizePixel = 0
Instance.new("UICorner", footer).CornerRadius = UDim.new(0,6)
footer.Parent = main

-- Sistema de abas
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1,-20,0,40)
tabFrame.Position = UDim2.new(0,10,0,45)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = main

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1,-20,1,-120)
tabContainer.Position = UDim2.new(0,10,0,90)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = main
tabContainer.ClipsDescendants = true

-- Função para criar abas (global)
_G.createTab = function(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,50,1,0)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.Parent = tabFrame

    local function resize()
        local s = btn.TextBounds.X + 20
        btn.Size = UDim2.new(0, math.max(50,s), 1, 0)
    end
    resize()
    btn:GetPropertyChangedSignal("TextBounds"):Connect(resize)

    local content = Instance.new("ScrollingFrame")
    content.Name = name.."Content"
    content.Size = UDim2.new(1,0,1,0)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(255,215,0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Visible = false
    content.Parent = tabContainer

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = content
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        content.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 10)
    end)

    SH.tabs[name] = {button = btn, content = content, layout = layout}

    btn.MouseButton1Click:Connect(function()
        if SH.currentTab then
            SH.tabs[SH.currentTab].content.Visible = false
            SH.tabs[SH.currentTab].button.BackgroundColor3 = Color3.fromRGB(40,40,50)
        end
        SH.currentTab = name
        content.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(255,215,0)
    end)
end

-- Funções auxiliares (globais)
_G.notify = function(text, color)
    color = color or Color3.fromRGB(0,200,0)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0,200,0,50)
    n.Position = UDim2.new(0.5,-100,0.5,-25)
    n.BackgroundColor3 = color
    n.Text = text
    n.TextColor3 = Color3.new(1,1,1)
    n.TextScaled = true
    n.Font = Enum.Font.GothamBold
    n.ZIndex = 10
    n.Parent = gui
    Instance.new("UICorner", n).CornerRadius = UDim.new(0,10)
    Tween:Create(n, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    wait(1)
    n:Destroy()
end

_G.createButton = function(tab, text, color, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-10,0,50)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamSemibold
    b.BorderSizePixel = 2
    b.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.Parent = SH.tabs[tab].content
    b.MouseButton1Click:Connect(cb)
    return b
end

_G.createInput = function(tab, placeholder, btText, color, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-10,0,90)
    f.BackgroundTransparency = 1
    f.Parent = SH.tabs[tab].content

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,0,0,40)
    box.Position = UDim2.new(0,0,0,0)
    box.BackgroundColor3 = Color3.fromRGB(50,50,60)
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(180,180,180)
    box.TextScaled = true
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    box.Parent = f

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,40)
    btn.Position = UDim2.new(0,0,1,-40)
    btn.BackgroundColor3 = color
    btn.Text = btText
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 2
    btn.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    btn.Parent = f

    btn.MouseButton1Click:Connect(function() cb(box.Text) end)
    return f, box, btn
end

_G.createToggle = function(tab, text, color, varName, onToggle)
    local b = createButton(tab, text, color, function()
        SH.FA[varName] = not SH.FA[varName]
        if SH.FA[varName] then
            b.BackgroundColor3 = Color3.fromRGB(255,215,0)
            if onToggle then onToggle(true) end
        else
            b.BackgroundColor3 = color
            if onToggle then onToggle(false) end
        end
    end)
    return b
end

-- Criar abas
createTab("Home")
createTab("Local")
createTab("Teleports")
createTab("Visual")
createTab("World")
createTab("Scripts")

SH.currentTab = "Home"
SH.tabs["Home"].content.Visible = true
SH.tabs["Home"].button.BackgroundColor3 = Color3.fromRGB(255,215,0)

-- ============================================
-- ABA HOME
-- ============================================
createButton("Home", "Copiar Discord", Color3.fromRGB(100,100,255), function()
    setclipboard("https://discord.gg/SNutmtu6x")
    notify("Link copiado!")
end)

createButton("Home", "Desativar Tudo", Color3.fromRGB(255,50,50), function()
    for k,v in pairs(SH.FA) do
        if v then
            if k == "noclip" and SH.C.noclip then SH.C.noclip:Disconnect() SH.C.noclip = nil end
            if k == "infJump" and SH.C.infJump then SH.C.infJump:Disconnect() SH.C.infJump = nil end
            if k == "godMode" and SH.C.godMode then SH.C.godMode:Disconnect() SH.C.godMode = nil end
            if k == "antiAFK" and SH.C.antiAFK then SH.C.antiAFK:Disconnect() SH.C.antiAFK = nil end
            if k == "aimbot" and SH.C.aimbot then SH.C.aimbot:Disconnect() SH.C.aimbot = nil end
            if k == "esp" then
                for _,p in pairs(Players:GetPlayers()) do
                    if p.Character then
                        local h = p.Character:FindFirstChildOfClass("Highlight")
                        if h and h.Name == "ShinkaESP" then h:Destroy() end
                        local b = p.Character:FindFirstChildOfClass("BillboardGui")
                        if b and b.Name == "DistanceGUI" then b:Destroy() end
                    end
                end
                if SH.C.playerAdded then SH.C.playerAdded:Disconnect() end
                if SH.C.playerRemoving then SH.C.playerRemoving:Disconnect() end
            end
            if k == "autoFarm" and SH.C.autoFarm then SH.C.autoFarm:Disconnect() SH.C.autoFarm = nil end
            if k == "coletar" and SH.C.coletar then SH.C.coletar:Disconnect() SH.C.coletar = nil end
            SH.FA[k] = false
        end
    end
    notify("Todas as funções desativadas", Color3.fromRGB(255,100,0))
end)

-- ============================================
-- ABA LOCAL
-- ============================================
createInput("Local", "Velocidade (ex: 16)", "Aplicar Speed", Color3.fromRGB(0,120,255), function(v)
    local s = tonumber(v)
    if s and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = s end
    end
end)

createToggle("Local", "NoClip", Color3.fromRGB(200,0,200), "noclip", function(a)
    if a then
        SH.C.noclip = RunService.Stepped:Connect(function()
            if LP.Character then
                for _,p in pairs(LP.Character:GetChildren()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if SH.C.noclip then SH.C.noclip:Disconnect() SH.C.noclip = nil end
    end
end)

createToggle("Local", "Infinito Jump", Color3.fromRGB(0,200,100), "infJump", function(a)
    if a then
        SH.C.infJump = UIS.JumpRequest:Connect(function()
            if LP.Character then
                local h = LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if SH.C.infJump then SH.C.infJump:Disconnect() SH.C.infJump = nil end
    end
end)

createToggle("Local", "God Mode", Color3.fromRGB(255,0,0), "godMode", function(a)
    if a then
        SH.C.godMode = RunService.Heartbeat:Connect(function()
            if LP.Character then
                local h = LP.Character:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 then h.Health = h.MaxHealth end
            end
        end)
    else
        if SH.C.godMode then SH.C.godMode:Disconnect() SH.C.godMode = nil end
    end
end)

createToggle("Local", "Anti AFK", Color3.fromRGB(100,100,200), "antiAFK", function(a)
    if a then
        SH.C.antiAFK = RunService.Stepped:Connect(function()
            if LP.Character then
                local r = LP.Character:FindFirstChild("HumanoidRootPart")
                if r then r.Velocity = r.Velocity + Vector3.new(0.01,0,0) end
            end
        end)
    else
        if SH.C.antiAFK then SH.C.antiAFK:Disconnect() SH.C.antiAFK = nil end
    end
end)

-- NOVA FUNÇÃO: Super Pulo
createInput("Local", "JumpPower (ex: 50)", "Super Pulo", Color3.fromRGB(255,180,0), function(v)
    local j = tonumber(v)
    if j and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.JumpPower = j end
    end
end)

print("Parte 1/4 carregada. Execute a parte 2 agora.")--[[
    ShinkaHub V3.0 - PARTE 2/4
    Aba Teleports e início da Visual
    Execute após a parte 1.
--]]

local SH = _G.ShinkaHub
if not SH then warn("Execute a parte 1 primeiro!") return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- ============================================
-- ABA TELEPORTS
-- ============================================
createButton("Teleports", "Teleport para Mouse", Color3.fromRGB(255,50,50), function()
    local t = Mouse.Hit
    if t and LP.Character then
        local r = LP.Character:FindFirstChild("HumanoidRootPart")
        if r then r.CFrame = t end
    end
end)

createButton("Teleports", "Teleport para Jogador", Color3.fromRGB(255,120,0), function()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,200,0,300)
    f.Position = UDim2.new(0.5,-100,0.5,-150)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = SH.gui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local c = Instance.new("ScrollingFrame")
    c.Size = UDim2.new(1,-10,1,-45)
    c.Position = UDim2.new(0,5,0,5)
    c.BackgroundTransparency = 1
    c.ScrollBarThickness = 4
    c.AutomaticCanvasSize = Enum.AutomaticSize.Y
    c.Parent = f
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0,5)
    lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    lay.Parent = c

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1,-10,0,40)
            b.BackgroundColor3 = Color3.fromRGB(50,50,60)
            b.Text = p.Name
            b.TextColor3 = Color3.new(1,1,1)
            b.TextScaled = true
            b.Font = Enum.Font.Gotham
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
            b.Parent = c
            b.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                    f:Destroy()
                end
            end)
        end
    end

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(1,-20,0,30)
    close.Position = UDim2.new(0,10,1,-35)
    close.BackgroundColor3 = Color3.fromRGB(255,70,70)
    close.Text = "Fechar"
    close.TextColor3 = Color3.new(1,1,1)
    close.TextScaled = true
    close.Font = Enum.Font.Gotham
    Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
    close.Parent = f
    close.MouseButton1Click:Connect(function() f:Destroy() end)
end)

createInput("Teleports", "Nome do waypoint", "Salvar", Color3.fromRGB(0,200,0), function(n)
    if n ~= "" and LP.Character then
        local r = LP.Character:FindFirstChild("HumanoidRootPart")
        if r then
            table.insert(SH.WP, {name = n, cframe = r.CFrame})
            notify("Waypoint '"..n.."' salvo!")
        end
    end
end)

createButton("Teleports", "Teleport para Waypoint", Color3.fromRGB(255,200,0), function()
    if #SH.WP == 0 then notify("Nenhum waypoint", Color3.fromRGB(255,0,0)) return end
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,200,0,300)
    f.Position = UDim2.new(0.5,-100,0.5,-150)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = SH.gui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local c = Instance.new("ScrollingFrame")
    c.Size = UDim2.new(1,-10,1,-45)
    c.Position = UDim2.new(0,5,0,5)
    c.BackgroundTransparency = 1
    c.ScrollBarThickness = 4
    c.AutomaticCanvasSize = Enum.AutomaticSize.Y
    c.Parent = f
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0,5)
    lay.Parent = c

    for i,wp in ipairs(SH.WP) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1,-10,0,40)
        b.BackgroundColor3 = Color3.fromRGB(50,50,60)
        b.Text = wp.name
        b.TextColor3 = Color3.new(1,1,1)
        b.TextScaled = true
        b.Font = Enum.Font.Gotham
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
        b.Parent = c
        b.MouseButton1Click:Connect(function()
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = wp.cframe
                f:Destroy()
            end
        end)
    end

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(1,-20,0,30)
    close.Position = UDim2.new(0,10,1,-35)
    close.BackgroundColor3 = Color3.fromRGB(255,70,70)
    close.Text = "Fechar"
    close.TextColor3 = Color3.new(1,1,1)
    close.TextScaled = true
    close.Font = Enum.Font.Gotham
    Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
    close.Parent = f
    close.MouseButton1Click:Connect(function() f:Destroy() end)
end)

-- ============================================
-- ABA VISUAL (início)
-- ============================================
createToggle("Visual", "ESP", Color3.fromRGB(255,255,0), "esp", function(a)
    if a then
        local function addESP(p)
            if p == LP then return end
            local function apply(c)
                local h = Instance.new("Highlight")
                h.Name = "ShinkaESP"
                h.FillColor = SH.ESP.color
                h.OutlineColor = Color3.fromRGB(255,255,255)
                h.FillTransparency = SH.ESP.transp
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                h.Parent = c
                if SH.ESP.dist then
                    local b = Instance.new("BillboardGui")
                    b.Name = "DistanceGUI"
                    b.Size = UDim2.new(0,100,0,30)
                    b.StudsOffset = Vector3.new(0,3,0)
                    b.AlwaysOnTop = true
                    local t = Instance.new("TextLabel")
                    t.Size = UDim2.new(1,0,1,0)
                    t.BackgroundTransparency = 1
                    t.TextColor3 = Color3.new(1,1,1)
                    t.TextStrokeTransparency = 0
                    t.Text = "??m"
                    t.TextScaled = true
                    t.Font = Enum.Font.GothamBold
                    t.Parent = b
                    b.Parent = c
                    local conn
                    conn = RunService.RenderStepped:Connect(function()
                        if c and c:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (c.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                            t.Text = math.floor(dist).."m"
                        else
                            conn:Disconnect()
                        end
                    end)
                end
            end
            if p.Character then apply(p.Character) end
            p.CharacterAdded:Connect(apply)
        end
        for _,p in pairs(Players:GetPlayers()) do addESP(p) end
        SH.C.playerAdded = Players.PlayerAdded:Connect(addESP)
        SH.C.playerRemoving = Players.PlayerRemoving:Connect(function(p)
            if p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight")
                if h and h.Name == "ShinkaESP" then h:Destroy() end
                local b = p.Character:FindFirstChildOfClass("BillboardGui")
                if b and b.Name == "DistanceGUI" then b:Destroy() end
            end
        end)
    else
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight")
                if h and h.Name == "ShinkaESP" then h:Destroy() end
                local b = p.Character:FindFirstChildOfClass("BillboardGui")
                if b and b.Name == "DistanceGUI" then b:Destroy() end
            end
        end
        if SH.C.playerAdded then SH.C.playerAdded:Disconnect() end
        if SH.C.playerRemoving then SH.C.playerRemoving:Disconnect() end
    end
end)

print("Parte 2/4 carregada. Execute a parte 3 agora.")--[[
    ShinkaHub V3.0 - PARTE 3/4
    Continuação Visual e início da World
    Execute após a parte 2.
--]]

local SH = _G.ShinkaHub
if not SH then warn("Execute a parte 1 primeiro!") return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- ============================================
-- ABA VISUAL (continuação)
-- ============================================
createButton("Visual", "Configurar ESP", Color3.fromRGB(150,150,150), function()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,250,0,200)
    f.Position = UDim2.new(0.5,-125,0.5,-100)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = SH.gui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local y = 10
    local function label(t)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1,-20,0,25)
        l.Position = UDim2.new(0,10,0,y)
        l.BackgroundTransparency = 1
        l.Text = t
        l.TextColor3 = Color3.new(1,1,1)
        l.TextScaled = true
        l.Font = Enum.Font.Gotham
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.Parent = f
        y = y + 30
    end

    label("Cor (R,G,B) ex: 255,0,0")
    local corBox = Instance.new("TextBox")
    corBox.Size = UDim2.new(1,-20,0,30)
    corBox.Position = UDim2.new(0,10,0,y)
    corBox.BackgroundColor3 = Color3.fromRGB(50,50,60)
    corBox.TextColor3 = Color3.new(1,1,1)
    corBox.PlaceholderText = "255,0,0"
    corBox.TextScaled = true
    corBox.Font = Enum.Font.Gotham
    Instance.new("UICorner", corBox).CornerRadius = UDim.new(0,6)
    corBox.Parent = f
    y = y + 40

    label("Transparência (0-1)")
    local transBox = Instance.new("TextBox")
    transBox.Size = UDim2.new(1,-20,0,30)
    transBox.Position = UDim2.new(0,10,0,y)
    transBox.BackgroundColor3 = Color3.fromRGB(50,50,60)
    transBox.TextColor3 = Color3.new(1,1,1)
    transBox.PlaceholderText = "0.5"
    transBox.TextScaled = true
    transBox.Font = Enum.Font.Gotham
    Instance.new("UICorner", transBox).CornerRadius = UDim.new(0,6)
    transBox.Parent = f
    y = y + 40

    local distBtn = Instance.new("TextButton")
    distBtn.Size = UDim2.new(1,-20,0,30)
    distBtn.Position = UDim2.new(0,10,0,y)
    distBtn.BackgroundColor3 = SH.ESP.dist and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    distBtn.Text = SH.ESP.dist and "Distância: ON" or "Distância: OFF"
    distBtn.TextColor3 = Color3.new(1,1,1)
    distBtn.TextScaled = true
    distBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", distBtn).CornerRadius = UDim.new(0,6)
    distBtn.Parent = f
    distBtn.MouseButton1Click:Connect(function()
        SH.ESP.dist = not SH.ESP.dist
        distBtn.BackgroundColor3 = SH.ESP.dist and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        distBtn.Text = SH.ESP.dist and "Distância: ON" or "Distância: OFF"
    end)
    y = y + 40

    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(1,-20,0,40)
    applyBtn.Position = UDim2.new(0,10,0,y)
    applyBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
    applyBtn.Text = "Aplicar"
    applyBtn.TextColor3 = Color3.new(1,1,1)
    applyBtn.TextScaled = true
    applyBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0,6)
    applyBtn.Parent = f
    applyBtn.MouseButton1Click:Connect(function()
        local r,g,b = corBox.Text:match("(%d+),%s*(%d+),%s*(%d+)")
        if r and g and b then SH.ESP.color = Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b)) end
        local t = tonumber(transBox.Text)
        if t then SH.ESP.transp = math.clamp(t,0,1) end
        if SH.FA.esp then
            -- Reaplicar ESP com novas configs
            for _,p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local h = p.Character:FindFirstChildOfClass("Highlight")
                    if h and h.Name == "ShinkaESP" then h:Destroy() end
                    local b = p.Character:FindFirstChildOfClass("BillboardGui")
                    if b and b.Name == "DistanceGUI" then b:Destroy() end
                end
            end
            local function addESP(p)
                if p == LP then return end
                local function apply(c)
                    local h = Instance.new("Highlight")
                    h.Name = "ShinkaESP"
                    h.FillColor = SH.ESP.color
                    h.OutlineColor = Color3.fromRGB(255,255,255)
                    h.FillTransparency = SH.ESP.transp
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    h.Parent = c
                    if SH.ESP.dist then
                        local b = Instance.new("BillboardGui")
                        b.Name = "DistanceGUI"
                        b.Size = UDim2.new(0,100,0,30)
                        b.StudsOffset = Vector3.new(0,3,0)
                        b.AlwaysOnTop = true
                        local t = Instance.new("TextLabel")
                        t.Size = UDim2.new(1,0,1,0)
                        t.BackgroundTransparency = 1
                        t.TextColor3 = Color3.new(1,1,1)
                        t.TextStrokeTransparency = 0
                        t.Text = "??m"
                        t.TextScaled = true
                        t.Font = Enum.Font.GothamBold
                        t.Parent = b
                        b.Parent = c
                        local conn
                        conn = RunService.RenderStepped:Connect(function()
                            if c and c:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = (c.HumanoidRootPart.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                                t.Text = math.floor(dist).."m"
                            else
                                conn:Disconnect()
                            end
                        end)
                    end
                end
                if p.Character then apply(p.Character) end
                p.CharacterAdded:Connect(apply)
            end
            for _,p in pairs(Players:GetPlayers()) do addESP(p) end
        end
        f:Destroy()
        notify("Configurações ESP aplicadas")
    end)
end)

createButton("Visual", "Remover Neblina", Color3.fromRGB(0,150,255), function()
    Lighting.FogEnd = 1e9
    Lighting.FogStart = 1e9
    Lighting.Brightness = 2
    notify("Neblina removida")
end)

createButton("Visual", "Zoom Infinito", Color3.fromRGB(255,200,100), function()
    LP.CameraMaxZoomDistance = 999999
    LP.CameraMinZoomDistance = 0
    notify("Zoom infinito ativado")
end)

-- ============================================
-- ABA WORLD (início)
-- ============================================
createButton("World", "Fly (Ativar)", Color3.fromRGB(255,120,0), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

createButton("World", "Btools", Color3.fromRGB(100,200,255), function()
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Hammer
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Clone
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Grip
    notify("Ferramentas adicionadas")
end)

createToggle("World", "Auto Farm (Botões)", Color3.fromRGB(255,100,100), "autoFarm", function(a)
    if a then
        SH.C.autoFarm = RunService.Heartbeat:Connect(function()
            for _,g in pairs(LP.PlayerGui:GetChildren()) do
                if g:IsA("ScreenGui") then
                    for _,b in pairs(g:GetDescendants()) do
                        if b:IsA("TextButton") and b.Visible and b.Active and b.Text ~= "" then
                            b:Fire("MouseButton1Click", nil)
                            wait(SH.FARM.delay)
                        end
                    end
                end
            end
        end)
    else
        if SH.C.autoFarm then SH.C.autoFarm:Disconnect() SH.C.autoFarm = nil end
    end
end)

createInput("World", "Delay (segundos)", "Set Delay", Color3.fromRGB(150,150,150), function(v)
    local d = tonumber(v)
    if d then SH.FARM.delay = d end
end)

print("Parte 3/4 carregada. Execute a parte 4 agora.")--[[
    ShinkaHub V3.0 - PARTE 4/4
    World (restante) e Scripts
    Execute por último.
--]]

local SH = _G.ShinkaHub
if not SH then warn("Execute a parte 1 primeiro!") return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- ============================================
-- ABA WORLD (continuação)
-- ============================================
createToggle("World", "Coletar Itens", Color3.fromRGB(0,255,100), "coletar", function(a)
    if a then
        SH.C.coletar = RunService.Heartbeat:Connect(function()
            if not LP.Character then return end
            local root = LP.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            for _,obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("item") and not SH.COLETA.ignore[obj.Name] then
                    local dist = (obj.Position - root.Position).Magnitude
                    if dist < SH.COLETA.range then
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
        if SH.C.coletar then SH.C.coletar:Disconnect() SH.C.coletar = nil end
    end
end)

createInput("World", "Alcance (ex: 50)", "Set Alcance", Color3.fromRGB(150,150,150), function(v)
    local r = tonumber(v)
    if r then SH.COLETA.range = r end
end)

createToggle("World", "Aimbot", Color3.fromRGB(255,0,255), "aimbot", function(a)
    if a then
        SH.C.aimbot = RunService.RenderStepped:Connect(function()
            if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
            local closest, closestDist = nil, math.huge
            for _,p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if SH.AIM.team and p.Team == LP.Team then continue end
                    local part = p.Character:FindFirstChild(SH.AIM.hit) or p.Character.HumanoidRootPart
                    local screenPos, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local d = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if d < closestDist then
                            closestDist = d
                            closest = p
                        end
                    end
                end
            end
            if closest then
                local targetPart = closest.Character:FindFirstChild(SH.AIM.hit) or closest.Character.HumanoidRootPart
                Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, targetPart.Position)
            end
        end)
    else
        if SH.C.aimbot then SH.C.aimbot:Disconnect() SH.C.aimbot = nil end
    end
end)

-- NOVA FUNÇÃO: Gravidade Personalizada
createInput("World", "Gravidade (ex: 50)", "Aplicar Gravidade", Color3.fromRGB(0,200,200), function(v)
    local g = tonumber(v)
    if g then Workspace.Gravity = g notify("Gravidade alterada para "..g) end
end)

-- ============================================
-- ABA SCRIPTS
-- ============================================
createInput("Scripts", "URL do script", "Executar", Color3.fromRGB(255,100,0), function(url)
    if url and url ~= "" then
        local s, e = pcall(function() loadstring(game:HttpGet(url))() end)
        if s then notify("Script executado") else notify("Erro", Color3.fromRGB(255,0,0)) end
    end
end)

createInput("Scripts", "Nome do script", "Copiar Template", Color3.fromRGB(100,100,255), function(name)
    local template = '{"'..name..'":"https://exemplo.com/script.lua"}'
    setclipboard(template)
    notify("Template copiado! Edite e cole novamente para importar.")
end)

createButton("Scripts", "Importar Scripts", Color3.fromRGB(0,200,100), function()
    local s, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readclipboard()) end)
    if s and type(data) == "table" then
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0,250,0,300)
        f.Position = UDim2.new(0.5,-125,0.5,-150)
        f.BackgroundColor3 = Color3.fromRGB(30,30,40)
        f.BorderSizePixel = 2
        f.BorderColor3 = Color3.fromRGB(255,215,0)
        f.Parent = SH.gui
        Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

        local c = Instance.new("ScrollingFrame")
        c.Size = UDim2.new(1,-10,1,-45)
        c.Position = UDim2.new(0,5,0,5)
        c.BackgroundTransparency = 1
        c.ScrollBarThickness = 4
        c.AutomaticCanvasSize = Enum.AutomaticSize.Y
        c.Parent = f
        local lay = Instance.new("UIListLayout")
        lay.Padding = UDim.new(0,5)
        lay.Parent = c

        for nome, url in pairs(data) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1,-10,0,40)
            b.BackgroundColor3 = Color3.fromRGB(50,50,60)
            b.Text = nome
            b.TextColor3 = Color3.new(1,1,1)
            b.TextScaled = true
            b.Font = Enum.Font.Gotham
            Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
            b.Parent = c
            b.MouseButton1Click:Connect(function()
                local ok, err = pcall(function() loadstring(game:HttpGet(url))() end)
                if ok then notify("Script executado") else notify("Erro", Color3.fromRGB(255,0,0)) end
                f:Destroy()
            end)
        end

        local close = Instance.new("TextButton")
        close.Size = UDim2.new(1,-20,0,30)
        close.Position = UDim2.new(0,10,1,-35)
        close.BackgroundColor3 = Color3.fromRGB(255,70,70)
        close.Text = "Fechar"
        close.TextColor3 = Color3.new(1,1,1)
        close.TextScaled = true
        close.Font = Enum.Font.Gotham
        Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
        close.Parent = f
        close.MouseButton1Click:Connect(function() f:Destroy() end)
    else
        notify("Nenhum script válido no clipboard", Color3.fromRGB(255,0,0))
    end
end)

createButton("Scripts", "Limpar Memória", Color3.fromRGB(200,0,0), function()
    collectgarbage()
    notify("Memória limpa")
end)

print("ShinkaHub V3.0 carregado completamente! Todas as 4 partes executadas.")
