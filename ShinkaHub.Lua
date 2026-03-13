-- ShinkaHub v2.5 - Parte 1 (Compacta)
_G.ShinkaHub=_G.ShinkaHub or {functionsActive={},connections={},waypoints={},espSettings={color=Color3.fromRGB(255,0,0),transparency=0.5,showDistance=true},autoFarmSettings={delay=0.5},collectSettings={range=50,ignoreList={}},aimbotSettings={teamCheck=false,hitPart="Head"},tabs={}}
local SH=_G.ShinkaHub
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local Workspace=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
local gui=Instance.new("ScreenGui")
gui.Name="ShinkaHub"
gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=LocalPlayer:WaitForChild("PlayerGui")
SH.gui=gui
local mainFrame=Instance.new("Frame")
mainFrame.Name="MainFrame"
mainFrame.Size=UDim2.new(0,320,0,480)
mainFrame.Position=UDim2.new(0.5,-160,0.5,-240)
mainFrame.BackgroundColor3=Color3.fromRGB(20,20,30)
mainFrame.BorderSizePixel=2
mainFrame.BorderColor3=Color3.fromRGB(255,215,0)
mainFrame.Active=true
mainFrame.Draggable=false
mainFrame.Parent=gui
SH.mainFrame=mainFrame
Instance.new("UICorner",mainFrame).CornerRadius=UDim.new(0,10)
local topBar=Instance.new("Frame")
topBar.Name="TopBar"
topBar.Size=UDim2.new(1,0,0,40)
topBar.BackgroundColor3=Color3.fromRGB(30,30,40)
topBar.BorderSizePixel=0
topBar.Parent=mainFrame
Instance.new("UICorner",topBar).CornerRadius=UDim.new(0,10)
local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-80,1,0)
title.Position=UDim2.new(0,10,0,0)
title.BackgroundTransparency=1
title.Text="ShinkaHub v2.5"
title.TextColor3=Color3.fromRGB(255,215,0)
title.TextScaled=true
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=topBar
local minimizeBtn=Instance.new("TextButton")
minimizeBtn.Size=UDim2.new(0,30,0,30)
minimizeBtn.Position=UDim2.new(1,-70,0,5)
minimizeBtn.BackgroundColor3=Color3.fromRGB(255,215,0)
minimizeBtn.Text="-"
minimizeBtn.TextColor3=Color3.fromRGB(20,20,30)
minimizeBtn.TextScaled=true
minimizeBtn.Font=Enum.Font.GothamBold
minimizeBtn.BorderSizePixel=0
Instance.new("UICorner",minimizeBtn).CornerRadius=UDim.new(0,6)
minimizeBtn.Parent=topBar
local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,30,0,30)
closeBtn.Position=UDim2.new(1,-35,0,5)
closeBtn.BackgroundColor3=Color3.fromRGB(255,70,70)
closeBtn.Text="X"
closeBtn.TextColor3=Color3.new(1,1,1)
closeBtn.TextScaled=true
closeBtn.Font=Enum.Font.GothamBold
closeBtn.BorderSizePixel=0
Instance.new("UICorner",closeBtn).CornerRadius=UDim.new(0,6)
closeBtn.Parent=topBar
local dragging,dragStart,startPos
topBar.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch then
  dragging=true
  dragStart=i.Position
  startPos=mainFrame.Position
  i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dragging=false end end)
 end
end)
topBar.InputChanged:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch and dragging then
  local delta=i.Position-dragStart
  mainFrame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
 end
end)
local minimizedFrame=Instance.new("Frame")
minimizedFrame.Name="MinimizedFrame"
minimizedFrame.Size=UDim2.new(0,60,0,60)
minimizedFrame.Position=UDim2.new(0,20,0,100)
minimizedFrame.BackgroundColor3=Color3.fromRGB(255,215,0)
minimizedFrame.BorderSizePixel=2
minimizedFrame.BorderColor3=Color3.fromRGB(255,255,255)
minimizedFrame.Visible=false
minimizedFrame.Parent=gui
SH.minimizedFrame=minimizedFrame
Instance.new("UICorner",minimizedFrame).CornerRadius=UDim.new(0,30)
local minIcon=Instance.new("TextLabel")
minIcon.Size=UDim2.new(1,0,1,0)
minIcon.BackgroundTransparency=1
minIcon.Text="S"
minIcon.TextColor3=Color3.fromRGB(20,20,30)
minIcon.TextScaled=true
minIcon.Font=Enum.Font.GothamBold
minIcon.Parent=minimizedFrame
local draggingMin,dragMinStart,startMinPos
minimizedFrame.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch then
  draggingMin=true
  dragMinStart=i.Position
  startMinPos=minimizedFrame.Position
  i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then draggingMin=false end end)
 end
