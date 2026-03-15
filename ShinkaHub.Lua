--[[
    ShinkaHub V3 (ESP Avançado) - PARTE 1/4
    Baseado no Shinka V2, apenas ESP melhorado.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = Workspace.CurrentCamera

-- Variáveis de controle (mesmas do V2)
local FA = {
    noclip = false,
    infJump = false,
    godMode = false,
    antiAFK = false,
    esp = false,
    autoFarm = false,
    collectItems = false,
    aimbot = false,
}
local C = {}
local WP = {}

-- Configurações do ESP (agora mais avançado)
local esp = {
    color = Color3.fromRGB(255, 0, 0),
    transp = 0.5,
    showName = true,
    showDist = true,
    showHealth = false,
    showBox = false,
    boxColor = Color3.fromRGB(255, 255, 255),
}

-- Outras configs (iguais)
local farm = { delay = 0.5 }
local collect = { range = 50, ignore = {} }
local aim = { teamCheck = false, hitPart = "Head" }

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ShinkaHubV3"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = LP:WaitForChild("PlayerGui")

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
title.Text = "ShinkaHub V3"
title.TextColor3 = Color3.fromRGB(255,215,0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local min = Instance.new("TextButton")
min.Size = UDim2.new(0,30,0,30)
min.Position = UDim2.new(1,-70,0,5)
min.BackgroundColor3 = Color3.fromRGB(255,215,0)
min.Text = "-"
min.TextColor3 = Color3.fromRGB(20,20,30)
min.TextScaled = true
min.Font = Enum.Font.GothamBold
min.BorderSizePixel = 0
Instance.new("UICorner", min).CornerRadius = UDim.new(0,6)
min.Parent = top

local cls = Instance.new("TextButton")
cls.Size = UDim2.new(0,30,0,30)
cls.Position = UDim2.new(1,-35,0,5)
cls.BackgroundColor3 = Color3.fromRGB(255,70,70)
cls.Text = "X"
cls.TextColor3 = Color3.new(1,1,1)
cls.TextScaled = true
cls.Font = Enum.Font.GothamBold
cls.BorderSizePixel = 0
Instance.new("UICorner", cls).CornerRadius = UDim.new(0,6)
cls.Parent = top

-- Arrastar
local drag, ds, sp
top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        ds = i.Position
        sp = main.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then drag = false end
        end)
    end
end)
top.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and drag then
        local d = i.Position - ds
        main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
    end
end)

-- Minimizado
local mini = Instance.new("Frame")
mini.Size = UDim2.new(0,60,0,60)
mini.Position = UDim2.new(0,20,0,100)
mini.BackgroundColor3 = Color3.fromRGB(255,215,0)
mini.BorderSizePixel = 2
mini.BorderColor3 = Color3.fromRGB(255,255,255)
mini.Visible = false
mini.Parent = gui
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,30)
local ic = Instance.new("TextLabel")
ic.Size = UDim2.new(1,0,1,0)
ic.BackgroundTransparency = 1
ic.Text = "S"
ic.TextColor3 = Color3.fromRGB(20,20,30)
ic.TextScaled = true
ic.Font = Enum.Font.GothamBold
ic.Parent = mini

local dM, dMs, spM
mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        dM = true
        dMs = i.Position
        spM = mini.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dM = false end
        end)
    end
end)
mini.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch and dM then
        local d = i.Position - dMs
        mini.Position = UDim2.new(spM.X.Scale, spM.X.Offset + d.X, spM.Y.Scale, spM.Y.Offset + d.Y)
    end
end)

min.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)
mini.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch then
        mini.Visible = false
        main.Visible = true
    end
end)
cls.MouseButton1Click:Connect(function() gui:Destroy() end)

