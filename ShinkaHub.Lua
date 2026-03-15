-- Shinka Hub V2.5 Avançado (Versão Única para Mobile)
local Players=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local WS=game:GetService("Workspace")
local LG=game:GetService("Lighting")
local LP=Players.LocalPlayer
local M=LP:GetMouse()
local Cam=WS.CurrentCamera
local FA={noclip=false,infJump=false,godMode=false,antiAFK=false,esp=false,autoFarm=false,collectItems=false,aimbot=false}
local C={}
local WP={}
local esp={color=Color3.fromRGB(255,0,0),transp=0.5,dist=true,box=false,line=false,name=true,health=false}
local farm={delay=0.5}
local col={range=50,ign={}}
local aim={team=false,hit="Head"}
local gui=Instance.new("ScreenGui")
gui.Name="ShinkaHub"
gui.ResetOnSpawn=false
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=LP:WaitForChild("PlayerGui")
local main=Instance.new("Frame")
main.Size=UDim2.new(0,320,0,480)
main.Position=UDim2.new(0.5,-160,0.5,-240)
main.BackgroundColor3=Color3.fromRGB(20,20,30)
main.BorderSizePixel=2
main.BorderColor3=Color3.fromRGB(255,215,0)
main.Active=true
main.Draggable=false
main.Parent=gui
Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
local top=Instance.new("Frame")
top.Size=UDim2.new(1,0,0,40)
top.BackgroundColor3=Color3.fromRGB(30,30,40)
top.BorderSizePixel=0
top.Parent=main
Instance.new("UICorner",top).CornerRadius=UDim.new(0,10)
local logo=Instance.new("ImageLabel")
logo.Size=UDim2.new(0,30,0,30)
logo.Position=UDim2.new(0,5,0.5,-15)
logo.BackgroundTransparency=1
logo.Image="rbxassetid://78760319620441"
logo.Parent=top
local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-110,1,0)
title.Position=UDim2.new(0,40,0,0)
title.BackgroundTransparency=1
title.Text="Shinka Hub"
title.TextColor3=Color3.fromRGB(255,215,0)
title.TextScaled=true
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left
title.Parent=top
local min=Instance.new("TextButton")
min.Size=UDim2.new(0,30,0,30)
min.Position=UDim2.new(1,-70,0,5)
min.BackgroundColor3=Color3.fromRGB(255,215,0)
min.Text="-"
min.TextColor3=Color3.fromRGB(20,20,30)
min.TextScaled=true
min.Font=Enum.Font.GothamBold
min.BorderSizePixel=0
Instance.new("UICorner",min).CornerRadius=UDim.new(0,6)
min.Parent=top
local cls=Instance.new("TextButton")
cls.Size=UDim2.new(0,30,0,30)
cls.Position=UDim2.new(1,-35,0,5)
cls.BackgroundColor3=Color3.fromRGB(255,70,70)
cls.Text="X"
cls.TextColor3=Color3.new(1,1,1)
cls.TextScaled=true
cls.Font=Enum.Font.GothamBold
cls.BorderSizePixel=0
Instance.new("UICorner",cls).CornerRadius=UDim.new(0,6)
cls.Parent=top
local drag,ds,sp
top.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch then
  drag=true
  ds=i.Position
  sp=main.Position
  i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then drag=false end end)
 end
end)
top.InputChanged:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch and drag then
  local d=i.Position-ds
  main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
 end
end)
local mini=Instance.new("Frame")
mini.Size=UDim2.new(0,60,0,60)
mini.Position=UDim2.new(0,20,0,100)
mini.BackgroundColor3=Color3.fromRGB(255,215,0)
mini.BorderSizePixel=2
mini.BorderColor3=Color3.fromRGB(255,255,255)
mini.Visible=false
mini.Parent=gui
Instance.new("UICorner",mini).CornerRadius=UDim.new(0,30)
local ic=Instance.new("TextLabel")
ic.Size=UDim2.new(1,0,1,0)
ic.BackgroundTransparency=1
ic.Text="S"
ic.TextColor3=Color3.fromRGB(20,20,30)
ic.TextScaled=true
ic.Font=Enum.Font.GothamBold
ic.Parent=mini
local dM,dMs,spM
mini.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch then
  dM=true
  dMs=i.Position
  spM=mini.Position
  i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dM=false end end)
 end