end)
minimizedFrame.InputChanged:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch and draggingMin then
  local delta=i.Position-dragMinStart
  minimizedFrame.Position=UDim2.new(startMinPos.X.Scale,startMinPos.X.Offset+delta.X,startMinPos.Y.Scale,startMinPos.Y.Offset+delta.Y)
 end
end)
minimizeBtn.MouseButton1Click:Connect(function()
 mainFrame.Visible=false
 minimizedFrame.Visible=true
end)
minimizedFrame.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch then
  minimizedFrame.Visible=false
  mainFrame.Visible=true
 end
end)
closeBtn.MouseButton1Click:Connect(function()gui:Destroy()end)
local footer=Instance.new("TextLabel")
footer.Size=UDim2.new(1,-20,0,25)
footer.Position=UDim2.new(0,10,1,-30)
footer.BackgroundTransparency=0.5
footer.BackgroundColor3=Color3.fromRGB(30,30,40)
footer.Text="Shinka & Gemini"
footer.TextColor3=Color3.fromRGB(255,215,0)
footer.TextScaled=true
footer.Font=Enum.Font.Gotham
footer.BorderSizePixel=0
Instance.new("UICorner",footer).CornerRadius=UDim.new(0,6)
footer.Parent=mainFrame
-- Funções globais (serão definidas na parte 2)
print("Parte 1/5 carregada. Execute a parte 2 agora.")-- ShinkaHub v2.5 - Parte 2 (Compacta)
local SH=_G.ShinkaHub
if not SH or not SH.gui then warn("Execute a parte 1 primeiro") return end
_G.createTab=function(name)
 if not SH.tabButtonsFrame then
  SH.tabButtonsFrame=Instance.new("Frame")
  SH.tabButtonsFrame.Size=UDim2.new(1,-20,0,40)
  SH.tabButtonsFrame.Position=UDim2.new(0,10,0,45)
  SH.tabButtonsFrame.BackgroundTransparency=1
  SH.tabButtonsFrame.Parent=SH.mainFrame
  SH.tabContainer=Instance.new("Frame")
  SH.tabContainer.Size=UDim2.new(1,-20,1,-120)
  SH.tabContainer.Position=UDim2.new(0,10,0,90)
  SH.tabContainer.BackgroundTransparency=1
  SH.tabContainer.Parent=SH.mainFrame
  SH.tabContainer.ClipsDescendants=true
 end
 local tabButton=Instance.new("TextButton")
 tabButton.Size=UDim2.new(0,50,1,0)
 tabButton.BackgroundColor3=Color3.fromRGB(40,40,50)
 tabButton.Text=name
 tabButton.TextColor3=Color3.new(1,1,1)
 tabButton.TextScaled=true
 tabButton.Font=Enum.Font.GothamSemibold
 tabButton.BorderSizePixel=0
 Instance.new("UICorner",tabButton).CornerRadius=UDim.new(0,6)
 tabButton.Parent=SH.tabButtonsFrame
 local function resize() local s=tabButton.TextBounds.X+20 tabButton.Size=UDim2.new(0,math.max(50,s),1,0) end
 resize()
 tabButton:GetPropertyChangedSignal("TextBounds"):Connect(resize)
 local tabContent=Instance.new("ScrollingFrame")
 tabContent.Name=name.."Content"
 tabContent.Size=UDim2.new(1,0,1,0)
 tabContent.BackgroundTransparency=1
 tabContent.ScrollBarThickness=4
 tabContent.ScrollBarImageColor3=Color3.fromRGB(255,215,0)
 tabContent.AutomaticCanvasSize=Enum.AutomaticSize.Y
 tabContent.Visible=false
 tabContent.Parent=SH.tabContainer
 local layout=Instance.new("UIListLayout")
 layout.Padding=UDim.new(0,8)
 layout.HorizontalAlignment=Enum.HorizontalAlignment.Center
 layout.SortOrder=Enum.SortOrder.LayoutOrder
 layout.Parent=tabContent
 layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() tabContent.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10) end)
 SH.tabs[name]={button=tabButton,content=tabContent,layout=layout}
 tabButton.MouseButton1Click:Connect(function()
  if SH.currentTab then SH.tabs[SH.currentTab].content.Visible=false SH.tabs[SH.currentTab].button.BackgroundColor3=Color3.fromRGB(40,40,50) end
  SH.currentTab=name
  tabContent.Visible=true
  tabButton.BackgroundColor3=Color3.fromRGB(255,215,0)
 end)