local rod = Instance.new("TextLabel")
rod.Size = UDim2.new(1,-20,0,25)
rod.Position = UDim2.new(0,10,1,-30)
rod.BackgroundTransparency = 0.5
rod.BackgroundColor3 = Color3.fromRGB(30,30,40)
rod.Text = "Shinka & Gemini"
rod.TextColor3 = Color3.fromRGB(255,215,0)
rod.TextScaled = true
rod.Font = Enum.Font.Gotham
rod.BorderSizePixel = 0
Instance.new("UICorner", rod).CornerRadius = UDim.new(0,6)
rod.Parent = main

-- Sistema de abas
local tabF = Instance.new("Frame")
tabF.Size = UDim2.new(1,-20,0,40)
tabF.Position = UDim2.new(0,10,0,45)
tabF.BackgroundTransparency = 1
tabF.Parent = main

local tabC = Instance.new("Frame")
tabC.Size = UDim2.new(1,-20,1,-120)
tabC.Position = UDim2.new(0,10,0,90)
tabC.BackgroundTransparency = 1
tabC.Parent = main
tabC.ClipsDescendants = true

local tabs = {}
local curTab

local function crTab(name)
    local bt = Instance.new("TextButton")
    bt.Size = UDim2.new(0,50,1,0)
    bt.BackgroundColor3 = Color3.fromRGB(40,40,50)
    bt.Text = name
    bt.TextColor3 = Color3.new(1,1,1)
    bt.TextScaled = true
    bt.Font = Enum.Font.GothamSemibold
    bt.BorderSizePixel = 0
    Instance.new("UICorner", bt).CornerRadius = UDim.new(0,6)
    bt.Parent = tabF

    local function rs()
        local s = bt.TextBounds.X + 20
        bt.Size = UDim2.new(0, math.max(50,s), 1, 0)
    end
    rs()
    bt:GetPropertyChangedSignal("TextBounds"):Connect(rs)

    local c = Instance.new("ScrollingFrame")
    c.Name = name.."Content"
    c.Size = UDim2.new(1,0,1,0)
    c.BackgroundTransparency = 1
    c.ScrollBarThickness = 4
    c.ScrollBarImageColor3 = Color3.fromRGB(255,215,0)
    c.AutomaticCanvasSize = Enum.AutomaticSize.Y
    c.Visible = false
    c.Parent = tabC
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0,8)
    lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = c
    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        c.CanvasSize = UDim2.new(0,0,0, lay.AbsoluteContentSize.Y + 10)
    end)

    tabs[name] = { button = bt, content = c, layout = lay }

    bt.MouseButton1Click:Connect(function()
        if curTab then
            tabs[curTab].content.Visible = false
            tabs[curTab].button.BackgroundColor3 = Color3.fromRGB(40,40,50)
        end
        curTab = name
        c.Visible = true
        bt.BackgroundColor3 = Color3.fromRGB(255,215,0)
    end)
end

crTab("Home")
crTab("Local")
crTab("Teleports")
crTab("Visual")
crTab("World")
crTab("Scripts")
curTab = "Home"
tabs["Home"].content.Visible = true
tabs["Home"].button.BackgroundColor3 = Color3.fromRGB(255,215,0)

-- Funções auxiliares
local function n(t, c)
    c = c or Color3.fromRGB(0,200,0)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(0,200,0,50)
    n.Position = UDim2.new(0.5,-100,0.5,-25)
    n.BackgroundColor3 = c
    n.Text = t
    n.TextColor3 = Color3.new(1,1,1)
    n.TextScaled = true
    n.Font = Enum.Font.GothamBold
    n.ZIndex = 10
    n.Parent = gui
    Instance.new("UICorner", n).CornerRadius = UDim.new(0,10)
    TweenService:Create(n, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    wait(1)
    n:Destroy()
end

local function btn(tab, txt, col, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-10,0,50)
    b.BackgroundColor3 = col
    b.Text = txt
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamSemibold
    b.BorderSizePixel = 2
    b.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.Parent = tabs[tab].content
    b.MouseButton1Click:Connect(cb)
    return b
end

local function inp(tab, ph, bt, col, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,-10,0,90)
    f.BackgroundTransparency = 1
    f.Parent = tabs[tab].content

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,0,0,40)
    box.Position = UDim2.new(0,0,0,0)
    box.BackgroundColor3 = Color3.fromRGB(50,50,60)
    box.TextColor3 = Color3.new(1,1,1)
    box.PlaceholderText = ph
    box.PlaceholderColor3 = Color3.fromRGB(180,180,180)
    box.TextScaled = true
    box.Font = Enum.Font.Gotham
    box.ClearTextOnFocus = false
    box.BorderSizePixel = 2
    box.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,6)
    box.Parent = f

    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,40)
    b.Position = UDim2.new(0,0,1,-40)
    b.BackgroundColor3 = col
    b.Text = bt
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamSemibold
    b.BorderSizePixel = 2
    b.BorderColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    b.Parent = f

    b.MouseButton1Click:Connect(function() cb(box.Text) end)
    return f, box, b
