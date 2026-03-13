-- ShinkaHub V2.6 - Parte 1/4
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local Workspace=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
_G.SH=_G.SH or{FA={},C={},waypoints={},espS={color=Color3.fromRGB(255,0,0),transparency=0.5,showDistance=true},farmS={delay=0.5},collectS={range=50,ignoreList={}},aimS={teamCheck=false,hitPart="Head"},tabs={}}
local SH=_G.SH
local gui=Instance.new("ScreenGui")gui.Name="ShinkaHub"gui.ResetOnSpawn=false gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling gui.Parent=LocalPlayer:WaitForChild("PlayerGui")
local main=Instance.new("Frame")main.Name="Main"main.Size=UDim2.new(0,320,0,480)main.Position=UDim2.new(0.5,-160,0.5,-240)main.BackgroundColor3=Color3.fromRGB(20,20,30)main.BorderSizePixel=2 main.BorderColor3=Color3.fromRGB(255,215,0)main.Active=true main.Draggable=false main.Parent=gui
Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)
local top=Instance.new("Frame")top.Size=UDim2.new(1,0,0,40)top.BackgroundColor3=Color3.fromRGB(30,30,40)top.BorderSizePixel=0 top.Parent=main
Instance.new("UICorner",top).CornerRadius=UDim.new(0,10)
local title=Instance.new("TextLabel")title.Size=UDim2.new(1,-80,1,0)title.Position=UDim2.new(0,10,0,0)title.BackgroundTransparency=1 title.Text="ShinkaHub V2.6"title.TextColor3=Color3.fromRGB(255,215,0)title.TextScaled=true title.Font=Enum.Font.GothamBold title.TextXAlignment=Enum.TextXAlignment.Left title.Parent=top
local minBtn=Instance.new("TextButton")minBtn.Size=UDim2.new(0,30,0,30)minBtn.Position=UDim2.new(1,-70,0,5)minBtn.BackgroundColor3=Color3.fromRGB(255,215,0)minBtn.Text="-"minBtn.TextColor3=Color3.fromRGB(20,20,30)minBtn.TextScaled=true minBtn.Font=Enum.Font.GothamBold minBtn.BorderSizePixel=0
Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,6)minBtn.Parent=top
local close=Instance.new("TextButton")close.Size=UDim2.new(0,30,0,30)close.Position=UDim2.new(1,-35,0,5)close.BackgroundColor3=Color3.fromRGB(255,70,70)close.Text="X"close.TextColor3=Color3.new(1,1,1)close.TextScaled=true close.Font=Enum.Font.GothamBold close.BorderSizePixel=0
Instance.new("UICorner",close).CornerRadius=UDim.new(0,6)close.Parent=top
local drag,dragS,startP
top.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch then drag=true dragS=i.Position startP=main.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then drag=false end end)end end)
top.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch and drag then local d=i.Position-dragS main.Position=UDim2.new(startP.X.Scale,startP.X.Offset+d.X,startP.Y.Scale,startP.Y.Offset+d.Y)end end)
local mini=Instance.new("Frame")mini.Name="Mini"mini.Size=UDim2.new(0,60,0,60)mini.Position=UDim2.new(0,20,0,100)mini.BackgroundColor3=Color3.fromRGB(255,215,0)mini.BorderSizePixel=2 mini.BorderColor3=Color3.fromRGB(255,255,255)mini.Visible=false mini.Parent=gui
Instance.new("UICorner",mini).CornerRadius=UDim.new(0,30)
local mIcon=Instance.new("TextLabel")mIcon.Size=UDim2.new(1,0,1,0)mIcon.BackgroundTransparency=1 mIcon.Text="S"mIcon.TextColor3=Color3.fromRGB(20,20,30)mIcon.TextScaled=true mIcon.Font=Enum.Font.GothamBold mIcon.Parent=mini
local dragM,dragMS,startMP
mini.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch then dragM=true dragMS=i.Position startMP=mini.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dragM=false end end)end end)
mini.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch and dragM then local d=i.Position-dragMS mini.Position=UDim2.new(startMP.X.Scale,startMP.X.Offset+d.X,startMP.Y.Scale,startMP.Y.Offset+d.Y)end end)
minBtn.MouseButton1Click:Connect(function()main.Visible=false mini.Visible=true end)
mini.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch then mini.Visible=false main.Visible=true end end)
close.MouseButton1Click:Connect(function()gui:Destroy()end)
local footer=Instance.new("TextLabel")footer.Size=UDim2.new(1,-20,0,25)footer.Position=UDim2.new(0,10,1,-30)footer.BackgroundTransparency=0.5 footer.BackgroundColor3=Color3.fromRGB(30,30,40)footer.Text="Shinka & Gemini"footer.TextColor3=Color3.fromRGB(255,215,0)footer.TextScaled=true footer.Font=Enum.Font.Gotham footer.BorderSizePixel=0
Instance.new("UICorner",footer).CornerRadius=UDim.new(0,6)footer.Parent=main
local tabFrame=Instance.new("Frame")tabFrame.Size=UDim2.new(1,-20,0,40)tabFrame.Position=UDim2.new(0,10,0,45)tabFrame.BackgroundTransparency=1 tabFrame.Parent=main
local tabCont=Instance.new("Frame")tabCont.Size=UDim2.new(1,-20,1,-120)tabCont.Position=UDim2.new(0,10,0,90)tabCont.BackgroundTransparency=1 tabCont.Parent=main tabCont.ClipsDescendants=true
local tabs={}
function createTab(name)
 local btn=Instance.new("TextButton")btn.Size=UDim2.new(0,50,1,0)btn.BackgroundColor3=Color3.fromRGB(40,40,50)btn.Text=name btn.TextColor3=Color3.new(1,1,1)btn.TextScaled=true btn.Font=Enum.Font.GothamSemibold btn.BorderSizePixel=0
 Instance.new("UICorner",btn).CornerRadius=UDim.new(0,6)btn.Parent=tabFrame
 local function resize()local s=btn.TextBounds.X+20 btn.Size=UDim2.new(0,math.max(50,s),1,0)end resize()btn:GetPropertyChangedSignal("TextBounds"):Connect(resize)
 local content=Instance.new("ScrollingFrame")content.Name=name.."Content"content.Size=UDim2.new(1,0,1,0)content.BackgroundTransparency=1 content.ScrollBarThickness=4 content.ScrollBarImageColor3=Color3.fromRGB(255,215,0)content.AutomaticCanvasSize=Enum.AutomaticSize.Y content.Visible=false content.Parent=tabCont
 local layout=Instance.new("UIListLayout")layout.Padding=UDim.new(0,8)layout.HorizontalAlignment=Enum.HorizontalAlignment.Center layout.SortOrder=Enum.SortOrder.LayoutOrder layout.Parent=content
 layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()content.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)end)
 tabs[name]={button=btn,content=content,layout=layout}
 btn.MouseButton1Click:Connect(function()if SH.currentTab then tabs[SH.currentTab].content.Visible=false tabs[SH.currentTab].button.BackgroundColor3=Color3.fromRGB(40,40,50)end SH.currentTab=name content.Visible=true btn.BackgroundColor3=Color3.fromRGB(255,215,0)end)