end
_G.notify=function(text,color)
 color=color or Color3.fromRGB(0,200,0)
 local n=Instance.new("TextLabel")
 n.Size=UDim2.new(0,200,0,50)
 n.Position=UDim2.new(0.5,-100,0.5,-25)
 n.BackgroundColor3=color
 n.Text=text
 n.TextColor3=Color3.new(1,1,1)
 n.TextScaled=true
 n.Font=Enum.Font.GothamBold
 n.ZIndex=10
 n.Parent=SH.gui
 Instance.new("UICorner",n).CornerRadius=UDim.new(0,10)
 TweenService:Create(n,TweenInfo.new(1),{TextTransparency=1,BackgroundTransparency=1}):Play()
 wait(1)
 n:Destroy()
end
_G.createButton=function(tab,text,color,cb)
 local btn=Instance.new("TextButton")
 btn.Size=UDim2.new(1,-10,0,50)
 btn.BackgroundColor3=color
 btn.Text=text
 btn.TextColor3=Color3.new(1,1,1)
 btn.TextScaled=true
 btn.Font=Enum.Font.GothamSemibold
 btn.BorderSizePixel=2
 btn.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
 btn.Parent=SH.tabs[tab].content
 btn.MouseButton1Click:Connect(cb)
 return btn
end
_G.createInputBox=function(tab,placeholder,buttonText,color,cb)
 local frame=Instance.new("Frame")
 frame.Size=UDim2.new(1,-10,0,90)
 frame.BackgroundTransparency=1
 frame.Parent=SH.tabs[tab].content
 local box=Instance.new("TextBox")
 box.Size=UDim2.new(1,0,0,40)
 box.Position=UDim2.new(0,0,0,0)
 box.BackgroundColor3=Color3.fromRGB(50,50,60)
 box.TextColor3=Color3.new(1,1,1)
 box.PlaceholderText=placeholder
 box.PlaceholderColor3=Color3.fromRGB(180,180,180)
 box.TextScaled=true
 box.Font=Enum.Font.Gotham
 box.ClearTextOnFocus=false
 box.BorderSizePixel=2
 box.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)
 box.Parent=frame
 local btn=Instance.new("TextButton")
 btn.Size=UDim2.new(1,0,0,40)
 btn.Position=UDim2.new(0,0,1,-40)
 btn.BackgroundColor3=color
 btn.Text=buttonText
 btn.TextColor3=Color3.new(1,1,1)
 btn.TextScaled=true
 btn.Font=Enum.Font.GothamSemibold
 btn.BorderSizePixel=2
 btn.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)
 btn.Parent=frame
 btn.MouseButton1Click:Connect(function() cb(box.Text) end)
 return frame,box,btn
end
_G.createToggleButton=function(tab,text,color,varName,onToggle)
 local btn=_G.createButton(tab,text,color,function()
  SH.functionsActive[varName]=not SH.functionsActive[varName]
  if SH.functionsActive[varName] then btn.BackgroundColor3=Color3.fromRGB(255,215,0) if onToggle then onToggle(true) end
  else btn.BackgroundColor3=color if onToggle then onToggle(false) end end
 end)
 return btn
