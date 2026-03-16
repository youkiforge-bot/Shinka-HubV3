--[[
    ShinkaHub v3 - Script Universal para Roblox
    Cria uma interface arrastável, minimizável, com link do Discord.
    Estrutura preparada para adicionar novas funcionalidades/abas facilmente.
    Compatível com qualquer mapa/jogo (cria a GUI em tempo de execução).
--]]

-- Impede múltiplas execuções do hub (proteção simples)
if _G.ShinkaHubLoaded then
    warn("ShinkaHub já está carregado!")
    return
end
_G.ShinkaHubLoaded = true

-- Serviços necessários
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui") -- Para criar GUI protegida (se possível)

-- Player local (para referência)
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Variáveis de configuração
local HubName = "ShinkaHub v3"
local DiscordLink = "https://discord.gg/seulink"  -- Substitua pelo seu convite
local CurrentVersion = "3.0.0"

-- Criar ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = HubName:gsub("%s+", "_") -- Remove espaços para nome seguro
ScreenGui.Parent = CoreGui  -- Tenta colocar no CoreGui (protegido), se falhar vai para o PlayerGui
ScreenGui.ResetOnSpawn = false

-- Fallback para PlayerGui se CoreGui não for permitido (em alguns jogos)
local success, err = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Frame principal (janela)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)  -- Tamanho inicial
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)  -- Centralizado
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = false  -- Controle manual para arrastar
MainFrame.Parent = ScreenGui

-- Estilo (sombras, bordas arredondadas)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Barra de título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 8)
TitleBarCorner.Parent = TitleBar

-- Texto do título
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -70, 1, 0)  -- Espaço para botões à direita
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = HubName
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamSemibold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Botão Discord (ícone, mas usaremos texto simples)
local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "DiscordButton"
DiscordButton.Size = UDim2.new(0, 30, 0, 30)
DiscordButton.Position = UDim2.new(1, -70, 0, 0)
DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)  -- Cor do Discord
DiscordButton.Text = "D"  -- Simples, pode substituir por ícone (usando TextLabel com símbolo)
DiscordButton.TextColor3 = Color3.new(1, 1, 1)
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextSize = 18
DiscordButton.BorderSizePixel = 0
DiscordButton.Parent = TitleBar

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordButton

-- Botão minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -35, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinimizeButton.Text = "–"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- (Opcional) Botão fechar - não incluso para simplificar, mas pode adicionar depois

-- Container para o conteúdo principal (onde futuras abas/widgets serão inseridos)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "Content"
ContentContainer.Size = UDim2.new(1, -20, 1, -50)  -- Margens
ContentContainer.Position = UDim2.new(0, 10, 0, 40)
ContentContainer.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
ContentContainer.BorderSizePixel = 0
ContentContainer.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentContainer

-- Exemplo de conteúdo: um texto de boas-vindas e um espaço para notícias
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -20, 0, 30)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 10)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Bem-vindo ao " .. HubName .. "!"
WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
WelcomeLabel.Font = Enum.Font.Gotham
WelcomeLabel.TextSize = 16
WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
WelcomeLabel.Parent = ContentContainer

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, -20, 0, 20)
VersionLabel.Position = UDim2.new(0, 10, 0, 45)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "Versão: " .. CurrentVersion
VersionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 14
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Parent = ContentContainer

local NewsLabel = Instance.new("TextLabel")
NewsLabel.Size = UDim2.new(1, -20, 1, -80)
NewsLabel.Position = UDim2.new(0, 10, 0, 75)
NewsLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
NewsLabel.BackgroundTransparency = 0.5
NewsLabel.Text = "Novidades em breve...\nDiscord: " .. DiscordLink
NewsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
NewsLabel.Font = Enum.Font.Gotham
NewsLabel.TextSize = 14
NewsLabel.TextWrapped = true
NewsLabel.TextXAlignment = Enum.TextXAlignment.Left
NewsLabel.TextYAlignment = Enum.TextYAlignment.Top
NewsLabel.Parent = ContentContainer