end
createTab("Home")createTab("Local")createTab("Teleports")createTab("Visual")createTab("World")createTab("Scripts")
SH.currentTab="Home"tabs["Home"].content.Visible=true tabs["Home"].button.BackgroundColor3=Color3.fromRGB(255,215,0)
function notify(t,c)c=c or Color3.fromRGB(0,200,0)local n=Instance.new("TextLabel")n.Size=UDim2.new(0,200,0,50)n.Position=UDim2.new(0.5,-100,0.5,-25)n.BackgroundColor3=c n.Text=t n.TextColor3=Color3.new(1,1,1)n.TextScaled=true n.Font=Enum.Font.GothamBold n.ZIndex=10 n.Parent=gui Instance.new("UICorner",n).CornerRadius=UDim.new(0,10)TweenService:Create(n,TweenInfo.new(1),{TextTransparency=1,BackgroundTransparency=1}):Play()wait(1)n:Destroy()end
function btn(tab,txt,color,cb)local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,50)b.BackgroundColor3=color b.Text=txt b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.GothamSemibold b.BorderSizePixel=2 b.BorderColor3=Color3.fromRGB(0,0,0)Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)b.Parent=tabs[tab].content b.MouseButton1Click:Connect(cb)return b end
function input(tab,ph,bt,color,cb)local f=Instance.new("Frame")f.Size=UDim2.new(1,-10,0,90)f.BackgroundTransparency=1 f.Parent=tabs[tab].content
 local box=Instance.new("TextBox")box.Size=UDim2.new(1,0,0,40)box.Position=UDim2.new(0,0,0,0)box.BackgroundColor3=Color3.fromRGB(50,50,60)box.TextColor3=Color3.new(1,1,1)box.PlaceholderText=ph box.PlaceholderColor3=Color3.fromRGB(180,180,180)box.TextScaled=true box.Font=Enum.Font.Gotham box.ClearTextOnFocus=false box.BorderSizePixel=2 box.BorderColor3=Color3.fromRGB(0,0,0)Instance.new("UICorner",box).CornerRadius=UDim.new(0,6)box.Parent=f
 local b=Instance.new("TextButton")b.Size=UDim2.new(1,0,0,40)b.Position=UDim2.new(0,0,1,-40)b.BackgroundColor3=color b.Text=bt b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.GothamSemibold b.BorderSizePixel=2 b.BorderColor3=Color3.fromRGB(0,0,0)Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=f
 b.MouseButton1Click:Connect(function()cb(box.Text)end)return f,box,b end