end
-- Criar abas
createTab("Home")
createTab("Local")
createTab("Teleports")
createTab("Visual")
createTab("World")
createTab("Scripts")
SH.currentTab="Home"
SH.tabs["Home"].content.Visible=true
SH.tabs["Home"].button.BackgroundColor3=Color3.fromRGB(255,215,0)
print("Parte 2/5 carregada. Execute a parte 3 agora.")-- ShinkaHub v2.5 - Parte 3 (Compacta)
local SH=_G.ShinkaHub
if not SH or not SH.gui then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
-- Home
createButton("Home","Copiar Discord",Color3.fromRGB(100,100,255),function() setclipboard("https://discord.gg/SNutmtu6x") notify("Link copiado!") end)
createButton("Home","Desativar Tudo",Color3.fromRGB(255,50,50),function()
 for k,v in pairs(SH.functionsActive) do if v then
  if k=="noclip" and SH.connections.noclip then SH.connections.noclip:Disconnect() SH.connections.noclip=nil end
  if k=="infJump" and SH.connections.infJump then SH.connections.infJump:Disconnect() SH.connections.infJump=nil end
  if k=="godMode" and SH.connections.godMode then SH.connections.godMode:Disconnect() SH.connections.godMode=nil end
  if k=="antiAFK" and SH.connections.antiAFK then SH.connections.antiAFK:Disconnect() SH.connections.antiAFK=nil end
  if k=="aimbot" and SH.connections.aimbot then SH.connections.aimbot:Disconnect() SH.connections.aimbot=nil end
  if k=="esp" then
   for _,p in pairs(Players:GetPlayers()) do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight") if h and h.Name=="ShinkaESP" then h:Destroy() end local b=p.Character:FindFirstChildOfClass("BillboardGui") if b and b.Name=="DistanceGUI" then b:Destroy() end end end
   if SH.connections.playerAdded then SH.connections.playerAdded:Disconnect() end
   if SH.connections.playerRemoving then SH.connections.playerRemoving:Disconnect() end
  end
  if k=="autoFarm" and SH.connections.autoFarm then SH.connections.autoFarm:Disconnect() SH.connections.autoFarm=nil end
  if k=="collectItems" and SH.connections.collectItems then SH.connections.collectItems:Disconnect() SH.connections.collectItems=nil end
  SH.functionsActive[k]=false
 end end
 notify("Todas as funções desativadas",Color3.fromRGB(255,100,0))
end)
-- Local
createInputBox("Local","Digite velocidade (ex: 16)","Aplicar Speed",Color3.fromRGB(0,120,255),function(v)
 local s=tonumber(v)
 if s and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=s end end
end)
createToggleButton("Local","NoClip",Color3.fromRGB(200,0,200),"noclip",function(a)
 if a then SH.connections.noclip=RunService.Stepped:Connect(function() if LocalPlayer.Character then for _,p in pairs(LocalPlayer.Character:GetChildren()) do if p:IsA("BasePart") then p.CanCollide=false end end end end)
 else if SH.connections.noclip then SH.connections.noclip:Disconnect() SH.connections.noclip=nil end end
end)
createToggleButton("Local","Infinito Jump",Color3.fromRGB(0,200,100),"infJump",function(a)
 if a then SH.connections.infJump=UserInputService.JumpRequest:Connect(function() if LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end)
 else if SH.connections.infJump then SH.connections.infJump:Disconnect() SH.connections.infJump=nil end end
end)
createToggleButton("Local","God Mode",Color3.fromRGB(255,0,0),"godMode",function(a)
 if a then SH.connections.godMode=RunService.Heartbeat:Connect(function() if LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if h and h.Health>0 then h.Health=h.MaxHealth end end end)
 else if SH.connections.godMode then SH.connections.godMode:Disconnect() SH.connections.godMode=nil end end
end)
createToggleButton("Local","Anti AFK",Color3.fromRGB(100,100,200),"antiAFK",function(a)
 if a then SH.connections.antiAFK=RunService.Stepped:Connect(function() if LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then r.Velocity=r.Velocity+Vector3.new(0.01,0,0) end end end)
 else if SH.connections.antiAFK then SH.connections.antiAFK:Disconnect() SH.connections.antiAFK=nil end end
end)
print("Parte 3/5 carregada. Execute a parte 4 agora.")-- ShinkaHub v2.5 - Parte 4 (Compacta)
local SH=_G.ShinkaHub
if not SH or not SH.gui then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
-- Teleports
createButton("Teleports","Teleport para Mouse",Color3.fromRGB(255,50,50),function()
 local t=Mouse.Hit if t and LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then r.CFrame=t end end
end)
createButton("Teleports","Teleport para Jogador",Color3.fromRGB(255,120,0),function()
 local f=Instance.new("Frame") f.Size=UDim2.new(0,200,0,300) f.Position=UDim2.new(0.5,-100,0.5,-150) f.BackgroundColor3=Color3.fromRGB(30,30,40) f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0) f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame") c.Size=UDim2.new(1,-10,1,-45) c.Position=UDim2.new(0,5,0,5) c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local l=Instance.new("UIListLayout") l.Padding=UDim.new(0,5) l.HorizontalAlignment=Enum.HorizontalAlignment.Center l.Parent=c
 for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer then
  local b=Instance.new("TextButton") b.Size=UDim2.new(1,-10,0,40) b.BackgroundColor3=Color3.fromRGB(50,50,60) b.Text=p.Name b.TextColor3=Color3.new(1,1,1) b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) b.Parent=c
  b.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
   LocalPlayer.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0) f:Destroy() end end)
 end end
 local cf=Instance.new("TextButton") cf.Size=UDim2.new(1,-20,0,30) cf.Position=UDim2.new(0,10,1,-35) cf.BackgroundColor3=Color3.fromRGB(255,70,70) cf.Text="Fechar" cf.TextColor3=Color3.new(1,1,1) cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6) cf.Parent=f cf.MouseButton1Click:Connect(function() f:Destroy() end)