end)
mini.InputChanged:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.Touch and dM then
  local d=i.Position-dMs
  mini.Position=UDim2.new(spM.X.Scale,spM.X.Offset+d.X,spM.Y.Scale,spM.Y.Offset+d.Y)
 end
end)
min.MouseButton1Click:Connect(function()main.Visible=false mini.Visible=true end)
mini.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch then mini.Visible=false main.Visible=true end end)
cls.MouseButton1Click:Connect(function()gui:Destroy()end)
local rod=Instance.new("TextLabel")
rod.Size=UDim2.new(1,-20,0,25)
rod.Position=UDim2.new(0,10,1,-30)
rod.BackgroundTransparency=0.5
rod.BackgroundColor3=Color3.fromRGB(30,30,40)
rod.Text="Shinka & Gemini"
rod.TextColor3=Color3.fromRGB(255,215,0)
rod.TextScaled=true
rod.Font=Enum.Font.Gotham
rod.BorderSizePixel=0
Instance.new("UICorner",rod).CornerRadius=UDim.new(0,6)
rod.Parent=main
local tabF=Instance.new("Frame")
tabF.Size=UDim2.new(1,-20,0,40)
tabF.Position=UDim2.new(0,10,0,45)
tabF.BackgroundTransparency=1
tabF.Parent=main
local tabC=Instance.new("Frame")
tabC.Size=UDim2.new(1,-20,1,-120)
tabC.Position=UDim2.new(0,10,0,90)
tabC.BackgroundTransparency=1
tabC.Parent=main
tabC.ClipsDescendants=true
local tabs={}
local curTab
local function crTab(name)
 local bt=Instance.new("TextButton")
 bt.Size=UDim2.new(0,50,1,0)
 bt.BackgroundColor3=Color3.fromRGB(40,40,50)
 bt.Text=name
 bt.TextColor3=Color3.new(1,1,1)
 bt.TextScaled=true
 bt.Font=Enum.Font.GothamSemibold
 bt.BorderSizePixel=0
 Instance.new("UICorner",bt).CornerRadius=UDim.new(0,6)
 bt.Parent=tabF
 local function rs()local s=bt.TextBounds.X+20 bt.Size=UDim2.new(0,math.max(50,s),1,0)end
 rs()
 bt:GetPropertyChangedSignal("TextBounds"):Connect(rs)
 local c=Instance.new("ScrollingFrame")
 c.Name=name.."Content"
 c.Size=UDim2.new(1,0,1,0)
 c.BackgroundTransparency=1
 c.ScrollBarThickness=4
 c.ScrollBarImageColor3=Color3.fromRGB(255,215,0)
 c.AutomaticCanvasSize=Enum.AutomaticSize.Y
 c.Visible=false
 c.Parent=tabC
 local lay=Instance.new("UIListLayout")
 lay.Padding=UDim.new(0,8)
 lay.HorizontalAlignment=Enum.HorizontalAlignment.Center
 lay.SortOrder=Enum.SortOrder.LayoutOrder
 lay.Parent=c
 lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()c.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+10)end)
 tabs[name]={button=bt,content=c,layout=lay}
 bt.MouseButton1Click:Connect(function()
  if curTab then tabs[curTab].content.Visible=false tabs[curTab].button.BackgroundColor3=Color3.fromRGB(40,40,50)end
  curTab=name
  c.Visible=true
  bt.BackgroundColor3=Color3.fromRGB(255,215,0)
 end)
end
crTab("Home")
crTab("Local")
crTab("Teleports")
crTab("Visual")
crTab("World")
crTab("Scripts")
curTab="Home"
tabs["Home"].content.Visible=true
tabs["Home"].button.BackgroundColor3=Color3.fromRGB(255,215,0)
local function n(t,c)
 c=c or Color3.fromRGB(0,200,0)
 local n=Instance.new("TextLabel")
 n.Size=UDim2.new(0,200,0,50)
 n.Position=UDim2.new(0.5,-100,0.5,-25)
 n.BackgroundColor3=c
 n.Text=t
 n.TextColor3=Color3.new(1,1,1)
 n.TextScaled=true
 n.Font=Enum.Font.GothamBold
 n.ZIndex=10
 n.Parent=gui
 Instance.new("UICorner",n).CornerRadius=UDim.new(0,10)
 TS:Create(n,TweenInfo.new(1),{TextTransparency=1,BackgroundTransparency=1}):Play()
 wait(1)
 n:Destroy()