function toggle(tab,txt,color,name,on)local b=btn(tab,txt,color,function()SH.FA[name]=not SH.FA[name]if SH.FA[name]then b.BackgroundColor3=Color3.fromRGB(255,215,0)if on then on(true)end else b.BackgroundColor3=color if on then on(false)end end end)return b end
-- Home
btn("Home","Copiar Discord",Color3.fromRGB(100,100,255),function()setclipboard("https://discord.gg/SNutmtu6x")notify("Link copiado!")end)
btn("Home","Desativar Tudo",Color3.fromRGB(255,50,50),function()
 for k,v in pairs(SH.FA)do if v then
  if k=="noclip"and SH.C.noclip then SH.C.noclip:Disconnect()SH.C.noclip=nil end
  if k=="infJump"and SH.C.infJump then SH.C.infJump:Disconnect()SH.C.infJump=nil end
  if k=="godMode"and SH.C.godMode then SH.C.godMode:Disconnect()SH.C.godMode=nil end
  if k=="antiAFK"and SH.C.antiAFK then SH.C.antiAFK:Disconnect()SH.C.antiAFK=nil end
  if k=="aimbot"and SH.C.aimbot then SH.C.aimbot:Disconnect()SH.C.aimbot=nil end
  if k=="esp"then for _,p in pairs(Players:GetPlayers())do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end local b=p.Character:FindFirstChildOfClass("BillboardGui")if b and b.Name=="DistanceGUI"then b:Destroy()end end end
   if SH.C.playerAdded then SH.C.playerAdded:Disconnect()end if SH.C.playerRemoving then SH.C.playerRemoving:Disconnect()end end
  if k=="autoFarm"and SH.C.autoFarm then SH.C.autoFarm:Disconnect()SH.C.autoFarm=nil end
  if k=="collectItems"and SH.C.collectItems then SH.C.collectItems:Disconnect()SH.C.collectItems=nil end
  SH.FA[k]=false
 end end notify("Todas as funções desativadas",Color3.fromRGB(255,100,0))
end)
-- Local
input("Local","Velocidade (ex: 16)","Aplicar Speed",Color3.fromRGB(0,120,255),function(v)local s=tonumber(v)if s and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h.WalkSpeed=s end end end)
toggle("Local","NoClip",Color3.fromRGB(200,0,200),"noclip",function(a)if a then SH.C.noclip=RunService.Stepped:Connect(function()if LocalPlayer.Character then for _,p in pairs(LocalPlayer.Character:GetChildren())do if p:IsA("BasePart")then p.CanCollide=false end end end end)else if SH.C.noclip then SH.C.noclip:Disconnect()SH.C.noclip=nil end end end)
toggle("Local","Infinito Jump",Color3.fromRGB(0,200,100),"infJump",function(a)if a then SH.C.infJump=UserInputService.JumpRequest:Connect(function()if LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)else if SH.C.infJump then SH.C.infJump:Disconnect()SH.C.infJump=nil end end end)
toggle("Local","God Mode",Color3.fromRGB(255,0,0),"godMode",function(a)if a then SH.C.godMode=RunService.Heartbeat:Connect(function()if LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h and h.Health>0 then h.Health=h.MaxHealth end end end)else if SH.C.godMode then SH.C.godMode:Disconnect()SH.C.godMode=nil end end end)
toggle("Local","Anti AFK",Color3.fromRGB(100,100,200),"antiAFK",function(a)if a then SH.C.antiAFK=RunService.Stepped:Connect(function()if LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if r then r.Velocity=r.Velocity+Vector3.new(0.01,0,0)end end end)else if SH.C.antiAFK then SH.C.antiAFK:Disconnect()SH.C.antiAFK=nil end end end)
-- NOVA FUNÇÃO: Super Pulo
input("Local","JumpPower (ex: 50)","Aplicar Super Pulo",Color3.fromRGB(255,180,0),function(v)local j=tonumber(v)if j and LocalPlayer.Character then local h=LocalPlayer.Character:FindFirstChildOfClass("Humanoid")if h then h.JumpPower=j end end end)
print("Parte 1/4 carregada. Execute a parte 2 agora.")-- ShinkaHub V2.6 - Parte 2/4
local SH=_G.SH
if not SH or not SH.tabs then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
-- Teleports
btn("Teleports","Teleport Mouse",Color3.fromRGB(255,50,50),function()local t=Mouse.Hit if t and LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if r then r.CFrame=t end end end)
btn("Teleports","Teleport Jogador",Color3.fromRGB(255,120,0),function()
 local f=Instance.new("Frame")f.Size=UDim2.new(0,200,0,300)f.Position=UDim2.new(0.5,-100,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame")c.Size=UDim2.new(1,-10,1,-45)c.Position=UDim2.new(0,5,0,5)c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local l=Instance.new("UIListLayout")l.Padding=UDim.new(0,5)l.HorizontalAlignment=Enum.HorizontalAlignment.Center l.Parent=c
 for _,p in pairs(Players:GetPlayers())do if p~=LocalPlayer then
  local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,40)b.BackgroundColor3=Color3.fromRGB(50,50,60)b.Text=p.Name b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=c
  b.MouseButton1Click:Connect(function()if p.Character and p.Character:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then LocalPlayer.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0)f:Destroy()end end)
 end end
 local cf=Instance.new("TextButton")cf.Size=UDim2.new(1,-20,0,30)cf.Position=UDim2.new(0,10,1,-35)cf.BackgroundColor3=Color3.fromRGB(255,70,70)cf.Text="Fechar"cf.TextColor3=Color3.new(1,1,1)cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6)cf.Parent=f cf.MouseButton1Click:Connect(function()f:Destroy()end)