end

local function tog(tab, txt, col, name, on)
    local b = btn(tab, txt, col, function()
        FA[name] = not FA[name]
        if FA[name] then
            b.BackgroundColor3 = Color3.fromRGB(255,215,0)
            if on then on(true) end
        else
            b.BackgroundColor3 = col
            if on then on(false) end
        end
    end)
    return b
end

-- ============================================
-- ABA HOME (igual ao V2)
-- ============================================
btn("Home", "Copiar Discord", Color3.fromRGB(100,100,255), function()
    setclipboard("https://discord.gg/SNutmtu6x")
    n("Link copiado!")
end)

btn("Home", "Desativar Tudo", Color3.fromRGB(255,50,50), function()
    for k, v in pairs(FA) do
        if v then
            if k == "noclip" and C.noclip then C.noclip:Disconnect() C.noclip = nil end
            if k == "infJump" and C.infJump then C.infJump:Disconnect() C.infJump = nil end
            if k == "godMode" and C.godMode then C.godMode:Disconnect() C.godMode = nil end
            if k == "antiAFK" and C.antiAFK then C.antiAFK:Disconnect() C.antiAFK = nil end
            if k == "aimbot" and C.aimbot then C.aimbot:Disconnect() C.aimbot = nil end
            if k == "esp" then
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character then
                        local h = p.Character:FindFirstChildOfClass("Highlight")
                        if h and h.Name == "ShinkaESP" then h:Destroy() end
                        for _, v in pairs(p.Character:GetChildren()) do
                            if v:IsA("BillboardGui") and v.Name:find("Shinka") then v:Destroy() end
                        end
                    end
                end
                if C.playerAdded then C.playerAdded:Disconnect() end
                if C.playerRemoving then C.playerRemoving:Disconnect() end
            end
            if k == "autoFarm" and C.autoFarm then C.autoFarm:Disconnect() C.autoFarm = nil end
            if k == "collectItems" and C.collectItems then C.collectItems:Disconnect() C.collectItems = nil end
            FA[k] = false
        end
    end
    n("Todas as funções desativadas", Color3.fromRGB(255,100,0))
end)

-- ============================================
-- ABA LOCAL (igual ao V2)
-- ============================================
inp("Local", "Velocidade (ex:16)", "Aplicar Speed", Color3.fromRGB(0,120,255), function(v)
    local s = tonumber(v)
    if s and LP.Character then
        local h = LP.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = s end
    end
end)