end
local function btn(tab,txt,col,cb)
 local b=Instance.new("TextButton")
 b.Size=UDim2.new(1,-10,0,50)
 b.BackgroundColor3=col
 b.Text=txt
 b.TextColor3=Color3.new(1,1,1)
 b.TextScaled=true
 b.Font=Enum.Font.GothamSemibold
 b.BorderSizePixel=2
 b.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
 b.Parent=tabs[tab].content
 b.MouseButton1Click:Connect(cb)
 return b
end
local function inp(tab,ph,bt,col,cb)
 local f=Instance.new("Frame")
 f.Size=UDim2.new(1,-10,0,90)
 f.BackgroundTransparency=1
 f.Parent=tabs[tab].content
 local box=Instance.new("TextBox")
 box.Size=UDim2.new(1,0,0,40)
 box.Position=UDim2.new(0,0,0,0)
 box.BackgroundColor3=Color3.fromRGB(50,50,60)
 box.TextColor3=Color3.new(1,1,1)
 box.PlaceholderText=ph
 box.PlaceholderColor3=Color3.fromRGB(180,180,180)
 box.TextScaled=true
 box.Font=Enum.Font.Gotham
 box.ClearTextOnFocus=false
 box.BorderSizePixel=2
 box.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)
 box.Parent=f
 local b=Instance.new("TextButton")
 b.Size=UDim2.new(1,0,0,40)
 b.Position=UDim2.new(0,0,1,-40)
 b.BackgroundColor3=col
 b.Text=bt
 b.TextColor3=Color3.new(1,1,1)
 b.TextScaled=true
 b.Font=Enum.Font.GothamSemibold
 b.BorderSizePixel=2
 b.BorderColor3=Color3.fromRGB(0,0,0)
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
 b.Parent=f
 b.MouseButton1Click:Connect(function()cb(box.Text)end)
 return f,box,b
end
local function tog(tab,txt,col,name,on)
 local b=btn(tab,txt,col,function()
  FA[name]=not FA[name]
  if FA[name]then b.BackgroundColor3=Color3.fromRGB(255,215,0)if on then on(true)end else b.BackgroundColor3=col if on then on(false)end end
 end)
 return b