end)
input("Teleports","Nome do waypoint","Salvar Waypoint",Color3.fromRGB(0,200,0),function(n)if n~="" and LocalPlayer.Character then local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if r then table.insert(SH.waypoints,{name=n,cframe=r.CFrame})notify("Waypoint '"..n.."' salvo!")end end end)
btn("Teleports","Teleport Waypoint",Color3.fromRGB(255,200,0),function()
 if #SH.waypoints==0 then notify("Nenhum waypoint",Color3.fromRGB(255,0,0))return end
 local f=Instance.new("Frame")f.Size=UDim2.new(0,200,0,300)f.Position=UDim2.new(0.5,-100,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local c=Instance.new("ScrollingFrame")c.Size=UDim2.new(1,-10,1,-45)c.Position=UDim2.new(0,5,0,5)c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
 local l=Instance.new("UIListLayout")l.Padding=UDim.new(0,5)l.Parent=c
 for i,wp in ipairs(SH.waypoints)do
  local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,40)b.BackgroundColor3=Color3.fromRGB(50,50,60)b.Text=wp.name b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.Gotham
  Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=c
  b.MouseButton1Click:Connect(function()if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then LocalPlayer.Character.HumanoidRootPart.CFrame=wp.cframe f:Destroy()end end)
 end
 local cf=Instance.new("TextButton")cf.Size=UDim2.new(1,-20,0,30)cf.Position=UDim2.new(0,10,1,-35)cf.BackgroundColor3=Color3.fromRGB(255,70,70)cf.Text="Fechar"cf.TextColor3=Color3.new(1,1,1)cf.TextScaled=true cf.Font=Enum.Font.Gotham
 Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6)cf.Parent=f cf.MouseButton1Click:Connect(function()f:Destroy()end)