tog("Local", "NoClip", Color3.fromRGB(200,0,200), "noclip", function(a)
    if a then
        C.noclip = RunService.Stepped:Connect(function()
            if LP.Character then
                for _, p in pairs(LP.Character:GetChildren()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if C.noclip then C.noclip:Disconnect() C.noclip = nil end
    end
end)

tog("Local", "Infinito Jump", Color3.fromRGB(0,200,100), "infJump", function(a)
    if a then
        C.infJump = UserInputService.JumpRequest:Connect(function()
            if LP.Character then
                local h = LP.Character:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if C.infJump then C.infJump:Disconnect() C.infJump = nil end
    end
end)

tog("Local", "God Mode", Color3.fromRGB(255,0,0), "godMode", function(a)
    if a then
        C.godMode = RunService.Heartbeat:Connect(function()
            if LP.Character then
                local h = LP.Character:FindFirstChildOfClass("Humanoid")
                if h and h.Health > 0 then h.Health = h.MaxHealth end
            end
        end)
    else
        if C.godMode then C.godMode:Disconnect() C.godMode = nil end
    end
end)

tog("Local", "Anti AFK", Color3.fromRGB(100,100,200), "antiAFK", function(a)
    if a then
        C.antiAFK = RunService.Stepped:Connect(function()
            if LP.Character then
                local r = LP.Character:FindFirstChild("HumanoidRootPart")
                if r then r.Velocity = r.Velocity + Vector3.new(0.01,0,0) end
            end
        end)
    else
        if C.antiAFK then C.antiAFK:Disconnect() C.antiAFK = nil end
    end
end)

print("Parte 1/4 carregada. Execute a parte 2 agora.")--[[
    ShinkaHub V3 (ESP Avançado) - PARTE 2/4
    Aba Teleports e início da Visual (ESP melhorado)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- Verificar se as variáveis existem
if not FA or not C or not WP or not esp then
    warn("Execute a parte 1 primeiro!")
    return
end

-- ============================================
-- ABA TELEPORTS (igual ao V2)
-- ============================================
btn("Teleports", "TP Player", Color3.fromRGB(255,120,0), function()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,200,0,300)
    f.Position = UDim2.new(0.5,-100,0.5,-150)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = gui
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

    for _, p in pairs(Players:GetPlayers()) do
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

    local cf = Instance.new("TextButton")
    cf.Size = UDim2.new(1,-20,0,30)
    cf.Position = UDim2.new(0,10,1,-35)
    cf.BackgroundColor3 = Color3.fromRGB(255,70,70)
    cf.Text = "Fechar"
    cf.TextColor3 = Color3.new(1,1,1)
    cf.TextScaled = true
    cf.Font = Enum.Font.Gotham
    Instance.new("UICorner", cf).CornerRadius = UDim.new(0,6)
    cf.Parent = f
    cf.MouseButton1Click:Connect(function() f:Destroy() end)
end)

inp("Teleports", "Nome waypoint", "Salvar", Color3.fromRGB(0,200,0), function(n)
    if n ~= "" and LP.Character then
        local r = LP.Character:FindFirstChild("HumanoidRootPart")
        if r then
            table.insert(WP, { name = n, cframe = r.CFrame })
            n("Waypoint '"..n.."' salvo!")
        end
    end
end)

btn("Teleports", "TP Waypoint", Color3.fromRGB(255,200,0), function()
    if #WP == 0 then n("Nenhum waypoint", Color3.fromRGB(255,0,0)) return end
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,200,0,300)
    f.Position = UDim2.new(0.5,-100,0.5,-150)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = gui
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

    for i, wp in ipairs(WP) do
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

    local cf = Instance.new("TextButton")
    cf.Size = UDim2.new(1,-20,0,30)
    cf.Position = UDim2.new(0,10,1,-35)
    cf.BackgroundColor3 = Color3.fromRGB(255,70,70)
    cf.Text = "Fechar"
    cf.TextColor3 = Color3.new(1,1,1)
    cf.TextScaled = true
    cf.Font = Enum.Font.Gotham
    Instance.new("UICorner", cf).CornerRadius = UDim.new(0,6)
    cf.Parent = f
    cf.MouseButton1Click:Connect(function() f:Destroy() end)
end)

-- ============================================
-- ABA VISUAL (ESP melhorado)
-- ============================================
local function updateESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local c = p.Character
            local root = c:FindFirstChild("HumanoidRootPart")
            if root then
                -- Highlight
                local h = c:FindFirstChildOfClass("Highlight")
                if not h then
                    h = Instance.new("Highlight")
                    h.Name = "ShinkaESP"
                    h.Parent = c
                end
                h.FillColor = esp.color
                h.FillTransparency = esp.transp
                h.OutlineColor = Color3.fromRGB(255,255,255)
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                -- Billboard
                local b = c:FindFirstChild("ShinkaBillboard")
                if not b then
                    b = Instance.new("BillboardGui")
                    b.Name = "ShinkaBillboard"
                    b.Size = UDim2.new(0,150,0, esp.showHealth and 70 or 50)
                    b.StudsOffset = Vector3.new(0,3,0)
                    b.AlwaysOnTop = true
                    b.Parent = c

                    local nameL = Instance.new("TextLabel")
                    nameL.Name = "Name"
                    nameL.Size = UDim2.new(1,0, esp.showHealth and 0.33 or 0.5, 0)
                    nameL.Position = UDim2.new(0,0,0,0)
                    nameL.BackgroundTransparency = 1
                    nameL.TextColor3 = Color3.new(1,1,1)
                    nameL.TextStrokeTransparency = 0
                    nameL.TextScaled = true
                    nameL.Font = Enum.Font.GothamBold
                    nameL.Parent = b

                    local distL = Instance.new("TextLabel")
                    distL.Name = "Distance"
                    distL.Size = UDim2.new(1,0, esp.showHealth and 0.33 or 0.5, 0)
                    distL.Position = esp.showHealth and UDim2.new(0,0,0.33,0) or UDim2.new(0,0,0.5,0)
                    distL.BackgroundTransparency = 1
                    distL.TextColor3 = Color3.new(1,1,1)
                    distL.TextStrokeTransparency = 0
                    distL.TextScaled = true
                    distL.Font = Enum.Font.Gotham
                    distL.Parent = b

                    if esp.showHealth then
                        local healthL = Instance.new("TextLabel")
                        healthL.Name = "Health"
                        healthL.Size = UDim2.new(1,0,0.33,0)
                        healthL.Position = UDim2.new(0,0,0.66,0)
                        healthL.BackgroundTransparency = 1
                        healthL.TextColor3 = Color3.new(0,1,0)
                        healthL.TextStrokeTransparency = 0
                        healthL.TextScaled = true
                        healthL.Font = Enum.Font.Gotham
                        healthL.Parent = b
                    end
                end

                -- Atualizar textos
                local nameL = b:FindFirstChild("Name")
                local distL = b:FindFirstChild("Distance")
                local healthL = b:FindFirstChild("Health")

                if nameL then
                    nameL.Text = esp.showName and p.Name or ""
                end
                if distL and esp.showDist and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (root.Position - LP.Character.HumanoidRootPart.Position).Magnitude
                    distL.Text = math.floor(dist) .. "m"
                elseif distL then
                    distL.Text = ""
                end
                if healthL and esp.showHealth then
                    local hum = c:FindFirstChildOfClass("Humanoid")
                    if hum then
                        healthL.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                    else
                        healthL.Text = ""
                    end
                elseif healthL then
                    healthL.Text = ""
                end

                -- Caixa (opcional)
                if esp.showBox then
                    local box = c:FindFirstChild("ShinkaBox")
                    if not box then
                        box = Instance.new("BillboardGui")
                        box.Name = "ShinkaBox"
                        box.Size = UDim2.new(0,4,0,6) -- proporção largura/altura
                        box.StudsOffset = Vector3.new(0,2,0)
                        box.AlwaysOnTop = true
                        box.Parent = c
                        local frame = Instance.new("Frame")
                        frame.Size = UDim2.new(1,0,1,0)
                        frame.BackgroundTransparency = 1
                        frame.BorderSizePixel = 2
                        frame.BorderColor3 = esp.boxColor
                        frame.Parent = box
                    end
                else
                    local box = c:FindFirstChild("ShinkaBox")
                    if box then box:Destroy() end
                end
            end
        end
    end
end

tog("Visual", "ESP", Color3.fromRGB(255,255,0), "esp", function(a)
    if a then
        C.esp = RunService.RenderStepped:Connect(updateESP)
        C.playerAdded = Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                if FA.esp then updateESP() end
            end)
        end)
    else
        if C.esp then C.esp:Disconnect() C.esp = nil end
        if C.playerAdded then C.playerAdded:Disconnect() C.playerAdded = nil end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight")
                if h and h.Name == "ShinkaESP" then h:Destroy() end
                for _, v in pairs(p.Character:GetChildren()) do
                    if v:IsA("BillboardGui") and v.Name:find("Shinka") then v:Destroy() end
                end
            end
        end
    end
end)

print("Parte 2/4 carregada. Execute a parte 3 agora.")--[[
    ShinkaHub V3 (ESP Avançado) - PARTE 3/4
    Configuração do ESP e outras funções visuais
--]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer

if not esp then
    warn("Execute a parte 1 primeiro!")
    return
end

-- ============================================
-- ABA VISUAL (continuação)
-- ============================================
btn("Visual", "Configurar ESP", Color3.fromRGB(150,150,150), function()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0,250,0,350)
    f.Position = UDim2.new(0.5,-125,0.5,-175)
    f.BackgroundColor3 = Color3.fromRGB(30,30,40)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255,215,0)
    f.Parent = gui
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local y = 10
    local function lbl(t)
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

    lbl("Cor (R,G,B) ex: 255,0,0")
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

    lbl("Transparência (0-1)")
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

    local nameToggle = Instance.new("TextButton")
    nameToggle.Size = UDim2.new(1,-20,0,30)
    nameToggle.Position = UDim2.new(0,10,0,y)
    nameToggle.BackgroundColor3 = esp.showName and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    nameToggle.Text = esp.showName and "Nome: ON" or "Nome: OFF"
    nameToggle.TextColor3 = Color3.new(1,1,1)
    nameToggle.TextScaled = true
    nameToggle.Font = Enum.Font.Gotham
    Instance.new("UICorner", nameToggle).CornerRadius = UDim.new(0,6)
    nameToggle.Parent = f
    nameToggle.MouseButton1Click:Connect(function()
        esp.showName = not esp.showName
        nameToggle.BackgroundColor3 = esp.showName and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        nameToggle.Text = esp.showName and "Nome: ON" or "Nome: OFF"
    end)
    y = y + 40

    local distToggle = Instance.new("TextButton")
    distToggle.Size = UDim2.new(1,-20,0,30)
    distToggle.Position = UDim2.new(0,10,0,y)
    distToggle.BackgroundColor3 = esp.showDist and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    distToggle.Text = esp.showDist and "Distância: ON" or "Distância: OFF"
    distToggle.TextColor3 = Color3.new(1,1,1)
    distToggle.TextScaled = true
    distToggle.Font = Enum.Font.Gotham
    Instance.new("UICorner", distToggle).CornerRadius = UDim.new(0,6)
    distToggle.Parent = f
    distToggle.MouseButton1Click:Connect(function()
        esp.showDist = not esp.showDist
        distToggle.BackgroundColor3 = esp.showDist and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        distToggle.Text = esp.showDist and "Distância: ON" or "Distância: OFF"
    end)
    y = y + 40

    local healthToggle = Instance.new("TextButton")
    healthToggle.Size = UDim2.new(1,-20,0,30)
    healthToggle.Position = UDim2.new(0,10,0,y)
    healthToggle.BackgroundColor3 = esp.showHealth and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    healthToggle.Text = esp.showHealth and "Saúde: ON" or "Saúde: OFF"
    healthToggle.TextColor3 = Color3.new(1,1,1)
    healthToggle.TextScaled = true
    healthToggle.Font = Enum.Font.Gotham
    Instance.new("UICorner", healthToggle).CornerRadius = UDim.new(0,6)
    healthToggle.Parent = f
    healthToggle.MouseButton1Click:Connect(function()
        esp.showHealth = not esp.showHealth
        healthToggle.BackgroundColor3 = esp.showHealth and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        healthToggle.Text = esp.showHealth and "Saúde: ON" or "Saúde: OFF"
    end)
    y = y + 40

    local boxToggle = Instance.new("TextButton")
    boxToggle.Size = UDim2.new(1,-20,0,30)
    boxToggle.Position = UDim2.new(0,10,0,y)
    boxToggle.BackgroundColor3 = esp.showBox and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    boxToggle.Text = esp.showBox and "Caixa: ON" or "Caixa: OFF"
    boxToggle.TextColor3 = Color3.new(1,1,1)
    boxToggle.TextScaled = true
    boxToggle.Font = Enum.Font.Gotham
    Instance.new("UICorner", boxToggle).CornerRadius = UDim.new(0,6)
    boxToggle.Parent = f
    boxToggle.MouseButton1Click:Connect(function()
        esp.showBox = not esp.showBox
        boxToggle.BackgroundColor3 = esp.showBox and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        boxToggle.Text = esp.showBox and "Caixa: ON" or "Caixa: OFF"
    end)
    y = y + 40

    local apply = Instance.new("TextButton")
    apply.Size = UDim2.new(1,-20,0,40)
    apply.Position = UDim2.new(0,10,0,y)
    apply.BackgroundColor3 = Color3.fromRGB(0,200,0)
    apply.Text = "Aplicar"
    apply.TextColor3 = Color3.new(1,1,1)
    apply.TextScaled = true
    apply.Font = Enum.Font.Gotham
    Instance.new("UICorner", apply).CornerRadius = UDim.new(0,6)
    apply.Parent = f
    apply.MouseButton1Click:Connect(function()
        local r,g,b = corBox.Text:match("(%d+),%s*(%d+),%s*(%d+)")
        if r and g and b then
            esp.color = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        end
        local tr = tonumber(transBox.Text)
        if tr then esp.transp = math.clamp(tr,0,1) end
        f:Destroy()
        n("Configurações ESP aplicadas")
    end)
end)