end)
createInputBox("Teleports","Nome do waypoint","Salvar Posição",Color3.fromRGB(0,200,0),function(n)
 if n~="" and LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if r then table.insert(SH.waypoints,{name=n,cframe=r.CFrame}) notify("Waypoint '"..n.."' salvo!") end end
end)
createButton("Teleports","Teleport para Waypoint",Color3.fromRGB(255,200,0),function()
 if #SH.waypoints==0 then notify("Nenhum waypoint salvo",Color3.fromRGB(255,0,0)) return end
 local f=Instance.new("Frame") f.Size=UDim2.new(0,200,0,300) f.Position=UDim2.new(0.5,-100,0.5,-150) f.BackgroundColor3=Color3.fromRGB(30,30,40) f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0) f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame") c.Size=UDim2.new(1,-10,1,-45) c.Position=UDim2.new(0,5,0,5) c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local l=Instance.new("UIListLayout") l.Padding=UDim.new(0,5) l.Parent=c
 for i,wp in ipairs(SH.waypoints) do
  local b=Instance.new("TextButton") b.Size=UDim2.new(1,-10,0,40) b.BackgroundColor3=Color3.fromRGB(50,50,60) b.Text=wp.name b.TextColor3=Color3.new(1,1,1) b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) b.Parent=c
  b.MouseButton1Click:Connect(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame=wp.cframe f:Destroy() end end)
 end
 local cf=Instance.new("TextButton") cf.Size=UDim2.new(1,-20,0,30) cf.Position=UDim2.new(0,10,1,-35) cf.BackgroundColor3=Color3.fromRGB(255,70,70) cf.Text="Fechar" cf.TextColor3=Color3.new(1,1,1) cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6) cf.Parent=f cf.MouseButton1Click:Connect(function() f:Destroy() end)