local NewsCorner = Instance.new("UICorner")
NewsCorner.CornerRadius = UDim.new(0, 6)
NewsCorner.Parent = NewsLabel

-- === FUNCIONALIDADES === --

-- Variáveis de estado
local isMinimized = false
local minimizedSize = UDim2.new(0, 400, 0, 30)  -- Só a barra de título
local normalSize = MainFrame.Size
local dragging = false
local dragInput, dragStart, startPos

-- Função para arrastar a janela (ativa apenas quando não minimizado)
local function updateDrag(input)
    if not dragging then return end
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

-- Conectar eventos de mouse na barra de título
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Botão minimizar
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and minimizedSize or normalSize
    -- Animação suave com Tween
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(MainFrame, tweenInfo, {Size = targetSize})
    tween:Play()
    
    -- Esconder conteúdo quando minimizado
    ContentContainer.Visible = not isMinimized
    -- Alterar texto do botão
    MinimizeButton.Text = isMinimized and "□" or "–"
end)

-- Botão Discord
DiscordButton.MouseButton1Click:Connect(function()
    -- Tentar copiar link para área de transferência (se o executor suportar)
    local success, err = pcall(function()
        setclipboard(DiscordLink)  -- Função comum em executors
    end)
    if success then
        -- Feedback visual temporário
        local oldText = DiscordButton.Text
        DiscordButton.Text = "✓"
        DiscordButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        wait(1)
        DiscordButton.Text = oldText
        DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    else
        -- Se não conseguir copiar, exibe o link na tela (notificação)
        warn("Copie manualmente: " .. DiscordLink)
        -- Pode criar um popup simples (exemplo)
        local notification = Instance.new("TextLabel")
        notification.Size = UDim2.new(0, 300, 0, 50)
        notification.Position = UDim2.new(0.5, -150, 0.5, -25)
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BackgroundTransparency = 0.5
        notification.Text = "Link copiado para o clipboard?"  # improviso
        notification.TextColor3 = Color3.new(1,1,1)
        notification.Font = Enum.Font.Gotham
        notification.TextSize = 16
        notification.Parent = ScreenGui
        game:GetService("Debris"):AddItem(notification, 2)  -- Remove após 2 segundos
    end
end)

-- === SISTEMA DE ATUALIZAÇÕES FUTURAS (exemplo com verificação online) === --

-- Função para verificar atualizações (a ser implementada quando tiver um servidor)
-- Aqui está um esqueleto; você pode descomentar e configurar quando tiver um link raw
--[[
local function checkForUpdates()
    local url = "https://raw.githubusercontent.com/seuusuario/shinkahub/main/version.txt"
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local latestVersion = result:gsub("%s+", "")  -- Remove espaços
        if latestVersion ~= CurrentVersion then
            -- Notificar usuário sobre nova versão
            local updateMsg = Instance.new("TextLabel")
            updateMsg.Size = UDim2.new(1, -20, 0, 30)
            updateMsg.Position = UDim2.new(0, 10, 0, 200)
            updateMsg.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            updateMsg.BackgroundTransparency = 0.5
            updateMsg.Text = "Nova versão disponível: " .. latestVersion
            updateMsg.TextColor3 = Color3.new(1,1,1)
            updateMsg.Font = Enum.Font.GothamBold
            updateMsg.TextSize = 14
            updateMsg.Parent = ContentContainer
            game:GetService("Debris"):AddItem(updateMsg, 5)
        end
    end
end

-- Chamar a verificação após alguns segundos (dá tempo para a GUI carregar)
spawn(function()
    wait(3)
    checkForUpdates()
end)
--]]

-- Instruções para adicionar novas abas/funcionalidades:
-- 1. Crie um novo Frame dentro de ContentContainer para cada aba.
-- 2. Use botões no título para alternar entre abas (opcional).
-- 3. Mantenha o código modular.

print("ShinkaHub v3 carregado com sucesso! Versão: " .. CurrentVersion)