end
-- Home
btn("Home","Copiar Discord",Color3.fromRGB(100,100,255),function()setclipboard("https://discord.gg/SNutmtu6x")n("Link copiado!")end)
btn("Home","Desativar Tudo",Color3.fromRGB(255,50,50),function()
 for k,v in pairs(FA)do if v then
  if k=="noclip"and C.noclip then C.noclip:Disconnect()C.noclip=nil end
  if k=="infJump"and C.infJump then C.infJump:Disconnect()C.infJump=nil end
  if k=="godMode"and C.godMode then C.godMode:Disconnect()C.godMode=nil end
  if k=="antiAFK"and C.antiAFK then C.antiAFK:Disconnect()C.antiAFK=nil end
  if k=="aimbot"and C.aimbot then C.aimbot:Disconnect()C.aimbot=nil end
  if k=="esp"then
   for _,p in pairs(Players:GetPlayers())do if p.Character then
    local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end
    for _,v in pairs(p.Character:GetChildren())do if v:IsA("BillboardGui")and v.Name:find("Shinka")then v:Destroy()end end
   end end
   if C.playerAdded then C.playerAdded:Disconnect()end if C.playerRemoving then C.playerRemoving:Disconnect()end
  end
  if k=="autoFarm"and C.autoFarm then C.autoFarm:Disconnect()C.autoFarm=nil end
  if k=="collectItems"and C.collectItems then C.collectItems:Disconnect()C.collectItems=nil end
  FA[k]=false
 end end n("Todas as funções desativadas",Color3.fromRGB(255,100,0))
end)
-- Local
inp("Local","Velocidade (ex:16)","Aplicar Speed",Color3.fromRGB(0,120,255),function(v)local s=tonumber(v)if s and LP.Character then local h=LP.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=s end end end)
tog("Local","NoClip",Color3.fromRGB(200,0,200),"noclip",function(a)if a then C.noclip=RS.Stepped:Connect(function()if LP.Character then for _,p in pairs(LP.Character:GetChildren())do if p:IsA("BasePart")then p.CanCollide=false end end end end)else if C.noclip then C.noclip:Disconnect()C.noclip=nil end end end)
tog("Local","Infinito Jump",Color3.fromRGB(0,200,100),"infJump",function(a)if a then C.infJump=UIS.JumpRequest:Connect(function()if LP.Character then local h=LP.Character:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)else if C.infJump then C.infJump:Disconnect()C.infJump=nil end end end)
tog("Local","God Mode",Color3.fromRGB(255,0,0),"godMode",function(a)if a then C.godMode=RS.Heartbeat:Connect(function()if LP.Character then local h=LP.Character:FindFirstChildOfClass("Humanoid")if h and h.Health>0 then h.Health=h.MaxHealth end end end)else if C.godMode then C.godMode:Disconnect()C.godMode=nil end end end)
tog("Local","Anti AFK",Color3.fromRGB(100,100,200),"antiAFK",function(a)if a then C.antiAFK=RS.Stepped:Connect(function()if LP.Character then local r=LP.Character:FindFirstChild("HumanoidRootPart")if r then r.Velocity=r.Velocity+Vector3.new(0.01,0,0)end end end)else if C.antiAFK then C.antiAFK:Disconnect()C.antiAFK=nil end end end)
-- Teleports
btn("Teleports","TP Player",Color3.fromRGB(255,120,0),function()
 local f=Instance.new("Frame")f.Size=UDim2.new(0,200,0,300)f.Position=UDim2.new(0.5,-100,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame")c.Size=UDim2.new(1,-10,1,-45)c.Position=UDim2.new(0,5,0,5)c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local lay=Instance.new("UIListLayout")lay.Padding=UDim.new(0,5)lay.HorizontalAlignment=Enum.HorizontalAlignment.Center lay.Parent=c
 for _,p in pairs(Players:GetPlayers())do if p~=LP then
  local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,40)b.BackgroundColor3=Color3.fromRGB(50,50,60)b.Text=p.Name b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=c
  b.MouseButton1Click:Connect(function()if p.Character and p.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0)f:Destroy()end end)
 end end
 local cf=Instance.new("TextButton")cf.Size=UDim2.new(1,-20,0,30)cf.Position=UDim2.new(0,10,1,-35)cf.BackgroundColor3=Color3.fromRGB(255,70,70)cf.Text="Fechar"cf.TextColor3=Color3.new(1,1,1)cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6)cf.Parent=f cf.MouseButton1Click:Connect(function()f:Destroy()end)
end)
inp("Teleports","Nome waypoint","Salvar",Color3.fromRGB(0,200,0),function(n)if n~=""and LP.Character then local r=LP.Character:FindFirstChild("HumanoidRootPart")if r then table.insert(WP,{name=n,cframe=r.CFrame})n("Waypoint '"..n.."' salvo!")end end end)
btn("Teleports","TP Waypoint",Color3.fromRGB(255,200,0),function()
 if #WP==0 then n("Nenhum waypoint",Color3.fromRGB(255,0,0))return end
 local f=Instance.new("Frame")f.Size=UDim2.new(0,200,0,300)f.Position=UDim2.new(0.5,-100,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame")c.Size=UDim2.new(1,-10,1,-45)c.Position=UDim2.new(0,5,0,5)c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local lay=Instance.new("UIListLayout")lay.Padding=UDim.new(0,5)lay.Parent=c
 for i,wp in ipairs(WP)do
  local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,40)b.BackgroundColor3=Color3.fromRGB(50,50,60)b.Text=wp.name b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=c
  b.MouseButton1Click:Connect(function()if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=wp.cframe f:Destroy()end end)
 end
 local cf=Instance.new("TextButton")cf.Size=UDim2.new(1,-20,0,30)cf.Position=UDim2.new(0,10,1,-35)cf.BackgroundColor3=Color3.fromRGB(255,70,70)cf.Text="Fechar"cf.TextColor3=Color3.new(1,1,1)cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6)cf.Parent=f cf.MouseButton1Click:Connect(function()f:Destroy()end)