end)
-- Visual
createToggleButton("Visual","ESP",Color3.fromRGB(255,255,0),"esp",function(a)
 if a then
  local function ad(p)
   if p==LocalPlayer then return end
   local function ap(c)
    local h=Instance.new("Highlight") h.Name="ShinkaESP" h.FillColor=SH.espSettings.color h.OutlineColor=Color3.fromRGB(255,255,255) h.FillTransparency=SH.espSettings.transparency h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Parent=c
    if SH.espSettings.showDistance then
     local b=Instance.new("BillboardGui") b.Name="DistanceGUI" b.Size=UDim2.new(0,100,0,30) b.StudsOffset=Vector3.new(0,3,0) b.AlwaysOnTop=true
     local t=Instance.new("TextLabel") t.Size=UDim2.new(1,0,1,0) t.BackgroundTransparency=1 t.TextColor3=Color3.new(1,1,1) t.TextStrokeTransparency=0 t.Text="??m" t.TextScaled=true t.Font=Enum.Font.GothamBold t.Parent=b
     b.Parent=c
     local conn
     conn=RunService.RenderStepped:Connect(function() if c and c:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then t.Text=math.floor((c.HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m" else conn:Disconnect() end end)
    end
   end
   if p.Character then ap(p.Character) end
   p.CharacterAdded:Connect(ap)
  end
  for _,p in pairs(Players:GetPlayers()) do ad(p) end
  SH.connections.playerAdded=Players.PlayerAdded:Connect(ad)
  SH.connections.playerRemoving=Players.PlayerRemoving:Connect(function(p) if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight") if h and h.Name=="ShinkaESP" then h:Destroy() end local b=p.Character:FindFirstChildOfClass("BillboardGui") if b and b.Name=="DistanceGUI" then b:Destroy() end end end)
 else
  for _,p in pairs(Players:GetPlayers()) do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight") if h and h.Name=="ShinkaESP" then h:Destroy() end local b=p.Character:FindFirstChildOfClass("BillboardGui") if b and b.Name=="DistanceGUI" then b:Destroy() end end end
  if SH.connections.playerAdded then SH.connections.playerAdded:Disconnect() end
  if SH.connections.playerRemoving then SH.connections.playerRemoving:Disconnect() end
 end
end)
createButton("Visual","Configurar ESP",Color3.fromRGB(150,150,150),function()
 local f=Instance.new("Frame") f.Size=UDim2.new(0,250,0,200) f.Position=UDim2.new(0.5,-125,0.5,-100) f.BackgroundColor3=Color3.fromRGB(30,30,40) f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0) f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local y=10
 local function lbl(t) local l=Instance.new("TextLabel") l.Size=UDim2.new(1,-20,0,25) l.Position=UDim2.new(0,10,0,y) l.BackgroundTransparency=1 l.Text=t l.TextColor3=Color3.new(1,1,1) l.TextScaled=true l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f y=y+30 end
 lbl("Cor (R,G,B) exemplo: 255,0,0")
 local c=Instance.new("TextBox") c.Size=UDim2.new(1,-20,0,30) c.Position=UDim2.new(0,10,0,y) c.BackgroundColor3=Color3.fromRGB(50,50,60) c.TextColor3=Color3.new(1,1,1) c.PlaceholderText="255,0,0" c.TextScaled=true c.Font=Enum.Font.Gotham Instance.new("UICorner",c).CornerRadius=UDim.new(0,6) c.Parent=f y=y+40
 lbl("Transparência (0-1)")
 local t=Instance.new("TextBox") t.Size=UDim2.new(1,-20,0,30) t.Position=UDim2.new(0,10,0,y) t.BackgroundColor3=Color3.fromRGB(50,50,60) t.TextColor3=Color3.new(1,1,1) t.PlaceholderText="0.5" t.TextScaled=true t.Font=Enum.Font.Gotham Instance.new("UICorner",t).CornerRadius=UDim.new(0,6) t.Parent=f y=y+40
 local dt=Instance.new("TextButton") dt.Size=UDim2.new(1,-20,0,30) dt.Position=UDim2.new(0,10,0,y) dt.BackgroundColor3=SH.espSettings.showDistance and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0) dt.Text=SH.espSettings.showDistance and "Distância: ON" or "Distância: OFF" dt.TextColor3=Color3.new(1,1,1) dt.TextScaled=true dt.Font=Enum.Font.Gotham Instance.new("UICorner",dt).CornerRadius=UDim.new(0,6) dt.Parent=f
 dt.MouseButton1Click:Connect(function() SH.espSettings.showDistance=not SH.espSettings.showDistance dt.BackgroundColor3=SH.espSettings.showDistance and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0) dt.Text=SH.espSettings.showDistance and "Distância: ON" or "Distância: OFF" end)
 y=y+40
 local a=Instance.new("TextButton") a.Size=UDim2.new(1,-20,0,40) a.Position=UDim2.new(0,10,0,y) a.BackgroundColor3=Color3.fromRGB(0,200,0) a.Text="Aplicar" a.TextColor3=Color3.new(1,1,1) a.TextScaled=true a.Font=Enum.Font.Gotham Instance.new("UICorner",a).CornerRadius=UDim.new(0,6) a.Parent=f
 a.MouseButton1Click:Connect(function()
  local r,g,b=c.Text:match("(%d+),%s*(%d+),%s*(%d+)") if r and g and b then SH.espSettings.color=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b)) end
  local tr=tonumber(t.Text) if tr then SH.espSettings.transparency=math.clamp(tr,0,1) end
  if SH.functionsActive.esp then
   for _,p in pairs(Players:GetPlayers()) do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight") if h and h.Name=="ShinkaESP" then h:Destroy() end local b=p.Character:FindFirstChildOfClass("BillboardGui") if b and b.Name=="DistanceGUI" then b:Destroy() end end end
   local function ad(p) if p==LocalPlayer then return end
    local function ap(c)
     local h=Instance.new("Highlight") h.Name="ShinkaESP" h.FillColor=SH.espSettings.color h.OutlineColor=Color3.fromRGB(255,255,255) h.FillTransparency=SH.espSettings.transparency h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Parent=c
     if SH.espSettings.showDistance then
      local b=Instance.new("BillboardGui") b.Name="DistanceGUI" b.Size=UDim2.new(0,100,0,30) b.StudsOffset=Vector3.new(0,3,0) b.AlwaysOnTop=true
      local t=Instance.new("TextLabel") t.Size=UDim2.new(1,0,1,0) t.BackgroundTransparency=1 t.TextColor3=Color3.new(1,1,1) t.TextStrokeTransparency=0 t.Text="??m" t.TextScaled=true t.Font=Enum.Font.GothamBold t.Parent=b
      b.Parent=c
      local conn
      conn=RunService.RenderStepped:Connect(function() if c and c:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then t.Text=math.floor((c.HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m" else conn:Disconnect() end end)
     end
    end
    if p.Character then ap(p.Character) end
    p.CharacterAdded:Connect(ap)
   end
   for _,p in pairs(Players:GetPlayers()) do ad(p) end
  end
  f:Destroy() notify("Configurações ESP aplicadas")
 end)
end)
createButton("Visual","Remover Neblina",Color3.fromRGB(0,150,255),function() Lighting.FogEnd=1e9 Lighting.FogStart=1e9 Lighting.Brightness=2 notify("Neblina removida") end)
createButton("Visual","Zoom Infinito",Color3.fromRGB(255,200,100),function() LocalPlayer.CameraMaxZoomDistance=999999 LocalPlayer.CameraMinZoomDistance=0 notify("Zoom infinito ativado") end)
print("Parte 4/5 carregada. Execute a parte 5 agora.")-- ShinkaHub v2.5 - Parte 5 (Compacta)
local SH=_G.ShinkaHub
if not SH or not SH.gui then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
-- World
createButton("World","Fly (Ativar)",Color3.fromRGB(255,120,0),function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end)
createButton("World","Btools (Construir)",Color3.fromRGB(100,200,255),function()
 local h=Instance.new("HopperBin") h.BinType=Enum.BinType.Hammer h.Parent=LocalPlayer.Backpack
 local c=Instance.new("HopperBin") c.BinType=Enum.BinType.Clone c.Parent=LocalPlayer.Backpack
 local g=Instance.new("HopperBin") g.BinType=Enum.BinType.Grip g.Parent=LocalPlayer.Backpack
 notify("Ferramentas adicionadas")
end)
createToggleButton("World","Auto Farm (Botões)",Color3.fromRGB(255,100,100),"autoFarm",function(a)
 if a then SH.connections.autoFarm=RunService.Heartbeat:Connect(function()
  for _,g in pairs(LocalPlayer.PlayerGui:GetChildren()) do if g:IsA("ScreenGui") then
   for _,b in pairs(g:GetDescendants()) do if b:IsA("TextButton") and b.Visible and b.Active and b.Text~="" then b:Fire("MouseButton1Click",nil) wait(SH.autoFarmSettings.delay) end end
  end end)
 else if SH.connections.autoFarm then SH.connections.autoFarm:Disconnect() SH.connections.autoFarm=nil end end
end)
createInputBox("World","Delay (segundos)","Set Delay",Color3.fromRGB(150,150,150),function(v) local d=tonumber(v) if d then SH.autoFarmSettings.delay=d end end)
createToggleButton("World","Coletar Itens",Color3.fromRGB(0,255,100),"collectItems",function(a)
 if a then SH.connections.collectItems=RunService.Heartbeat:Connect(function()
  if not LocalPlayer.Character then return end local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if not r then return end
  for _,o in pairs(Workspace:GetDescendants()) do if o:IsA("BasePart") and o.Name:lower():find("item") and not SH.collectSettings.ignoreList[o.Name] then
   local d=(o.Position-r.Position).Magnitude if d<SH.collectSettings.range then r.CFrame=CFrame.new(o.Position) wait(0.1) if o:FindFirstChild("TouchInterest") then firetouchinterest(r,o,0) wait(0.1) firetouchinterest(r,o,1) end end
  end end)
 else if SH.connections.collectItems then SH.connections.collectItems:Disconnect() SH.connections.collectItems=nil end end
end)
createInputBox("World","Alcance (ex: 50)","Set Alcance",Color3.fromRGB(150,150,150),function(v) local r=tonumber(v) if r then SH.collectSettings.range=r end end)
createToggleButton("World","Aimbot (Simples)",Color3.fromRGB(255,0,255),"aimbot",function(a)
 if a then SH.connections.aimbot=RunService.RenderStepped:Connect(function()
  if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
  local closest,closestDist=nil,math.huge
  for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
   if SH.aimbotSettings.teamCheck and p.Team==LocalPlayer.Team then continue end
   local part=p.Character:FindFirstChild(SH.aimbotSettings.hitPart) or p.Character.HumanoidRootPart
   local sp,on=Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
   if on then local d=(Vector2.new(sp.X,sp.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude if d<closestDist then closestDist=d closest=p end end
  end end
  if closest then local tp=closest.Character:FindFirstChild(SH.aimbotSettings.hitPart) or closest.Character.HumanoidRootPart Workspace.CurrentCamera.CFrame=CFrame.new(Workspace.CurrentCamera.CFrame.Position,tp.Position) end
 end)
 else if SH.connections.aimbot then SH.connections.aimbot:Disconnect() SH.connections.aimbot=nil end end
end)
-- Scripts
createInputBox("Scripts","URL do script","Executar",Color3.fromRGB(255,100,0),function(u)
 if u and u~="" then local s,e=pcall(function() loadstring(game:HttpGet(u))() end) if s then notify("Script executado") else notify("Erro ao executar",Color3.fromRGB(255,0,0)) end end
end)
createInputBox("Scripts","Nome do script","Copiar Template",Color3.fromRGB(100,100,255),function(n)
 setclipboard('{"'..n..'":"https://exemplo.com/script.lua"}') notify("Template copiado! Edite e cole novamente para importar.")
end)
createButton("Scripts","Importar Scripts",Color3.fromRGB(0,200,100),function()
 local s,d=pcall(function() return game:GetService("HttpService"):JSONDecode(readclipboard()) end)
 if s and type(d)=="table" then
  local f=Instance.new("Frame") f.Size=UDim2.new(0,250,0,300) f.Position=UDim2.new(0.5,-125,0.5,-150) f.BackgroundColor3=Color3.fromRGB(30,30,40) f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0) f.Parent=SH.gui
  Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
  local c=Instance.new("ScrollingFrame") c.Size=UDim2.new(1,-10,1,-45) c.Position=UDim2.new(0,5,0,5) c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
  local l=Instance.new("UIListLayout") l.Padding=UDim.new(0,5) l.Parent=c
  for nome,url in pairs(d) do
   local b=Instance.new("TextButton") b.Size=UDim2.new(1,-10,0,40) b.BackgroundColor3=Color3.fromRGB(50,50,60) b.Text=nome b.TextColor3=Color3.new(1,1,1) b.TextScaled=true b.Font=Enum.Font.Gotham
   Instance.new("UICorner",b).CornerRadius=UDim.new(0,6) b.Parent=c
   b.MouseButton1Click:Connect(function() local s,e=pcall(function() loadstring(game:HttpGet(url))() end) if s then notify("Script executado") else notify("Erro",Color3.fromRGB(255,0,0)) end f:Destroy() end)
  end
  local cf=Instance.new("TextButton") cf.Size=UDim2.new(1,-20,0,30) cf.Position=UDim2.new(0,10,1,-35) cf.BackgroundColor3=Color3.fromRGB(255,70,70) cf.Text="Fechar" cf.TextColor3=Color3.new(1,1,1) cf.TextScaled=true cf.Font=Enum.Font.Gotham
  Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6) cf.Parent=f cf.MouseButton1Click:Connect(function() f:Destroy() end)
 else notify("Nenhum script válido no clipboard",Color3.fromRGB(255,0,0)) end
end)
createButton("Scripts","Limpar Memória",Color3.fromRGB(200,0,0),function() collectgarbage() notify("Memória limpa") end)
print("ShinkaHub v2.5 carregado completamente! Todas as 5 partes executadas.")