end)
-- Visual (ESP básico)
toggle("Visual","ESP",Color3.fromRGB(255,255,0),"esp",function(a)
 if a then
  local function ad(p)if p==LocalPlayer then return end
   local function ap(c)
    local h=Instance.new("Highlight")h.Name="ShinkaESP"h.FillColor=SH.espS.color h.OutlineColor=Color3.fromRGB(255,255,255)h.FillTransparency=SH.espS.transparency h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Parent=c
    if SH.espS.showDistance then
     local b=Instance.new("BillboardGui")b.Name="DistanceGUI"b.Size=UDim2.new(0,100,0,30)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true
     local t=Instance.new("TextLabel")t.Size=UDim2.new(1,0,1,0)t.BackgroundTransparency=1 t.TextColor3=Color3.new(1,1,1)t.TextStrokeTransparency=0 t.Text="??m"t.TextScaled=true t.Font=Enum.Font.GothamBold t.Parent=b
     b.Parent=c
     local conn
     conn=RunService.RenderStepped:Connect(function()if c and c:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then t.Text=math.floor((c.HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m"else conn:Disconnect()end end)
    end
   end
   if p.Character then ap(p.Character)end
   p.CharacterAdded:Connect(ap)
  end
  for _,p in pairs(Players:GetPlayers())do ad(p)end
  SH.C.playerAdded=Players.PlayerAdded:Connect(ad)
  SH.C.playerRemoving=Players.PlayerRemoving:Connect(function(p)if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end local b=p.Character:FindFirstChildOfClass("BillboardGui")if b and b.Name=="DistanceGUI"then b:Destroy()end end end)
 else
  for _,p in pairs(Players:GetPlayers())do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end local b=p.Character:FindFirstChildOfClass("BillboardGui")if b and b.Name=="DistanceGUI"then b:Destroy()end end end
  if SH.C.playerAdded then SH.C.playerAdded:Disconnect()end
  if SH.C.playerRemoving then SH.C.playerRemoving:Disconnect()end
 end
end)
print("Parte 2/4 carregada. Execute a parte 3 agora.")-- ShinkaHub V2.6 - Parte 3/4
local SH=_G.SH
if not SH then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
-- Visual (configurar ESP, remover neblina, zoom)
btn("Visual","Configurar ESP",Color3.fromRGB(150,150,150),function()
 local f=Instance.new("Frame")f.Size=UDim2.new(0,250,0,200)f.Position=UDim2.new(0.5,-125,0.5,-100)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=SH.gui
 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
 local y=10
 local function lbl(t)local l=Instance.new("TextLabel")l.Size=UDim2.new(1,-20,0,25)l.Position=UDim2.new(0,10,0,y)l.BackgroundTransparency=1 l.Text=t l.TextColor3=Color3.new(1,1,1)l.TextScaled=true l.Font=Enum.Font.Gotham l.TextXAlignment=Enum.TextXAlignment.Left l.Parent=f y=y+30 end
 lbl("Cor (R,G,B) ex: 255,0,0")
 local c=Instance.new("TextBox")c.Size=UDim2.new(1,-20,0,30)c.Position=UDim2.new(0,10,0,y)c.BackgroundColor3=Color3.fromRGB(50,50,60)c.TextColor3=Color3.new(1,1,1)c.PlaceholderText="255,0,0"c.TextScaled=true c.Font=Enum.Font.Gotham Instance.new("UICorner",c).CornerRadius=UDim.new(0,6)c.Parent=f y=y+40
 lbl("Transparência (0-1)")
 local t=Instance.new("TextBox")t.Size=UDim2.new(1,-20,0,30)t.Position=UDim2.new(0,10,0,y)t.BackgroundColor3=Color3.fromRGB(50,50,60)t.TextColor3=Color3.new(1,1,1)t.PlaceholderText="0.5"t.TextScaled=true t.Font=Enum.Font.Gotham Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)t.Parent=f y=y+40
 local dt=Instance.new("TextButton")dt.Size=UDim2.new(1,-20,0,30)dt.Position=UDim2.new(0,10,0,y)dt.BackgroundColor3=SH.espS.showDistance and Color3.fromRGB(0,200,0)or Color3.fromRGB(200,0,0)dt.Text=SH.espS.showDistance and "Distância: ON"or"Distância: OFF"dt.TextColor3=Color3.new(1,1,1)dt.TextScaled=true dt.Font=Enum.Font.Gotham Instance.new("UICorner",dt).CornerRadius=UDim.new(0,6)dt.Parent=f
 dt.MouseButton1Click:Connect(function()SH.espS.showDistance=not SH.espS.showDistance dt.BackgroundColor3=SH.espS.showDistance and Color3.fromRGB(0,200,0)or Color3.fromRGB(200,0,0)dt.Text=SH.espS.showDistance and "Distância: ON"or"Distância: OFF"end)
 y=y+40
 local a=Instance.new("TextButton")a.Size=UDim2.new(1,-20,0,40)a.Position=UDim2.new(0,10,0,y)a.BackgroundColor3=Color3.fromRGB(0,200,0)a.Text="Aplicar"a.TextColor3=Color3.new(1,1,1)a.TextScaled=true a.Font=Enum.Font.Gotham Instance.new("UICorner",a).CornerRadius=UDim.new(0,6)a.Parent=f
 a.MouseButton1Click:Connect(function()
  local r,g,b=c.Text:match("(%d+),%s*(%d+),%s*(%d+)")if r and g and b then SH.espS.color=Color3.fromRGB(tonumber(r),tonumber(g),tonumber(b))end
  local tr=tonumber(t.Text)if tr then SH.espS.transparency=math.clamp(tr,0,1)end
  if SH.FA.esp then
   for _,p in pairs(Players:GetPlayers())do if p.Character then local h=p.Character:FindFirstChildOfClass("Highlight")if h and h.Name=="ShinkaESP"then h:Destroy()end local b=p.Character:FindFirstChildOfClass("BillboardGui")if b and b.Name=="DistanceGUI"then b:Destroy()end end end
   local function ad(p)if p==LocalPlayer then return end
    local function ap(c)
     local h=Instance.new("Highlight")h.Name="ShinkaESP"h.FillColor=SH.espS.color h.OutlineColor=Color3.fromRGB(255,255,255)h.FillTransparency=SH.espS.transparency h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.Parent=c
     if SH.espS.showDistance then
      local b=Instance.new("BillboardGui")b.Name="DistanceGUI"b.Size=UDim2.new(0,100,0,30)b.StudsOffset=Vector3.new(0,3,0)b.AlwaysOnTop=true
      local t=Instance.new("TextLabel")t.Size=UDim2.new(1,0,1,0)t.BackgroundTransparency=1 t.TextColor3=Color3.new(1,1,1)t.TextStrokeTransparency=0 t.Text="??m"t.TextScaled=true t.Font=Enum.Font.GothamBold t.Parent=b
      b.Parent=c
      local conn
      conn=RunService.RenderStepped:Connect(function()if c and c:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then t.Text=math.floor((c.HumanoidRootPart.Position-LocalPlayer.Character.HumanoidRootPart.Position).Magnitude).."m"else conn:Disconnect()end end)
     end
    end
    if p.Character then ap(p.Character)end
    p.CharacterAdded:Connect(ap)
   end
   for _,p in pairs(Players:GetPlayers())do ad(p)end
  end
  f:Destroy()notify("Configurações ESP aplicadas")
 end)
end)
btn("Visual","Remover Neblina",Color3.fromRGB(0,150,255),function()Lighting.FogEnd=1e9 Lighting.FogStart=1e9 Lighting.Brightness=2 notify("Neblina removida")end)
btn("Visual","Zoom Infinito",Color3.fromRGB(255,200,100),function()LocalPlayer.CameraMaxZoomDistance=999999 LocalPlayer.CameraMinZoomDistance=0 notify("Zoom infinito ativado")end)
-- World (Fly, Btools, AutoFarm)
btn("World","Fly (Ativar)",Color3.fromRGB(255,120,0),function()loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()end)
btn("World","Btools",Color3.fromRGB(100,200,255),function()Instance.new("HopperBin",LocalPlayer.Backpack).BinType=Enum.BinType.Hammer Instance.new("HopperBin",LocalPlayer.Backpack).BinType=Enum.BinType.Clone Instance.new("HopperBin",LocalPlayer.Backpack).BinType=Enum.BinType.Grip notify("Ferramentas adicionadas")end)
toggle("World","Auto Farm",Color3.fromRGB(255,100,100),"autoFarm",function(a)
 if a then SH.C.autoFarm=RunService.Heartbeat:Connect(function()
  for _,g in pairs(LocalPlayer.PlayerGui:GetChildren())do if g:IsA("ScreenGui")then for _,b in pairs(g:GetDescendants())do if b:IsA("TextButton")and b.Visible and b.Active and b.Text~=""then b:Fire("MouseButton1Click",nil)wait(SH.farmS.delay)end end end end
 end)else if SH.C.autoFarm then SH.C.autoFarm:Disconnect()SH.C.autoFarm=nil end end
end)
input("World","Delay (seg)","Set Delay",Color3.fromRGB(150,150,150),function(v)local d=tonumber(v)if d then SH.farmS.delay=d end end)
print("Parte 3/4 carregada. Execute a parte 4 agora.")-- ShinkaHub V2.6 - Parte 4/4
local SH=_G.SH
if not SH then warn("Execute a parte 1 primeiro") return end
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
-- World (coletar itens, aimbot, gravidade)
toggle("World","Coletar Itens",Color3.fromRGB(0,255,100),"collectItems",function(a)
 if a then SH.C.collectItems=RunService.Heartbeat:Connect(function()
  if not LocalPlayer.Character then return end local r=LocalPlayer.Character:FindFirstChild("HumanoidRootPart")if not r then return end
  for _,o in pairs(Workspace:GetDescendants())do if o:IsA("BasePart")and o.Name:lower():find("item")and not SH.collectS.ignoreList[o.Name]then
   local d=(o.Position-r.Position).Magnitude if d<SH.collectS.range then r.CFrame=CFrame.new(o.Position)wait(0.1)if o:FindFirstChild("TouchInterest")then firetouchinterest(r,o,0)wait(0.1)firetouchinterest(r,o,1)end end
  end end
 end)else if SH.C.collectItems then SH.C.collectItems:Disconnect()SH.C.collectItems=nil end end
end)
input("World","Alcance","Set Alcance",Color3.fromRGB(150,150,150),function(v)local r=tonumber(v)if r then SH.collectS.range=r end end)
toggle("World","Aimbot",Color3.fromRGB(255,0,255),"aimbot",function(a)
 if a then SH.C.aimbot=RunService.RenderStepped:Connect(function()
  if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then return end
  local close,closeD=nil,math.huge
  for _,p in pairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
   if SH.aimS.teamCheck and p.Team==LocalPlayer.Team then continue end
   local part=p.Character:FindFirstChild(SH.aimS.hitPart)or p.Character.HumanoidRootPart
   local sp,on=Workspace.CurrentCamera:WorldToViewportPoint(part.Position)
   if on then local d=(Vector2.new(sp.X,sp.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude if d<closeD then closeD=d close=p end end
  end end
  if close then local tp=close.Character:FindFirstChild(SH.aimS.hitPart)or close.Character.HumanoidRootPart Workspace.CurrentCamera.CFrame=CFrame.new(Workspace.CurrentCamera.CFrame.Position,tp.Position)end
 end)else if SH.C.aimbot then SH.C.aimbot:Disconnect()SH.C.aimbot=nil end end
end)
-- NOVA FUNÇÃO: Gravidade Personalizada
input("World","Gravidade (ex: 50)","Aplicar Gravidade",Color3.fromRGB(0,200,200),function(v)local g=tonumber(v)if g then Workspace.Gravity=g notify("Gravidade alterada para "..g)end end)
-- Scripts
input("Scripts","URL do script","Executar",Color3.fromRGB(255,100,0),function(u)if u~=""then local s,e=pcall(function()loadstring(game:HttpGet(u))()end)if s then notify("Script executado")else notify("Erro",Color3.fromRGB(255,0,0))end end end)
input("Scripts","Nome do script","Copiar Template",Color3.fromRGB(100,100,255),function(n)setclipboard('{"'..n..'":"https://exemplo.com/script.lua"}')notify("Template copiado!")end)
btn("Scripts","Importar Scripts",Color3.fromRGB(0,200,100),function()
 local s,d=pcall(function()return game:GetService("HttpService"):JSONDecode(readclipboard())end)
 if s and type(d)=="table"then
  local f=Instance.new("Frame")f.Size=UDim2.new(0,250,0,300)f.Position=UDim2.new(0.5,-125,0.5,-150)f.BackgroundColor3=Color3.fromRGB(30,30,40)f.BorderSizePixel=2 f.BorderColor3=Color3.fromRGB(255,215,0)f.Parent=SH.gui
  Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
  local c=Instance.new("ScrollingFrame")c.Size=UDim2.new(1,-10,1,-45)c.Position=UDim2.new(0,5,0,5)c.BackgroundTransparency=1 c.ScrollBarThickness=4 c.AutomaticCanvasSize=Enum.AutomaticSize.Y c.Parent=f
  local l=Instance.new("UIListLayout")l.Padding=UDim.new(0,5)l.Parent=c
  for nome,url in pairs(d)do
   local b=Instance.new("TextButton")b.Size=UDim2.new(1,-10,0,40)b.BackgroundColor3=Color3.fromRGB(50,50,60)b.Text=nome b.TextColor3=Color3.new(1,1,1)b.TextScaled=true b.Font=Enum.Font.Gotham
   Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.Parent=c
   b.MouseButton1Click:Connect(function()local s,e=pcall(function()loadstring(game:HttpGet(url))()end)if s then notify("Script executado")else notify("Erro",Color3.fromRGB(255,0,0))end f:Destroy()end)
  end
  local cf=Instance.new("TextButton")cf.Size=UDim2.new(1,-20,0,30)cf.Position=UDim2.new(0,10,1,-35)cf.BackgroundColor3=Color3.fromRGB(255,70,70)cf.Text="Fechar"cf.TextColor3=Color3.new(1,1,1)cf.TextScaled=true cf.Font=Enum.Font.Gotham
  Instance.new("UICorner",cf).CornerRadius=UDim.new(0,6)cf.Parent=f cf.MouseButton1Click:Connect(function()f:Destroy()end)
 else notify("Nenhum script válido",Color3.fromRGB(255,0,0))end
end)
btn("Scripts","Limpar Memória",Color3.fromRGB(200,0,0),function()collectgarbage()notify("Memória limpa")end)
print("ShinkaHub V2.6 carregado! Todas as 4 partes executadas.")