end)
-- Visual
local function upESP()
 for _,p in pairs(Players:GetPlayers())do if p~=LP and p.Character then local c=p.Character local r=c:FindFirstChild("HumanoidRootPart")if r then
  local h=c:FindFirstChildOfClass("Highlight")if not h then h=Instance.new("Highlight")h.Name="ShinkaESP"h.Parent=c end
  h.FillColor=esp.color h.FillTransparency=esp.transp h.OutlineColor=Color3.fromRGB(255,255,255)h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
  local b=c:FindFirstChild("ShinkaBillboard")if not b then
   b=Instance.new("BillboardGui")b.Name="ShinkaBillboard"b.Size=UDim2.new(0,150,0,50)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true b.Parent=c
   local nl=Instance.new("TextLabel")nl.Name="Name"nl.Size=UDim2.new(1,0,0.5,0)nl.Position=UDim2.new(0,0,0,0)nl.BackgroundTransparency=1 nl.TextColor3=Color3.new(1,1,1)nl.TextStrokeTransparency=0 nl.TextScaled=true nl.Font=Enum.Font.GothamBold nl.Parent=b
   local dl=Instance.new("TextLabel")dl.Name="Distance"dl.Size=UDim2.new(1,0,0.5,0)dl.Position=UDim2.new(0,0,0.5,0)dl.BackgroundTransparency=1 dl.TextColor3=Color3.new(1,1,1)dl.TextStrokeTransparency=0 dl.TextScaled=true dl.Font=Enum.Font.Gotham dl.Parent=b
  end
  local nl=b:FindFirstChild("Name")if nl then nl.Text=esp.name and p.Name or""end
  local dl=b:FindFirstChild("Distance")if dl and esp.dist and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
   local dist=(r.Position-LP.Character.HumanoidRootPart.Position).Magnitude dl.Text=math.floor(dist).."m"else dl.Text=""end
 end end end
end
tog("Visual","ESP",Color3.fromRGB(255,255,0),"esp",function(a)
 if a then
  C.esp=RS.RenderStepped:Connect(upESP)
  C.playerAdded=Players.PlayerAdded:Connect(function(p)p.CharacterAdded:Connect(function()if FA.esp then upESP()end end)end)
 else
  if C.esp then C.esp:Disconnect()C.esp=nil end if C.playerAdded then C.playerAdded:Disconnect()C.playerAdded=nil end
  for _,p in pairs(Players:GetPlayers())do if p.Character then
   local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end
   local b=p.Character:FindFirstChild("ShinkaBillboard")if b then b:Destroy()end
  end end
 end
end)
btn("Visual","Configurar ESP",Color3.fromRGB(150,150,150),function()
 local f=Instance.new("Frame")f.Size=UDim2.new(0,250,0,250)f.Position=UDim2.new(0.5,-125,0.5,-125)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local y=10
 local function lbl(t)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-20,0,25)l.Position=UDim2.new(0,10,0,y)l.BackgroundTransparency=1 l.Text=t l.TextColor3=Color3.new(1,1,1)l.TextScaled=true l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f y=y+30 end
 lbl("Cor (R,G,B) ex:255,0,0")
 local c=Instance.new("TextBox")c.Size=UDim2.new(1,-20,0,30)c.Position=UDim2.new(0,10,0,y)c.BackgroundColor3=Color3.fromRGB(50,50,60)c.TextColor3=Color3.new(1,1,1)c.PlaceholderText="255,0,0"c.TextScaled=true c.Font=Enum.Font.Gotham Instance.new("UICorner",c).CornerRadius=UDim.new(0,6)c.Parent=f y=y+40
 lbl("Transparência (0-1)")
 local t=Instance.new("TextBox")t.Size=UDim2.new(1,-20,0,30)t.Position=UDim2.new(0,10,0,y)t.BackgroundColor3=Color3.fromRGB(50,50,60)t.TextColor3=Color3.new(1,1,1)t.PlaceholderText="0.5"t.TextScaled=true t.Font=Enum.Font.Gotham Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)t.Parent=f y=y+40
 local nt=Instance.new("TextButton")nt.Size=UDim2.new(1,-20,0,30)nt.Position=UDim2.new(0,10,0,y)nt.BackgroundColor3=esp.name and Color3.fromRGB(0,200,0)or Color3.fromRGB(200,0,0)nt.Text=esp.name and "Nome: ON"or"N
