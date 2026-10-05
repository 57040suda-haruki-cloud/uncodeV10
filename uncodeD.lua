local _S=getgenv()
local AuraHRP=_S._UC_AuraHRP
local Debris=_S._UC_Debris
local GuiSvc=_S._UC_GuiSvc
local ItemLib=_S._UC_ItemLib
local L0=_S._UC_L0
local State=_S._UC_State
local T0=_S._UC_T0
local TraceParams=_S._UC_TraceParams
local TracerPool=_S._UC_TracerPool
local VT=_S._UC_VT
local _RV_SRC=_S._UC__RV_SRC
local _ucBoxes=_S._UC__ucBoxes
local a0=_S._UC_a0
local a1=_S._UC_a1
local anyOn=_S._UC_anyOn
local args=_S._UC_args
local bd=_S._UC_bd
local beam=_S._UC_beam
local best=_S._UC_best
local box=_S._UC_box
local cam=_S._UC_cam
local cc=_S._UC_cc
local ch=_S._UC_ch
local char=_S._UC_char
local clone=_S._UC_clone
local col=_S._UC_col
local cols=_S._UC_cols
local corners=_S._UC_corners
local cosType=_S._UC_cosType
local crossGui=_S._UC_crossGui
local crossLabel=_S._UC_crossLabel
local crossLines=_S._UC_crossLines
local crossOutlines=_S._UC_crossOutlines
local crossRoot=_S._UC_crossRoot
local crossSpin=_S._UC_crossSpin
local cur=_S._UC_cur
local dir=_S._UC_dir
local dist=_S._UC_dist
local dl=_S._UC_dl
local dname=_S._UC_dname
local fade=_S._UC_fade
local forwarder=_S._UC_forwarder
local gap=_S._UC_gap
local geo=_S._UC_geo
local hbBG=_S._UC_hbBG
local hbFill=_S._UC_hbFill
local hitPos=_S._UC_hitPos
local hl=_S._UC_hl
local hooked=_S._UC_hooked
local hp=_S._UC_hp
local hrp=_S._UC_hrp
local hud=_S._UC_hud
local hudBar=_S._UC_hudBar
local hudFill=_S._UC_hudFill
local hudInfo=_S._UC_hudInfo
local hudName=_S._UC_hudName
local hum=_S._UC_hum
local insetY=_S._UC_insetY
local len=_S._UC_len
local ln=_S._UC_ln
local ls=_S._UC_ls
local mat=_S._UC_mat
local ml=_S._UC_ml
local myHrp=_S._UC_myHrp
local nl=_S._UC_nl
local now=_S._UC_now
local off=_S._UC_off
local old=_S._UC_old
local opts=_S._UC_opts
local orig=_S._UC_orig
local origin=_S._UC_origin
local pct=_S._UC_pct
local pf=_S._UC_pf
local pos=_S._UC_pos
local pr=_S._UC_pr
local refs=_S._UC_refs
local root=_S._UC_root
local rotSpd=_S._UC_rotSpd
local syncCol=_S._UC_syncCol
local th=_S._UC_th
local tool=_S._UC_tool
local tr=_S._UC_tr
local vis=_S._UC_vis
local visGui=_S._UC_visGui
local vp=_S._UC_vp
local weapon=_S._UC_weapon
local wl=_S._UC_wl
local wm=_S._UC_wm
pcall(function()
local res=workspace:Raycast(origin,cam.CFrame.LookVector*1000,TraceParams)
if res and res.Position then hitPos=res.Position end
end)
SpawnTracer((cam.CFrame*CFrame.new(0.45,-0.35,-1.5)).Position,hitPos)
end))
local crossGui=New("ScreenGui",{Name="RV_Cross",ResetOnSpawn=false,IgnoreGuiInset=true,DisplayOrder=9999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},gethui and gethui() or CoreGui)
local crossRoot=New("Frame",{Name="Cross",Size=UDim2.new(0,0,0,0),Position=UDim2.new(0.5,0,0.5,0),BackgroundTransparency=1,Visible=false},crossGui)
local crossSpin=New("Frame",{Name="Spin",Size=UDim2.new(0,0,0,0),BackgroundTransparency=1},crossRoot)
local crossTextBox=New("Frame",{Name="TB",Size=UDim2.new(0,0,0,0),BackgroundTransparency=1},crossRoot)
local crossLines={} local crossOutlines={}
for i=1,4 do
crossOutlines[i]=New("Frame",{BorderSizePixel=0,BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.5,AnchorPoint=Vector2.new(0.5,0.5),ZIndex=2},crossSpin)
crossLines[i]=New("Frame",{BorderSizePixel=0,BackgroundColor3=Color3.white,AnchorPoint=Vector2.new(0.5,0.5),ZIndex=3},crossSpin)
end
local crossLabel=New("TextLabel",{Size=UDim2.new(0,300,0,20),Position=UDim2.new(0,-150,0,22),BackgroundTransparency=1,Font=Enum.Font.Arial,TextSize=14,TextColor3=Color3.white,TextStrokeTransparency=0,TextStrokeColor3=Color3.new(0,0,0),Text="uncode",Visible=false,ZIndex=4},crossTextBox)
Bind(RunService.RenderStepped:Connect(function(dt)
if State.Destroyed then return end
crossRoot.Visible=C.Crosshair.Enabled
crossLabel.Visible=C.Crosshair.Enabled and C.Crosshair.Label
if not crossRoot.Visible then return end
dt=math.clamp(dt or 0.016,0,0.1)
State.CrossTick=(State.CrossTick or 0)+dt
local tick=State.CrossTick
local pos
if C.Crosshair.FollowMouse then
local ml=UIS:GetMouseLocation()
local insetY=0; pcall(function() insetY=GuiSvc:GetGuiInset().Y end)
pos=UDim2.new(0,ml.X,0,ml.Y-insetY)
else
pos=UDim2.new(0.5,0,0.5,0)
end
crossSpin.Position=pos; crossTextBox.Position=pos
local pf=C.Crosshair.Pulse and math.sin(tick*3.5) or 0
local pct=(pf+1)/2
local rotSpd=(C.Crosshair.RotSpeed or 0)*(0.35+pct*1.4)
crossSpin.Rotation=(crossSpin.Rotation+rotSpd*dt)%360
local syncCol=Color3.fromHSV((tick*0.05)%1,1,1)
local cols=C.Crosshair.RGB and {syncCol,syncCol,syncCol,syncCol} or {C.Crosshair.C1,C.Crosshair.C2,C.Crosshair.C3,C.Crosshair.C4}
crossLabel.TextColor3=cols[1]; crossLabel.Text=C.Crosshair.LabelText
local len=math.max(1,C.Crosshair.Size+(C.Crosshair.Pulse and pf*5 or 0))
local gap=C.Crosshair.Gap; local th=math.max(1,C.Crosshair.Thick)
local geo={
{ls=UDim2.new(0,th,0,len),lp=UDim2.new(0,0,0,-gap-len/2)},
{ls=UDim2.new(0,th,0,len),lp=UDim2.new(0,0,0,gap+len/2)},
{ls=UDim2.new(0,len,0,th),lp=UDim2.new(0,-gap-len/2,0,0)},
{ls=UDim2.new(0,len,0,th),lp=UDim2.new(0,gap+len/2,0,0)},
}
for i=1,4 do
local L,O,G=crossLines[i],crossOutlines[i],geo[i]
L.Size=G.ls; L.Position=G.lp; L.BackgroundColor3=cols[i]
O.Size=i<=2 and UDim2.new(0,th+2,0,len+2) or UDim2.new(0,len+2,0,th+2)
O.Position=G.lp
end
end))
local function ClearESP(p)
local f=State.ESPGui[p]; if f then pcall(f.Destroy,f); State.ESPGui[p]=nil end
local hl=State.ESPGui[p.Name.."_hl"]; if hl then pcall(hl.Destroy,hl); State.ESPGui[p.Name.."_hl"]=nil end
State.ESPGui[p.Name.."_refs"]=nil; State.ESPGui[p.Name.."_char"]=nil
end
local function MakeESP(p)
ClearESP(p)
local char=p.Character; if not char then return end
local hrp=char:FindFirstChild("HumanoidRootPart")
local hum=char:FindFirstChildOfClass("Humanoid")
if not hrp or not hum then return end
local root=New("BillboardGui",{Name="RV_ESP_"..p.Name,Adornee=hrp,Size=UDim2.new(0,120,0,96),StudsOffset=Vector3.new(0,2.5,0),AlwaysOnTop=true},visGui)
State.ESPGui[p]=root
local box=New("Frame",{Size=UDim2.new(0,60,0,60),Position=UDim2.new(0.5,-30,0,26),BackgroundTransparency=1,BorderSizePixel=0,Visible=C.ESP.Box},root)
local corners={}
local L0=14; local T0=math.max(1,math.floor(C.ESP.Thickness))
for _,d in pairs({{0,0,L0,T0},{0,0,T0,L0},{60-L0,0,L0,T0},{60-T0,0,T0,L0},{0,60-T0,L0,T0},{0,60-T0,T0,L0},{60-L0,60-T0,L0,T0},{60-T0,60-T0,T0,L0}}) do
table.insert(corners,New("Frame",{Size=UDim2.new(0,d[3],0,d[4]),Position=UDim2.new(0,d[1],0,d[2]),BackgroundColor3=C.ESP.BoxFill,BorderSizePixel=0},box))
end
local dname=C.ESP.NameType=="DisplayName" and p.DisplayName or C.ESP.NameType=="Both" and p.Name.."["..p.DisplayName.."]" or p.Name
local nl=New("TextLabel",{Size=UDim2.new(1,0,0,14),Position=UDim2.new(0,0,0,0),BackgroundTransparency=1,Font=Enum.Font.Code,TextSize=12,TextColor3=C.ESP.NameA,TextStrokeTransparency=0.3,Text=dname,Visible=C.ESP.Name},root)
local tool=char:FindFirstChildOfClass("Tool")
local wl=New("TextLabel",{Size=UDim2.new(1,0,0,10),Position=UDim2.new(0,0,0,14),BackgroundTransparency=1,Font=Enum.Font.Code,TextSize=10,TextColor3=Color3.fromRGB(220,220,220),TextStrokeTransparency=0.4,Text=tool and tool.Name or "",Visible=C.ESP.Weapon},root)
local dl=New("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-26),BackgroundTransparency=1,Font=Enum.Font.Code,TextSize=10,TextColor3=Color3.fromRGB(150,150,150),Text="",Visible=C.ESP.Distance},root)
local wm=New("TextLabel",{Size=UDim2.new(1,0,0,12),Position=UDim2.new(0,0,1,-13),BackgroundTransparency=1,Font=Enum.Font.GothamBold,TextSize=11,TextColor3=C.ESP.WatermarkColor,TextStrokeTransparency=0.3,Text=C.ESP.WatermarkText,Visible=C.ESP.Watermark},root)
local hbBG=New("Frame",{Size=UDim2.new(0,4,0,56),Position=UDim2.new(0.5,-37,0,28),BackgroundColor3=Color3.fromRGB(20,20,20),BorderSizePixel=0,Visible=C.ESP.Healthbar},root)
local hbFill=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=C.ESP.HB_A,BorderSizePixel=0},hbBG)
local hl=nil
if C.ESP.Outline then
hl=New("Highlight",{FillColor=C.ESP.BoxFill,OutlineColor=Color3.fromRGB(255,255,255),FillTransparency=0.7,OutlineTransparency=0.1,DepthMode=Enum.HighlightDepthMode.Occluded,Adornee=char},visGui)
end
State.ESPGui[p.Name.."_hl"]=hl
State.ESPGui[p.Name.."_refs"]={box=box,corners=corners,name=nl,weap=wl,dist=dl,wmark=wm,hbBG=hbBG,hbFill=hbFill,hl=hl}
State.ESPGui[p.Name.."_char"]=char
end
local function RefreshESP()
if State.Destroyed then return end
local now=os.clock(); if now-State.LastESP<0.1 then return end; State.LastESP=now
local anyOn=C.ESP.Box or C.ESP.Name or C.ESP.Weapon or C.ESP.Distance or C.ESP.Healthbar or C.ESP.Outline or C.ESP.Watermark
if not anyOn then
for _,p in pairs(Players:GetPlayers()) do if State.ESPGui[p] then ClearESP(p) end end
return
end
local myC=GetChar(); local myHrp=myC and myC:FindFirstChild("HumanoidRootPart"); if not myHrp then return end
for _,p in pairs(Players:GetPlayers()) do
if p==LP then continue end
local ch=p.Character; local hrp=ch and ch:FindFirstChild("HumanoidRootPart"); local hum=ch and ch:FindFirstChildOfClass("Humanoid")
if not hrp or not hum then ClearESP(p); continue end
if hum.Health<=0 then ClearESP(p); continue end
local dist=(myHrp.Position-hrp.Position).Magnitude
if dist>C.ESP.MaxDistance then ClearESP(p); continue end
if State.ESPGui[p.Name.."_char"]~=ch then MakeESP(p) end
local refs=State.ESPGui[p.Name.."_refs"]; if not refs then MakeESP(p); refs=State.ESPGui[p.Name.."_refs"] end
if not refs then continue end
refs.box.Visible=C.ESP.Box
if refs.dist then refs.dist.Text=math.floor(dist).."m"; refs.dist.Visible=C.ESP.Distance end
if refs.weap then
local t=ch:FindFirstChildOfClass("Tool"); refs.weap.Text=t and t.Name or ""; refs.weap.Visible=C.ESP.Weapon
end
if refs.hbBG and C.ESP.Healthbar then
refs.hbBG.Visible=true
local ratio=math.clamp(hum.Health/math.max(hum.MaxHealth,1),0,1)
refs.hbFill.Size=UDim2.new(1,0,ratio,0)
refs.hbFill.Position=UDim2.new(0,0,1-ratio,0)
refs.hbFill.BackgroundColor3=Color3.fromRGB(math.floor((1-ratio)*220),math.floor(ratio*190),60)
elseif refs.hbBG then refs.hbBG.Visible=false end
if refs.hl then refs.hl.Enabled=C.ESP.Outline end
end
for _,p in pairs(Players:GetPlayers()) do if not p.Parent then ClearESP(p) end end
end
Bind(Players.PlayerRemoving:Connect(ClearESP))
local hud=New("Frame",{Name="THUD",Size=UDim2.new(0,220,0,64),BackgroundColor3=Color3.fromRGB(7,7,7),BorderSizePixel=0,Visible=false},visGui)
New("UIStroke",{Color=Color3.fromRGB(184,172,255),Thickness=1,Transparency=0.4},hud)
local hudName=New("TextLabel",{Size=UDim2.new(1,-10,0,18),Position=UDim2.new(0,5,0,4),BackgroundTransparency=1,Font=Enum.Font.Code,TextSize=12,TextColor3=Color3.fromRGB(225,225,225),TextXAlignment=Enum.TextXAlignment.Left,Text="target: -"},hud)
local hudInfo=New("TextLabel",{Size=UDim2.new(1,-10,0,16),Position=UDim2.new(0,5,0,22),BackgroundTransparency=1,Font=Enum.Font.Code,TextSize=11,TextColor3=Color3.fromRGB(150,150,150),TextXAlignment=Enum.TextXAlignment.Left,Text="hp: -  dist: -"},hud)
local hudBar=New("Frame",{Size=UDim2.new(1,-10,0,8),Position=UDim2.new(0,5,0,42),BackgroundColor3=Color3.fromRGB(35,35,40),BorderSizePixel=0},hud)
local hudFill=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(184,172,255),BorderSizePixel=0},hudBar)
New("UICorner",{CornerRadius=UDim.new(0,3)},hudBar); New("UICorner",{CornerRadius=UDim.new(0,3)},hudFill)
Bind(RunService.Heartbeat:Connect(function(dt)
if State.Destroyed then return end
RefreshESP()
if C.Viewmodel.OverrideFPS then
local cam=workspace.CurrentCamera; if cam then
pcall(function() cam.MaxAxisFieldOfView=cam.MaxAxisFieldOfView end)
end
end
if C.TargetHUD.Enabled then
local myC=GetChar(); local myHrp=myC and myC:FindFirstChild("HumanoidRootPart")
if myHrp then
hud.Visible=true
hud.Position=UDim2.new(C.TargetHUD.OffX/100,0,C.TargetHUD.OffY/100,0)
hud.Size=UDim2.new(0,220*C.TargetHUD.UIScale/100,0,64*C.TargetHUD.UIScale/100)
local best,bd=nil,math.huge
for _,p in pairs(Players:GetPlayers()) do
if p==LP or not p.Character then continue end
local rp=p.Character:FindFirstChild("HumanoidRootPart"); if not rp then continue end
local d=(myHrp.Position-rp.Position).Magnitude
if d<bd then bd=d; best=p end
end
if best then
local h=best.Character:FindFirstChildOfClass("Humanoid")
local hp=h and math.floor(h.Health) or 0; local mx=h and h.MaxHealth or 100
hudName.Text="target: "..(C.ESP.NameType=="DisplayName" and best.DisplayName or best.Name)
hudInfo.Text="hp: "..hp.."  dist: "..math.floor(bd).."m"
hudFill.Size=UDim2.new(math.clamp(hp/mx,0,1),0,1,0)
else
hudName.Text="target: -"; hudInfo.Text="hp: -  dist: -"; hudFill.Size=UDim2.new(0,0,1,0)
end
else hud.Visible=false end
else hud.Visible=false end
if C.Aura.Enabled and AuraObjs.Ring and AuraObjs.Ring.Parent and AuraHRP and AuraHRP.Parent then
pcall(function()
AuraObjs.Ring.CFrame=AuraHRP.CFrame*CFrame.new(0,-3.05,0)*CFrame.Angles(0,0,math.rad(90))
if C.Aura.Pulse then
local s=6.5*C.Aura.Size*(0.9+0.15*math.sin(os.clock()*4))
AuraObjs.Ring.Size=Vector3.new(0.2,s,s)
end
end)
end
if C.Aura.RGB and AuraObjs.L and AuraObjs.L.Parent then
State.Hue=(State.Hue+0.005)%1
local cc=Color3.fromHSV(State.Hue,0.9,1)
pcall(function() AuraObjs.L.Color=cc end)
if AuraObjs.Ring and AuraObjs.Ring.Parent then pcall(function() AuraObjs.Ring.Color=cc end) end
if AuraObjs.P1 and AuraObjs.P1.Parent then pcall(function() AuraObjs.P1.Color=ColorSequence.new(cc) end) end
end
end))
Bind(LP.CharacterAdded:Connect(function(c)
task.wait(0.6)
BuildAura(GetChar())
ApplyAppearance()
end))
task.spawn(function() local c=GetChar(); if c then BuildAura(c) end end)
RV.Unlock = {active=false, equipped={}, favorites={}, trueNamecall=nil}
local U=RV.Unlock
local function setupUnlock()
pcall(function()
local modules=RS:WaitForChild("Modules",8)
local playerScripts=LP:WaitForChild("PlayerScripts",10)
local controllers=playerScripts:WaitForChild("Controllers",10)
local CosLib=require(modules:WaitForChild("CosmeticLibrary",6))
local ItemLib=require(modules:WaitForChild("ItemLibrary",6))
local DataCtrl=require(controllers:WaitForChild("PlayerDataController",6))
local EnumLib; pcall(function()
local m=modules:FindFirstChild("EnumLibrary")
if m then EnumLib=require(m); if EnumLib.WaitForEnumBuilder then EnumLib:WaitForEnumBuilder() end end
end)
local function unlockedType(c,name)
if c then local t=c.Type; if t=="Skin" or t=="Charm" or t=="Wrap" or t=="Wrapping" or t=="Dance" or t=="Emote" then return true end end
if type(name)=="string" then
local ln=string.lower(name)
if ln:find("charm",1,true) or ln:find("wrap",1,true) or ln:find("dance",1,true) or ln:find("emote",1,true) then return true end
end
return false
end
local function cloneCosmetic(name,cosType,options)
local base=CosLib.Cosmetics and CosLib.Cosmetics[name]; if not base then return nil end
local data={}; for k,v in pairs(base) do data[k]=v end
data.Name=name; if not data.Type then data.Type=cosType end
if not data.Seed then data.Seed=math.random(1,1000000) end
if EnumLib then pcall(function()
local ok,enumId=pcall(EnumLib.ToEnum,EnumLib,name)
if ok and enumId then data.Enum=enumId; if not data.ObjectID then data.ObjectID=enumId end end
end) end
if type(options)=="table" then
if options.inverted~=nil then data.Inverted=options.inverted end
if options.favoritesOnly~=nil then data.OnlyUseFavorites=options.favoritesOnly end
end
return data
end
local curOwns=CosLib.OwnsCosmetic
CosLib.OwnsCosmetic=function(self,inventory,name,weapon)
if U.active and type(name)=="string" and not string.find(name,"MISSING_") then
local c=CosLib.Cosmetics and CosLib.Cosmetics[name]
if c and unlockedType(c,name) then return true end
end
return curOwns(self,inventory,name,weapon)
end
local curGet=DataCtrl.Get
DataCtrl.Get=function(self,key)
local data=curGet(self,key)
if not U.active then return data end
if key=="CosmeticInventory" then
local proxy={}
if type(data)=="table" then for k,v in pairs(data) do proxy[k]=v end end
return setmetatable(proxy,{__index=function(t,k)
if type(k)=="string" then
local c=CosLib.Cosmetics and CosLib.Cosmetics[k]
if c and unlockedType(c,k) then return true end
end
return nil
end})
end
if key=="FavoritedCosmetics" then
local result={}
if type(data)=="table" then for k,v in pairs(data) do result[k]=v end end
for w,favs in pairs(U.favorites) do
if type(favs)=="table" then result[w]=result[w] or {}; for n,f in pairs(favs) do result[w][n]=f end end
end
return result
end
return data
end
local curGWD=DataCtrl.GetWeaponData
if curGWD then
DataCtrl.GetWeaponData=function(self,weaponName)
local data=curGWD(self,weaponName); if not data or not U.active then return data end
local eq=U.equipped[weaponName]; if type(eq)~="table" then return data end
local merged={}; for k,v in pairs(data) do merged[k]=v end
merged.Name=weaponName
for ctype,cdata in pairs(eq) do merged[ctype]=cdata end
return merged
end
end
pcall(function()
if not hookmetamethod or not getnamecallmethod then return end
local rems=RS:FindFirstChild("Remotes")
local dataRems=rems and rems:FindFirstChild("Data")
local equipRemote=dataRems and dataRems:FindFirstChild("EquipCosmetic")
local favRemote=dataRems and dataRems:FindFirstChild("FavoriteCosmetic")
if not equipRemote then return end
local function storeEquip(wn,ct,cn,options)
if type(options)~="table" then options={} end
if not cn or cn=="None" or cn=="" then
if U.equipped[wn] then U.equipped[wn][ct]=nil; if not next(U.equipped[wn]) then U.equipped[wn]=nil end end
return
end
local cloned=cloneCosmetic(cn,ct,{inverted=options.IsInverted,favoritesOnly=options.OnlyUseFavorites})
if cloned then U.equipped[wn]=U.equipped[wn] or {}; U.equipped[wn][ct]=cloned end
end
local function forwarder(self,...)
if getnamecallmethod()~="FireServer" then return U.trueNamecall(self,...) end
if not U.active then return U.trueNamecall(self,...) end
local args={...}
if self==equipRemote then
local wn,ct,cn,opts=args[1],args[2],args[3],args[4]
storeEquip(wn,ct,cn,opts)
task.defer(function()
pcall(function() DataCtrl.CurrentData:Replicate("WeaponInventory") end)
end)
return
end
if favRemote and self==favRemote then
local w,cn,fav=args[1],args[2],args[3]
U.favorites[w]=U.favorites[w] or {}; U.favorites[w][cn]=fav or nil
task.spawn(function() pcall(function() DataCtrl.CurrentData:Replicate("FavoritedCosmetics") end) end)
return
end
return U.trueNamecall(self,...)
end
if not U.trueNamecall then U.trueNamecall=hookmetamethod(game,"__namecall",forwarder) end
end)
pcall(function()
local ClientItem=require(playerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
if not ClientItem or not ClientItem._CreateViewModel then return end
local cur=ClientItem._CreateViewModel
ClientItem._CreateViewModel=function(self,viewmodelRef)
pcall(function()
if U.active and self.ClientFighter and self.ClientFighter.Player==LP then
local wname=self.Name; local eq=U.equipped[wname]
if type(eq)=="table" and viewmodelRef then
for _,ctype in pairs({"Skin","Charm","Wrap"}) do
local cd=eq[ctype]
if cd then
if viewmodelRef.Data then viewmodelRef.Data[ctype]=cd; viewmodelRef.Data.Name=cd.Name
else pcall(function()
local dataKey=self:ToEnum("Data")
if dataKey and viewmodelRef[dataKey] then viewmodelRef[dataKey][self:ToEnum(ctype)]=cd end
end) end
end
end
end
end
end)
return cur(self,viewmodelRef)
end
end)
end)
end
task.spawn(setupUnlock)
function RV:Destroy()
State.Destroyed=true; State.SliderActive=nil
for _,c in pairs(State.Conns) do pcall(function() if typeof(c)=="RBXScriptConnection" then c:Disconnect() end end) end
for _,c in pairs(State.DmgConns) do pcall(function() if typeof(c)=="RBXScriptConnection" then c:Disconnect() end end) end
table.clear(State.DmgConns)
for _,h in pairs(State.TracerPool) do pcall(function() if h and h.Parent then h:Destroy() end end) end
table.clear(State.TracerPool)
pcall(ClearAura); pcall(RestoreWorld)
for _,v in pairs(State.ESPGui) do pcall(function() if typeof(v)=="Instance" and v.Parent then v:Destroy() end end) end
table.clear(State.ESPGui); table.clear(hooked)
pcall(function() visGui:Destroy() end)
pcall(function() crossGui:Destroy() end)
end
print("[RV Visuals Module] loaded")
return RV
]==]
local RV
do
local _ok,_fn=pcall(loadstring,_RV_SRC,"RVModule")
if _ok and _fn then
local _ok2,_r=pcall(_fn)
if _ok2 and type(_r)=="table" then RV=_r end
end
if not RV then
RV={Config={Aura={Enabled=false},Trail={Enabled=false},
ESP={Enabled=false},Crosshair={Enabled=false}},
Destroy=function()end}
end
end
pcall(function()
local VT = Tabs.Visuals
local AUL = VT:AddLeftGroupbox("Aura")
BT(AUL,"Aura_On","Aura Enabled",true,function(v)
RV.Config.Aura.Enabled=v
if v then local c=RV.Config; c=c; task.spawn(function() local ch=LP.Character; if ch then RV.BuildAura(ch) end end)
else RV.ClearAura() end
end)
AUL:AddDropdown("Aura_Mode",{Text="Mode",Default="Cyber Blue",
Values={"Cyber Blue","Blood Red","Venom Green","Royal Purple","Sun God","Shadow"},
Callback=function(v) RV.Config.Aura.Mode=v; local ch=LP.Character; if ch then RV.BuildAura(ch) end end})
AUL:AddToggle("Aura_RGB",{Text="RGB Cycle",Default=false,Callback=function(v) RV.Config.Aura.RGB=v end})
AUL:AddSlider("Aura_Int",{Text="Intensity",Default=1,Min=0.3,Max=2,Rounding=1,Callback=function(v) RV.Config.Aura.Intensity=v; local ch=LP.Character; if ch then RV.BuildAura(ch) end end})
AUL:AddSlider("Aura_Size",{Text="Size",Default=1,Min=0.6,Max=1.8,Rounding=1,Callback=function(v) RV.Config.Aura.Size=v; local ch=LP.Character; if ch then RV.BuildAura(ch) end end})
AUL:AddToggle("Aura_Ring",{Text="Ring",Default=true,Callback=function(v) RV.Config.Aura.Ring=v; local ch=LP.Character; if ch then RV.BuildAura(ch) end end})
AUL:AddToggle("Aura_Trail",{Text="Limb Trails",Default=true,Callback=function(v) RV.Config.Aura.Trail=v; local ch=LP.Character; if ch then RV.BuildAura(ch) end end})
AUL:AddToggle("Aura_Pulse",{Text="Pulse",Default=true,Callback=function(v) RV.Config.Aura.Pulse=v end})
AUL:AddButton("Rebuild Aura",function() local ch=LP.Character; if ch then RV.BuildAura(ch) end end)
local CHL = VT:AddRightGroupbox("Crosshair")
BT(CHL,"CH_On","Custom Crosshair",false,function(v) RV.Config.Crosshair.Enabled=v end)
CHL:AddToggle("CH_DisGame",{Text="Disable Game Crosshair",Default=false,Callback=function(v) RV.Config.Crosshair.DisableGame=v end})
CHL:AddSlider("CH_Size",{Text="Size",Default=17,Min=4,Max=40,Rounding=0,Callback=function(v) RV.Config.Crosshair.Size=v end})
CHL:AddSlider("CH_Gap",{Text="Gap",Default=8,Min=0,Max=30,Rounding=0,Callback=function(v) RV.Config.Crosshair.Gap=v end})
CHL:AddSlider("CH_Thick",{Text="Thickness",Default=1,Min=1,Max=6,Rounding=0,Callback=function(v) RV.Config.Crosshair.Thick=v end})
CHL:AddToggle("CH_RGB",{Text="RGB",Default=true,Callback=function(v) RV.Config.Crosshair.RGB=v end})
CHL:AddSlider("CH_RotSpd",{Text="Rotation Speed",Default=150,Min=0,Max=500,Rounding=0,Callback=function(v) RV.Config.Crosshair.RotSpeed=v end})
CHL:AddToggle("CH_Pulse",{Text="Pulse",Default=true,Callback=function(v) RV.Config.Crosshair.Pulse=v end})
CHL:AddToggle("CH_Follow",{Text="Follow Mouse",Default=true,Callback=function(v) RV.Config.Crosshair.FollowMouse=v end})
CHL:AddToggle("CH_Label",{Text="Show Label",Default=true,Callback=function(v) RV.Config.Crosshair.Label=v end})
CHL:AddInput("CH_LabelTxt",{Text="Label Text",Default="uncode",Placeholder="text...",ClearTextOnFocus=false,Callback=function(v) RV.Config.Crosshair.LabelText=v end})
local ESL = VT:AddLeftGroupbox("Full ESP")
BT(ESL,"RVFULL_ESP","Full ESP",false,function(v)
RV.Config.ESP.Box=v; RV.Config.ESP.Name=v; RV.Config.ESP.Healthbar=v; RV.Config.ESP.Distance=v
end)
ESL:AddToggle("RVESP_Box",{Text="Corner Box",Default=false,Callback=function(v) RV.Config.ESP.Box=v end})
ESL:AddToggle("RVESP_Outline",{Text="Outline / Highlight",Default=false,Callback=function(v) RV.Config.ESP.Outline=v end})
ESL:AddToggle("RVESP_Name",{Text="Name",Default=true,Callback=function(v) RV.Config.ESP.Name=v end})
ESL:AddToggle("RVESP_HP",{Text="Health Bar",Default=true,Callback=function(v) RV.Config.ESP.Healthbar=v end})
ESL:AddToggle("RVESP_Dist",{Text="Distance",Default=true,Callback=function(v) RV.Config.ESP.Distance=v end})
ESL:AddToggle("RVESP_Weap",{Text="Weapon",Default=false,Callback=function(v) RV.Config.ESP.Weapon=v end})
ESL:AddToggle("RVESP_WM",{Text="Watermark",Default=false,Callback=function(v) RV.Config.ESP.Watermark=v end})
ESL:AddInput("RVESP_WMTxt",{Text="Watermark Text",Default="uncode",ClearTextOnFocus=false,Callback=function(v) RV.Config.ESP.WatermarkText=v end})
ESL:AddSlider("RVESP_MaxD",{Text="Max Distance",Default=1200,Min=100,Max=3000,Rounding=0,Callback=function(v) RV.Config.ESP.MaxDistance=v end})
ESL:AddDropdown("RVESP_NameType",{Text="Name Type",Default="DisplayName",Values={"Name","DisplayName","Both"},Callback=function(v) RV.Config.ESP.NameType=v end})
ESL:AddToggle("RVESP_Team",{Text="Include Teammates",Default=false,Callback=function(v) RV.Config.ESP.IncludeTeam=v end})
local HFL = VT:AddRightGroupbox("Hit FX / Tracers")
BT(HFL,"HitFX_On","Hit FX",false,function(v) RV.Config.HitFX.Enabled=v end)
HFL:AddDropdown("HitFX_Sel",{Text="FX Style",Default="fortnite damage",Values={"fortnite damage","ForceField clone"},Callback=function(v) RV.Config.HitFX.Selected=v end})
HFL:AddDropdown("HitFX_Mat",{Text="Clone Material",Default="ForceField",Values={"ForceField","Neon","Glass"},Callback=function(v) RV.Config.HitFX.Material=v end})
HFL:AddToggle("HitFX_NoDmg",{Text="No Damage Numbers",Default=false,Callback=function(v) RV.Config.HitFX.DisableNumbers=v end})
HFL:AddDivider()
HFL:AddDropdown("HitSnd_Sel",{Text="Hit Sound",Default="bell",Values={"bell","pop","tick","fortnite"},Callback=function(v) RV.Config.HitSound.Selected=v end})
HFL:AddSlider("HitSnd_Vol",{Text="Volume",Default=5,Min=0,Max=10,Rounding=1,Callback=function(v) RV.Config.HitSound.Volume=v end})
HFL:AddSlider("HitSnd_Pit",{Text="Pitch",Default=1,Min=0.5,Max=2,Rounding=1,Callback=function(v) RV.Config.HitSound.Pitch=v end})
HFL:AddDivider()
BT(HFL,"Tracers_On","Tracers",false,function(v) RV.Config.Tracers.Enabled=v end)
HFL:AddDropdown("Tracers_Style",{Text="Tracer Style",Default="trail",Values={"trail","beam","glow","energy"},Callback=function(v) RV.Config.Tracers.Selected=v end})
HFL:AddSlider("Tracers_Fade",{Text="Fade",Default=0.4,Min=0.05,Max=2,Rounding=2,Callback=function(v) RV.Config.Tracers.Fade=v end})
HFL:AddSlider("Tracers_Glow",{Text="Glow",Default=5,Min=0,Max=10,Rounding=1,Callback=function(v) RV.Config.Tracers.Glow=v end})
HFL:AddSlider("Tracers_Size",{Text="Size",Default=1,Min=0.5,Max=5,Rounding=1,Callback=function(v) RV.Config.Tracers.Size=v end})
local HUD = VT:AddLeftGroupbox("Target HUD")
BT(HUD,"HUD_On","Target HUD",false,function(v) RV.Config.TargetHUD.Enabled=v end)
HUD:AddSlider("HUD_OffX",{Text="Position X %",Default=17,Min=0,Max=100,Rounding=0,Callback=function(v) RV.Config.TargetHUD.OffX=v end})
HUD:AddSlider("HUD_OffY",{Text="Position Y %",Default=70,Min=0,Max=100,Rounding=0,Callback=function(v) RV.Config.TargetHUD.OffY=v end})
HUD:AddSlider("HUD_UIScale",{Text="UI Scale %",Default=170,Min=50,Max=300,Rounding=0,Callback=function(v) RV.Config.TargetHUD.UIScale=v end})
local WL = VT:AddRightGroupbox("World Extended")
BT(WL,"W_CC","Color Correction",false,function(v) RV.Config.World.CC_Enabled=v; RV.ApplyWorld() end)
WL:AddSlider("W_Sat",{Text="Saturation",Default=0.1,Min=-1,Max=1,Rounding=2,Callback=function(v) RV.Config.World.Saturation=v; RV.ApplyWorld() end})
WL:AddSlider("W_Con",{Text="Contrast",Default=0,Min=-1,Max=1,Rounding=2,Callback=function(v) RV.Config.World.Contrast=v; RV.ApplyWorld() end})
WL:AddSlider("W_Bri",{Text="Brightness",Default=0,Min=-1,Max=1,Rounding=2,Callback=function(v) RV.Config.World.Brightness=v; RV.ApplyWorld() end})
BT(WL,"W_Bloom","Bloom",false,function(v) RV.Config.World.Bloom=v; RV.ApplyWorld() end)
WL:AddSlider("W_BInt",{Text="Bloom Intensity",Default=0.1,Min=0,Max=2,Rounding=2,Callback=function(v) RV.Config.World.BInt=v; RV.ApplyWorld() end})
BT(WL,"W_SunRays","Sun Rays",false,function(v) RV.Config.World.SunRays=v; RV.ApplyWorld() end)
BT(WL,"W_Sky","Custom Sky",false,function(v) RV.Config.World.Sky=v; RV.ApplyWorld() end)
WL:AddDropdown("W_SkyPreset",{Text="Sky Preset",Default="Vertical Milky Way",Values={"Vertical Milky Way","Night Stars","Clean Day"},Callback=function(v) RV.Config.World.SkySelected=v; RV.ApplyWorld() end})
WL:AddButton("Apply World",function() RV.ApplyWorld(); Notify("World applied",2) end)
WL:AddButton("Restore World",function() RV.RestoreWorld(); Notify("World restored",2) end)
local VML = VT:AddLeftGroupbox("Viewmodel Override")
BT(VML,"VM_On","Override Viewmodel",false,function(v) RV.Config.Viewmodel.OverrideEnabled=v; RV.ApplyViewmodelOverride() end)
VML:AddDropdown("VM_Mat",{Text="Weapon Material",Default="Neon",Values={"Neon","SmoothPlastic","ForceField","Glass","Metal","DiamondPlate"},Callback=function(v) RV.Config.Viewmodel.VMMaterial=v; if RV.Config.Viewmodel.OverrideEnabled then RV.ApplyViewmodelOverride() end end})
VML:AddSlider("VM_Trans",{Text="Weapon Transparency",Default=95,Min=0,Max=100,Rounding=0,Callback=function(v) RV.Config.Viewmodel.VMTrans=v; if RV.Config.Viewmodel.OverrideEnabled then RV.ApplyViewmodelOverride() end end})
VML:AddToggle("VM_Wire",{Text="Wireframe",Default=false,Callback=function(v) RV.Config.Viewmodel.VMWireframe=v; if RV.Config.Viewmodel.OverrideEnabled then RV.ApplyViewmodelOverride() end end})
VML:AddDropdown("VM_ArmMat",{Text="Arm Material",Default="Neon",Values={"Neon","SmoothPlastic","ForceField","Glass","Metal"},Callback=function(v) RV.Config.Viewmodel.ArmMaterial=v; if RV.Config.Viewmodel.OverrideEnabled then RV.ApplyViewmodelOverride() end end})
VML:AddSlider("VM_ArmTrans",{Text="Arm Transparency",Default=32,Min=0,Max=100,Rounding=0,Callback=function(v) RV.Config.Viewmodel.ArmTrans=v; if RV.Config.Viewmodel.OverrideEnabled then RV.ApplyViewmodelOverride() end end})
VML:AddButton("Apply Now",function() RV.ApplyViewmodelOverride(); Notify("Viewmodel applied",2) end)
local APL = VT:AddRightGroupbox("Appearance / Unlock")
BT(APL,"App_On","Self Appearance",false,function(v) RV.Config.Appearance.Enabled=v; if v then RV.ApplyAppearance() end end)
APL:AddDropdown("App_Mat",{Text="Material",Default="ForceField",Values={"ForceField","Neon","Glass","SmoothPlastic"},Callback=function(v) RV.Config.Appearance.Material=v; if RV.Config.Appearance.Enabled then RV.ApplyAppearance() end end})
APL:AddSlider("App_Trans",{Text="Transparency",Default=100,Min=0,Max=100,Rounding=0,Callback=function(v) RV.Config.Appearance.Transparency=v; if RV.Config.Appearance.Enabled then RV.ApplyAppearance() end end})
APL:AddToggle("App_NoDecal",{Text="Remove Clothing",Default=false,Callback=function(v) RV.Config.Appearance.NoDecal=v end})
APL:AddDivider()
BT(APL,"RV_Unlock","Unlock All (Full System)",false,function(v)
RV.Unlock.active=v
if v then Notify("Unlock All: Active (full system)",3) end
end)
APL:AddLabel("Hooks CosLib+DataCtrl+__namecall")
APL:AddLabel("Supports Skin/Wrap/Charm/Dance")
end)
Notify("RV Visuals Ready . Aura/Crosshair/ESP/HitFX/Tracers/UnlockAll",4)
local _UCEngine
do
local _loadOk, _loadErr = pcall(function()
_UCEngine = (function()
local RS_  = game:GetService("ReplicatedStorage")
local PL_  = game:GetService("Players")
local RN_  = game:GetService("RunService")
local UI_  = game:GetService("UserInputService")
local LP_  = PL_.LocalPlayer
local WS_  = workspace
local CG_  = game:GetService("CoreGui")
local _util, _enums
pcall(function() _util  = require(cloneref(RS_).Modules.Utility)    end)
pcall(function() _enums = require(cloneref(RS_).Modules.EnumLibrary) end)
local _pool = {}
local function _conn(key, c)
if not _pool[key] then _pool[key] = {} end
table.insert(_pool[key], c)
return c
end
local function _stop(key)
for _, c in ipairs(_pool[key] or {}) do
pcall(function() c:Disconnect() end)
end
_pool[key] = {}
end
local function _char()  return LP_.Character end
local function _root()
local c = _char(); return c and c:FindFirstChild("HumanoidRootPart")
end
local function _hum()
local c = _char(); return c and c:FindFirstChildOfClass("Humanoid")
end
local function _alive()
local c = _char()
local h = c and c:FindFirstChildOfClass("Humanoid")
return h and h.Health > 0 and c:FindFirstChild("HumanoidRootPart") ~= nil
end
local function _enemies()
local list = {}
for _, p in ipairs(PL_:GetPlayers()) do
if p ~= LP_ and p.Character then
local h = p.Character:FindFirstChildOfClass("Humanoid")
local r = p.Character:FindFirstChild("HumanoidRootPart")
if h and h.Health > 0 and r then table.insert(list, p) end
end
end
return list
end
local function _closestEnemy(fov)
fov = fov or 9999
local cam = WS_.CurrentCamera
local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
local best, bestD = nil, fov
for _, p in ipairs(_enemies()) do
local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
if hrp then
local sp, vis = cam:WorldToViewportPoint(hrp.Position)
if vis then
local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
if d < bestD then bestD = d; best = p end
end
end
end
return best
end
local _BONE_ORDER = {"Head","UpperTorso","LowerTorso","HumanoidRootPart"}
local function _getBone(char)
if not char then return nil end
for _, name in ipairs(_BONE_ORDER) do
local b = char:FindFirstChild(name)
if b then return b end
end
return nil
end
local _velBuf = {}
local _velIdx = {}
local function _recordEnemy(p)
if not p or not p.Character then return end
local hrp = p.Character:FindFirstChild("HumanoidRootPart")
if not hrp then return end
if not _velBuf[p] then _velBuf[p] = {}; _velIdx[p] = 0 end
local idx = (_velIdx[p] % 6) + 1
_velIdx[p] = idx
_velBuf[p][idx] = {pos = hrp.Position, t = tick()}
end
local function _predictPos(p, bone)
bone = bone or (p and p.Character and _getBone(p.Character))
if not bone then return nil end
local buf = _velBuf[p]
if not buf then return bone.Position end
local oldest, newest = nil, nil
for i = 1, 6 do
local e = buf[i]
if e then
if not oldest or e.t < oldest.t then oldest = e end
if not newest or e.t > newest.t then newest = e end
end
end
if oldest and newest then
local dT = newest.t - oldest.t
if dT > 0.01 then
local vel = (newest.pos - oldest.pos) / dT
local lag = tick() - newest.t
return bone.Position + vel * (lag + 0.05)
end
end
return bone.Position
end
local _useItemRemote = nil
local _origFS = nil
local _saHooked = false
local _hnHooked = false
local function _getRemote()
if _useItemRemote then return _useItemRemote end
pcall(function()
local rp = cloneref(RS_)
_useItemRemote = rp.Remotes.Replication.Fighter.UseItem
end)
return _useItemRemote
end
local function _buildCamData(fromPos, bone, predPos)
if not _util or not bone then return nil end
predPos = predPos or bone.Position
local look = CFrame.new(fromPos, predPos)
local ok, data = pcall(function()
local d = {}
d[utf8.char(1)] = {
[utf8.char(0)] = _util:EncodeCFrame(look),
[utf8.char(1)] = _util:EncodeCFrame(look),
[utf8.char(2)] = bone,
[utf8.char(3)] = _util:EncodeCFrame(
bone.CFrame:ToObjectSpace(CFrame.new(predPos))
),
}
return d
end)
return ok and data or nil
end
local _startShoot = nil
local function _getStartShoot()
if not _startShoot then
pcall(function()
if _enums then _startShoot = _enums:ToEnum("StartShooting") end
end)
end
return _startShoot
end
local SilentShot = {}
SilentShot.Enabled = false
SilentShot.FOV     = 120
function SilentShot.enable()
if _saHooked then SilentShot.Enabled = true; return end
local remote = _getRemote()
if not remote or not hookfunction or not newcclosure then return end
_conn("SilentShot_vel", RN_.Heartbeat:Connect(function()
if not SilentShot.Enabled then return end
local enemy = _closestEnemy(SilentShot.FOV)
if enemy then _recordEnemy(enemy) end
end))
local ok, orig = pcall(function()
local old
old = hookfunction(remote.FireServer, newcclosure(function(self, obj, action, camdata, ...)
if SilentShot.Enabled and action == _getStartShoot() then
local cam = WS_.CurrentCamera
local enemy = _closestEnemy(SilentShot.FOV)
if enemy and enemy.Character then
local bone    = _getBone(enemy.Character)
local predPos = _predictPos(enemy, bone)
if bone and predPos then
local fromPos = cam and cam.CFrame.Position or bone.Position
local newData = _buildCamData(fromPos, bone, predPos)
if newData then camdata = newData end
end
end
end
return old(self, obj, action, camdata, ...)
end))
_origFS = old
return old
end)
if ok then _saHooked = true; SilentShot.Enabled = true end
end
function SilentShot.disable()
SilentShot.Enabled = false
_stop("SilentShot_vel")
end
local AimSmooth = {}
AimSmooth.Enabled = false
AimSmooth.Speed   = 6
AimSmooth.FOV     = 150
function AimSmooth.enable()
AimSmooth.Enabled = true
_conn("AimSmooth", RN_.RenderStepped:Connect(function(dt)
if not AimSmooth.Enabled then return end
if not mousemoverel then return end
local enemy = _closestEnemy(AimSmooth.FOV)
if not enemy or not enemy.Character then return end
local bone = _getBone(enemy.Character)
if not bone then return end
local cam = WS_.CurrentCamera
local facing = cam.CFrame.LookVector
local dir    = (bone.Position - cam.CFrame.Position).Unit
if dir == Vector3.zero then return end
local sens = UserSettings():GetService("UserGameSettings").MouseSensitivity
local moveC = Vector2.new(1, 0.77) * math.rad(0.5)
local dyaw   = math.atan2(facing.X,facing.Z) - math.atan2(dir.X,dir.Z)
dyaw = ((dyaw + math.pi) % (2*math.pi)) - math.pi
local dpitch = math.asin(math.clamp(facing.Y,-1,1)) - math.asin(math.clamp(dir.Y,-1,1))
local alpha  = 1 - math.exp(-AimSmooth.Speed * dt)
local angle  = Vector2.new(dyaw, dpitch) / (moveC * sens) * alpha
pcall(mousemoverel, angle.X, angle.Y)
end))
end
function AimSmooth.disable()
AimSmooth.Enabled = false
_stop("AimSmooth")
end
local AutoShoot = {}
AutoShoot.Enabled = false
AutoShoot.Delay   = 0.08
local _asFrames = 0
local _asRay = RaycastParams.new()
_asRay.FilterType = Enum.RaycastFilterType.Exclude
local _asOffsets = {
Vector2.new(0, 0),
Vector2.new(0,-8), Vector2.new(0, 8),
Vector2.new(-8,0), Vector2.new(8, 0),
}
local function _asHitEnemy(cam, c, cx, cy)
for _, off in ipairs(_asOffsets) do
local ray = cam:ViewportPointToRay(cx + off.X, cy + off.Y)
_asRay.FilterDescendantsInstances = {c, cam}
local hit = workspace:Raycast(ray.Origin, ray.Direction * 250, _asRay)
if hit then
local node = hit.Instance
while node and node ~= workspace do
local h = node:IsA("Model") and node:FindFirstChildOfClass("Humanoid")
if h and h.Health > 0 then
local plr = PL_:GetPlayerFromCharacter(node)
if plr and plr ~= LP_ then return true end
break
end
node = node.Parent
end
end
end
return false
end
function AutoShoot.enable()
AutoShoot.Enabled = true
_asFrames = 0
_conn("AutoShoot", RN_.Heartbeat:Connect(function(dt)
if not AutoShoot.Enabled then return end
_asFrames = _asFrames + dt
if _asFrames < AutoShoot.Delay then return end
local cam = WS_.CurrentCamera
local c = _char()
if not c or not cam then return end
local vp = cam.ViewportSize
local cx, cy = vp.X/2, vp.Y/2
if _asHitEnemy(cam, c, cx, cy) then
_asFrames = 0
pcall(function() if mouse1click then mouse1click() end end)
end
end))
end
function AutoShoot.disable()
AutoShoot.Enabled = false
_asFrames = 0
_stop("AutoShoot")
end
local BurstFire = {}
BurstFire.Enabled = false
BurstFire.Rate    = 0.05
local _bfAccum = 0
function BurstFire.enable()
BurstFire.Enabled = true
_bfAccum = 0
_conn("BurstFire", RN_.Heartbeat:Connect(function(dt)
if not BurstFire.Enabled then return end
_bfAccum = _bfAccum + dt
if _bfAccum < BurstFire.Rate then return end
_bfAccum = 0
pcall(function() if mouse1click then mouse1click() end end)
end))
end
function BurstFire.disable()
BurstFire.Enabled = false
_bfAccum = 0
_stop("BurstFire")
end
local MaxMode = {}
MaxMode.Enabled = false
function MaxMode.enable()
MaxMode.Enabled = true
SilentShot.FOV = 350;  SilentShot.enable()
AimSmooth.Speed = 12; AimSmooth.FOV = 350; AimSmooth.enable()
AutoShoot.Delay = 0.03; AutoShoot.enable()
BurstFire.Rate  = 0.03; BurstFire.enable()
end
function MaxMode.disable()
MaxMode.Enabled = false
SilentShot.disable()
AimSmooth.disable()
AutoShoot.disable()
BurstFire.disable()
SilentShot.FOV = 120
AimSmooth.Speed = 6; AimSmooth.FOV = 150
AutoShoot.Delay = 0.08
BurstFire.Rate  = 0.05
end
local SkinSwap = {}
SkinSwap.Enabled = false
SkinSwap.Preset  = "neon_red"
local _skinPresets = {
neon_red   = {color = Color3.fromRGB(255, 50,  50),  mat = Enum.Material.Neon},
neon_blue  = {color = Color3.fromRGB( 50, 100, 255), mat = Enum.Material.Neon},
neon_green = {color = Color3.fromRGB( 50, 255,  80), mat = Enum.Material.Neon},
chrome     = {color = Color3.fromRGB(180, 200, 220), mat = Enum.Material.SmoothPlastic},
gold       = {color = Color3.fromRGB(255, 200,  40), mat = Enum.Material.SmoothPlastic},
}
local _skinOrig = {}
local _skinHue  = 0
local function _applySkin(col, mat)
local c = _char(); if not c then return end
for _, p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") then
if not _skinOrig[p] then
_skinOrig[p] = {color = p.Color, mat = p.Material}
end
pcall(function() p.Color = col; p.Material = mat end)
end
end
end
local function _restoreSkin()
for p, orig in pairs(_skinOrig) do
pcall(function() p.Color = orig.color; p.Material = orig.mat end)
end
table.clear(_skinOrig)
end
local function _skinApplyPreset()
local pr = _skinPresets[SkinSwap.Preset]
if pr then _applySkin(pr.color, pr.mat) end
end
function SkinSwap.enable()
SkinSwap.Enabled = true
if SkinSwap.Preset ~= "rainbow" then _skinApplyPreset() end
_conn("SkinSwap", RN_.Heartbeat:Connect(function(dt)
if not SkinSwap.Enabled then return end
if SkinSwap.Preset == "rainbow" then
_skinHue = (_skinHue + dt * 0.25) % 1
local col = Color3.fromHSV(_skinHue, 1, 1)
local c = _char(); if not c then return end
for _, p in ipairs(c:GetDescendants()) do
if p:IsA("BasePart") then
if not _skinOrig[p] then
_skinOrig[p] = {color = p.Color, mat = p.Material}
end
pcall(function() p.Color = col; p.Material = Enum.Material.Neon end)
end
end
end
end))
_conn("SkinSwap", LP_.CharacterAdded:Connect(function()
task.wait(0.5)
if not SkinSwap.Enabled then return end
table.clear(_skinOrig)
if SkinSwap.Preset ~= "rainbow" then _skinApplyPreset() end
end))
end
function SkinSwap.disable()
SkinSwap.Enabled = false
_stop("SkinSwap")
_restoreSkin()
end
local FLY = {}
FLY.Enabled = false
FLY.Speed   = 60
local _flyGyro, _flyVel
local _fw, _fb, _fl, _fr, _fu, _fd = 0,0,0,0,0,0
local function _flyClean()
pcall(function() if _flyGyro then _flyGyro:Destroy() end end)
pcall(function() if _flyVel  then _flyVel:Destroy()  end end)
_flyGyro, _flyVel = nil, nil
_fw,_fb,_fl,_fr,_fu,_fd = 0,0,0,0,0,0
pcall(function()
local h = _hum(); if h then h.PlatformStand = false end
WS_.CurrentCamera.CameraType = Enum.CameraType.Custom
end)
end
local function _flyStart()
_flyClean()
if not _alive() then return end
local root = _root(); if not root then return end
_flyGyro = Instance.new("BodyGyro")
_flyGyro.P = 9e4; _flyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
_flyGyro.CFrame = root.CFrame; _flyGyro.Parent = root
_flyVel = Instance.new("BodyVelocity")
_flyVel.MaxForce = Vector3.new(9e9,9e9,9e9); _flyVel.Velocity = Vector3.zero
_flyVel.Parent = root
local h = _hum(); if h then h.PlatformStand = true end
end
local function _flyKey(inp, on)
if UI_:GetFocusedTextBox() then return end
local k = inp.KeyCode
if     k==Enum.KeyCode.W then _fw = on and 1 or 0
elseif k==Enum.KeyCode.S then _fb = on and 1 or 0
elseif k==Enum.KeyCode.A then _fl = on and 1 or 0
elseif k==Enum.KeyCode.D then _fr = on and 1 or 0
elseif k==Enum.KeyCode.Space or k==Enum.KeyCode.E then _fu = on and 1 or 0
do
local _S=getgenv()
_S._UC_AimSmooth=AimSmooth
_S._UC_AutoShoot=AutoShoot
_S._UC_BurstFire=BurstFire
_S._UC_CG_=CG_
_S._UC_Debris=Debris
_S._UC_FLY=FLY
_S._UC_LP_=LP_
_S._UC_MaxMode=MaxMode
_S._UC_PL_=PL_
_S._UC_RN_=RN_
_S._UC_SilentShot=SilentShot
_S._UC_SkinSwap=SkinSwap
_S._UC_UI_=UI_
_S._UC_WS_=WS_
_S._UC__UCEngine=_UCEngine
_S._UC__fb=_fb
_S._UC__fd=_fd
_S._UC__fl=_fl
_S._UC__flyGyro=_flyGyro
_S._UC__flyVel=_flyVel
_S._UC__fr=_fr
_S._UC__fu=_fu
_S._UC__fw=_fw
_S._UC__hnHooked=_hnHooked
_S._UC__loadErr=_loadErr
_S._UC__loadOk=_loadOk
_S._UC__ucBoxes=_ucBoxes
_S._UC_a0=a0
_S._UC_a1=a1
_S._UC_box=box
_S._UC_cam=cam
_S._UC_char=char
_S._UC_col=col
_S._UC_dist=dist
_S._UC_enemy=enemy
_S._UC_fade=fade
_S._UC_hp=hp
_S._UC_hrp=hrp
_S._UC_hum=hum
_S._UC_old=old
_S._UC_orig=orig
_S._UC_remote=remote
_S._UC_result=result
_S._UC_root=root
_S._UC_tr=tr
_S._UC_vis=vis
_S._UC_vp=vp
end
local _ns=game:HttpGet("https://raw.githubusercontent.com/57040suda-haruki-cloud/uncode/main/uncodeE.lua",true)
writefile("uncodeE.lua",_ns)
dofile("uncodeE.lua")