btn("Visual", "Remover Neblina", Color3.fromRGB(0,150,255), function()
    Lighting.FogEnd = 1e9
    Lighting.FogStart = 1e9
    Lighting.Brightness = 2
    n("Neblina removida")
end)

btn("Visual", "Zoom Infinito", Color3.fromRGB(255,200,100), function()
    LP.CameraMaxZoomDistance = 999999
    LP.CameraMinZoomDistance = 0
    n("Zoom infinito ativado")
end)

print("Parte 3/4 carregada. Execute a parte 4 agora.")--[[
    ShinkaHub V3 (ESP Avançado) - PARTE 4/4
    Abas World e Scripts (idênticas ao V2)
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = Workspace.CurrentCamera

if not FA or not C or not farm or not collect or not aim then
    warn("Execute a parte 1 primeiro!")
    return
end

-- ============================================
-- ABA WORLD (igual ao V2)
-- ============================================
btn("World", "Fly (Ativar)", Color3.fromRGB(255,120,0), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

btn("World", "Btools", Color3.fromRGB(100,200,255), function()
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Hammer
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Clone
    Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType.Grip
    n("Ferramentas adicionadas")
end)

tog("World", "Auto Farm", Color3.fromRGB(255,100,100), "autoFarm", function(a)
    if a then
        C.autoFarm = RunService.Heartbeat:Connect(function()
            for _, g in pairs(LP.PlayerGui:GetChildren()) do
                if g:IsA("ScreenGui") then
                    for _, b in pairs(g:GetDescendants()) do
                        if b:IsA("TextButton") and b.Visible and b.Active and b.Text ~= "" then
                            b:Fire("MouseButton1Click", nil)
                            wait(farm.delay)
                        end
                    end
                end
            end
        end)
    else
        if C.autoFarm then C.autoFarm:Disconnect() C.autoFarm = nil end
    end
end)

inp("World", "Delay (seg)", "Set Delay", Color3.fromRGB(150,150,150), function(v)
    local d = tonumber(v)
    if d then farm.delay = d end
end)

tog("World", "Coletar Itens", Color3.fromRGB(0,255,100), "collectItems", function(a)
    if a then
        C.collectItems = RunService.Heartbeat:Connect(function()
            if not LP.Character then return end
            local r = LP.Character:FindFirstChild("HumanoidRootPart")
            if not r then return end
            for _, o in pairs(Workspace:GetDescendants()) do
                if o:IsA("BasePart") and o.Name:lower():find("item") and not collect.ignore[o.Name] then
                    local d = (o.Position - r.Position).Magnitude
                    if d < collect.range then
                        r.CFrame = CFrame.new(o.Position)
                        wait(0.1)
                        if o:FindFirstChild("TouchInterest") then
                            firetouchinterest(r, o, 0)
                            wait(0.1)
                            firetouchinterest(r, o, 1)
                        end
                    end
                end
            end
        end)
    else
        if C.collectItems then C.collectItems:Disconnect() C.collectItems = nil end
    end
end)

inp("World", "Alcance", "Set Alcance", Color3.fromRGB(150,150,150), function(v)
    local r = tonumber(v)
    if r then collect.range = r end
end)

tog("World", "Aimbot", Color3.fromRGB(255,0,255), "aimbot", function(a)
    if a then
        C.aimbot = RunService.RenderStepped:Connect(function()
            if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
            local close, closeD = nil, math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if aim.teamCheck and p.Team == LP.Team then continue end
                    local part = p.Character:FindFirstChild(aim.hitPart) or p.Character.HumanoidRootPart
                    local sp, on = Camera:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(sp.X, sp.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if d < closeD then
                            closeD = d
                            close = p
                        end
                    end
                end
            end
            if close then
                local tp = close.Character:FindFirstChild(aim.hitPart) or close.Character.HumanoidRootPart
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position)
            end
        end)
    else
        if C.aimbot then C.aimbot:Disconnect() C.aimbot = nil end
    end
end)

-- ============================================
-- ABA SCRIPTS (igual ao V2)
-- ============================================
inp("Scripts", "URL do script", "Executar", Color3.fromRGB(255,100,0), function(url)
    if url and url ~= "" then
        local s, e = pcall(function() loadstring(game:HttpGet(url))() end)
        if s then n("Script executado") else n("Erro", Color3.fromRGB(255,0,0)) end
    end
end)

inp("Scripts", "Nome do script", "Copiar Template", Color3.fromRGB(100,100,255), function(name)
    local template = '{"'..name..'":"https://exemplo.com/script.lua"}'
    setclipboard(template)
    n("Template copiado! Edite e cole novamente para importar.")
end)

btn("Scripts", "Importar Scripts", Color3.fromRGB(0,200,100), function()
    local s, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readclipboard()) end)
    if s and type(data) == "table" then
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0,250,0,300)
        f.Position = UDim2.new(0.5,-125,0.5,-150)
        f.BackgroundColor3 = Color3.fromRGB(30,30,40)
        f.BorderSizePixel = 2
        f.BorderColor3 = Color3.fromRGB(255,215,0)
        f.Parent = gui
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
                if ok then n("Script executado") else n("Erro", Color3.fromRGB(255,0,0)) end
                f:Destroy()
            end)
        end

        local cf = Instance.new("TextButton")
        cf.Size = UDim2.new(1,-20,0,30)
        cf.Position = UDim2.new(0,10,1,-35)
        cf.BackgroundColor3 = Color3.fromRGB(255,70,70)
        cf.Text = "Fechar"
        cf.TextColor3 = Color3.new(1,1,1)
        cf.TextScaled = true
        cf.Font = Enum.Font.Gotham
        Instance.new("UICorner", cf).CornerRadius = UDim.new(0,6)
        cf.Parent = f
        cf.MouseButton1Click:Connect(function() f:Destroy() end)
    else
        n("Nenhum script válido no clipboard", Color3.fromRGB(255,0,0))
    end
end)

btn("Scripts", "Limpar Memória", Color3.fromRGB(200,0,0), function()
    collectgarbage()
    n("Memória limpa")
end)

print("ShinkaHub V3 (ESP Avançado) carregado! Todas as 4 partes executadas.")
