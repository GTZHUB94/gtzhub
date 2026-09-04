local _0x={
 [1]="HttpService",
 [2]="Players",
 [3]="CoreGui",
 [4]="PlayerGui",
 [5]="GustavoHubKey",
 [6]="GTZ HUB",
 [7]="Enter your key...",
 [8]="VALIDATE KEY",
 [9]="Validating...",
 [10]="Enter a key.",
 [11]="https://gustavo-hub-api.errpila.workers.dev",
 [12]="application/json",
 [13]="no-cache",
 [14]="GET",
 [15]="POST",
 [16]="/validate",
 [17]="/script",
 [18]="key",
 [19]="token",
 [20]="valid",
 [21]="success",
 [22]="script",
 [23]="server_error",
 [24]="missing_key",
 [25]="invalid_session",
 [26]="GUSTAVO_HUB_KEY",
 [27]="GUSTAVO_HUB_TOKEN"
}

local function _s(n)
 return _0x[n]
end

local _g=game
local _pc=pcall
local _ts=tostring
local _ty=type

local _LOGO="rbxassetid://125548024440666"

local _H=_g:GetService(_s(1))
local _P=_g:GetService(_s(2))
local _A=_s(11)

local function _rq()
 if _ty(request)=="function" then
  return request
 end

 if _ty(http_request)=="function" then
  return http_request
 end

 if syn and _ty(syn.request)=="function" then
  return syn.request
 end

 if fluxus and _ty(fluxus.request)=="function" then
  return fluxus.request
 end

 return nil
end

local _r=_rq()

if not _r then
 warn("GTZ HUB: HTTP unavailable.")
 return
end

local function _http(_m,_u,_b)
 local _o={
  Url=_u,
  Method=_m,
  Headers={
   ["Accept"]=_s(12),
   ["Cache-Control"]=_s(13)
  }
 }

 if _b then
  _o.Headers["Content-Type"]=_s(12)
  _o.Body=_H:JSONEncode(_b)
 end

 local _ok,_res=_pc(function()
  return _r(_o)
 end)

 if not _ok or not _res then
  return nil
 end

 local _st=tonumber(
  _res.StatusCode or
  _res.Status or
  0
 )

 local _body=
  _res.Body or
  _res.body

 if not _body then
  return nil
 end

 local _dok,_data=_pc(function()
  return _H:JSONDecode(_body)
 end)

 if not _dok or _ty(_data)~="table" then
  return nil
 end

 return _data
end

local function _key()
 if getgenv then
  local _v=getgenv()[_s(26)]

  if _ty(_v)=="string" and _v~="" then
   return _v
  end
 end

 return nil
end

local function _gui()
 local _pl=_P.LocalPlayer

 if not _pl then
  return nil
 end

 local _old

 _pc(function()
  _old=
   _g:GetService(_s(3)):FindFirstChild(_s(5))
 end)

 if _old then
  _old:Destroy()
 end

 local _q=Instance.new("ScreenGui")

 _q.Name=_s(5)
 _q.ResetOnSpawn=false
 _q.IgnoreGuiInset=true

 local _parent

 _pc(function()
  _parent=_g:GetService(_s(3))
 end)

 if not _parent then
  _parent=_pl:WaitForChild(_s(4))
 end

 _q.Parent=_parent

 local _f=Instance.new("Frame")

 _f.Size=UDim2.fromOffset(420,420)
 _f.Position=UDim2.new(.5,-210,.5,-210)
 _f.BackgroundColor3=Color3.fromRGB(20,20,20)
 _f.BorderSizePixel=0
 _f.Parent=_q

 local _background=Instance.new("ImageLabel")

 _background.Size=UDim2.fromScale(1,1)
 _background.BackgroundTransparency=1
 _background.Image=_LOGO
 _background.ScaleType=Enum.ScaleType.Crop
 _background.ZIndex=0
 _background.Parent=_f

 local _overlay=Instance.new("Frame")

 _overlay.Size=UDim2.fromScale(1,1)
 _overlay.BackgroundColor3=Color3.fromRGB(8,4,12)
 _overlay.BackgroundTransparency=.45
 _overlay.BorderSizePixel=0
 _overlay.ZIndex=1
 _overlay.Parent=_f

 local _fc=Instance.new("UICorner")

 _fc.CornerRadius=UDim.new(0,12)
 _fc.Parent=_f

 local _logo=Instance.new("ImageLabel")

 _logo.Size=UDim2.fromOffset(72,72)
 _logo.Position=UDim2.new(.5,-36,0,18)
 _logo.BackgroundTransparency=1
 _logo.Image=_LOGO
 _logo.ScaleType=Enum.ScaleType.Fit
 _logo.ZIndex=2
 _logo.Parent=_f

 local _t=Instance.new("TextLabel")

 _t.Size=UDim2.new(1,-40,0,40)
 _t.Position=UDim2.fromOffset(20,92)
 _t.BackgroundTransparency=1
 _t.Text=_s(6)
 _t.TextColor3=Color3.new(1,1,1)
 _t.Font=Enum.Font.GothamBold
 _t.TextSize=24
 _t.ZIndex=2
 _t.Parent=_f

 local _b=Instance.new("TextBox")

 _b.Size=UDim2.new(1,-40,0,45)
 _b.Position=UDim2.fromOffset(20,150)
 _b.BackgroundColor3=Color3.fromRGB(35,35,35)
 _b.BorderSizePixel=0
 _b.PlaceholderText=_s(7)
 _b.Text=""
 _b.TextColor3=Color3.new(1,1,1)
 _b.PlaceholderColor3=Color3.fromRGB(150,150,150)
 _b.Font=Enum.Font.Gotham
 _b.TextSize=15
 _b.ClearTextOnFocus=false
 _b.ZIndex=2
 _b.Parent=_f

 local _bc=Instance.new("UICorner")

 _bc.CornerRadius=UDim.new(0,8)
 _bc.Parent=_b

 local _x=Instance.new("TextButton")

 _x.Size=UDim2.new(1,-40,0,42)
 _x.Position=UDim2.fromOffset(20,210)
 _x.BackgroundColor3=Color3.fromRGB(150,45,235)
 _x.BorderSizePixel=0
 _x.Text=_s(8)
 _x.TextColor3=Color3.new(1,1,1)
 _x.Font=Enum.Font.GothamBold
 _x.TextSize=15
 _x.ZIndex=2
 _x.Parent=_f

 local _xc=Instance.new("UICorner")

 _xc.CornerRadius=UDim.new(0,8)
 _xc.Parent=_x

 local _z=Instance.new("TextLabel")

 _z.Size=UDim2.new(1,-40,0,25)
 _z.Position=UDim2.fromOffset(20,260)
 _z.BackgroundTransparency=1
 _z.Text=""
 _z.TextColor3=Color3.new(1,1,1)
 _z.Font=Enum.Font.Gotham
 _z.TextSize=13
 _z.ZIndex=2
 _z.Parent=_f

 local _result

 _x.MouseButton1Click:Connect(function()
  local _v=tostring(_b.Text or "")
   :gsub("^%s+","")
   :gsub("%s+$","")

  if _v=="" then
   _z.Text=_s(10)
   return
  end

  _z.Text=_s(9)
  _result=_v
 end)

 while not _result do
  task.wait()
 end

 _q:Destroy()

 return _result
end

local _k=_gui()

if not _k then
 warn("GTZ HUB: key not found.")
 return
end

_k=tostring(_k)
 :gsub("^%s+","")
 :gsub("%s+$","")
 :upper()

local _localPlayer=_P.LocalPlayer

local _username=
 _localPlayer and
 tostring(_localPlayer.Name) or
 "Unknown"

local _userId=
 _localPlayer and
 tostring(_localPlayer.UserId) or
 "Unknown"

local _gameName="Unknown game"
local _placeId="Unknown"

_pc(function()
 _placeId=tostring(_g.PlaceId)
end)

_pc(function()
 local _m=_g:GetService("MarketplaceService")
 local _info=_m:GetProductInfo(_g.PlaceId)

 if _info and _info.Name then
  _gameName=tostring(_info.Name)
 end
end)

local _v=_http(
 _s(15),
 _A.._s(16),
 {
  key=_k,
  username=_username,
  userId=_userId,
  gameName=_gameName,
  placeId=_placeId
 }
)

if not _v or _v[_s(20)]~=true then
 warn(
  "GTZ HUB: key rejected ("..
  tostring(
   _v and
   _v.reason or
   _s(23)
  )..
  ")."
 )

 return
end

local _token=_v[_s(19)]

if _ty(_token)~="string" or _token=="" then
 warn("GTZ HUB: invalid session.")
 return
end

local _payload=_http(
 _s(15),
 _A.._s(17),
 {
  token=_token
 }
)

if not _payload or _payload[_s(21)]~=true then
 warn(
  "GTZ HUB: could not retrieve the script ("..
  tostring(
   _payload and
   _payload.reason or
   _s(23)
  )..
  ")."
 )

 return
end

local _code=_payload[_s(22)]

if _ty(_code)~="string" or _code=="" then
 warn("GTZ HUB: empty script.")
 return
end

if getgenv then
 getgenv()[_s(26)]=_k
 getgenv()[_s(27)]=_token
end

local _load=loadstring

if _ty(_load)~="function" then
 warn("GTZ HUB: loadstring unavailable.")
 return
end

if not _code:find(
 "GTZ_HUB_REMOTE_DISABLE",
 1,
 true
) then

 local _marker="local ESPObjects = {}"

 local _hook=[[
if getgenv then

 getgenv().GTZ_HUB_REMOTE_DISABLE=function()

  ScriptEnabled=false
  AimEnabled=false
  Aiming=false
  LockedTarget=nil

  pcall(function()
   if FOVCircle then
    FOVCircle.Visible=false
    FOVCircle:Remove()
   end
  end)

  pcall(function()
   if ESPObjects then
    for _,Data in pairs(ESPObjects) do
     for _,Object in pairs(Data) do
      pcall(function()
       Object:Remove()
      end)
     end
    end

    ESPObjects={}
   end
  end)

  pcall(function()
   if GUI then
    GUI:Destroy()
   end
  end)

 end

 getgenv().GTZ_HUB_REMOTE_PAUSE=function()

  if getgenv().GTZ_HUB_PAUSED then
   return
  end

  getgenv().GTZ_HUB_PAUSED=true
  getgenv().GTZ_HUB_PREV_AIM_ENABLED=AimEnabled

  AimEnabled=false
  Aiming=false
  LockedTarget=nil

  pcall(function()
   if FOVCircle then
    FOVCircle.Visible=false
   end
  end)

 end

 getgenv().GTZ_HUB_REMOTE_RESUME=function()

  if not getgenv().GTZ_HUB_PAUSED then
   return
  end

  getgenv().GTZ_HUB_PAUSED=false

  if getgenv().GTZ_HUB_PREV_AIM_ENABLED==true then
   AimEnabled=true
  end

 end

end
]]

 if _code:find(
  _marker,
  1,
  true
 ) then

  _code=_code:gsub(
   _marker,
   _marker.._hook,
   1
  )

 end

end

local _fn,_err=_load(_code)

if not _fn then
 warn(
  "GTZ HUB: error loading the script: "..
  tostring(_err)
 )

 return
end

task.spawn(function()
 local _ok,_runtime=_pc(_fn)

 if not _ok then
  warn(
   "GTZ HUB: error executing the script: "..
   tostring(_runtime)
  )
 end
end)

local _warningGui=nil

local function _destroyWarning()

 if _warningGui then
  _pc(function()
   _warningGui:Destroy()
  end)

  _warningGui=nil
 end

end

local function _showWarning(id,msg)

 if _warningGui then
  return
 end

 local parent

 _pc(function()
  parent=_g:GetService(_s(3))
 end)

 if not parent then
  parent=_localPlayer:WaitForChild(_s(4))
 end

 local sg=Instance.new("ScreenGui")

 sg.Name="GTZHubVerificationWarning"
 sg.ResetOnSpawn=false
 sg.IgnoreGuiInset=true
 sg.DisplayOrder=999999
 sg.Parent=parent

 local bg=Instance.new("Frame")

 bg.Size=UDim2.fromScale(1,1)
 bg.BackgroundColor3=Color3.fromRGB(0,0,0)
 bg.BackgroundTransparency=.25
 bg.Parent=sg

 local box=Instance.new("Frame")

 box.Size=UDim2.fromOffset(520,300)
 box.Position=UDim2.new(.5,-260,.5,-150)
 box.BackgroundColor3=Color3.fromRGB(24,18,30)
 box.BorderSizePixel=0
 box.Parent=sg

 local c=Instance.new("UICorner")

 c.CornerRadius=UDim.new(0,14)
 c.Parent=box

 local title=Instance.new("TextLabel")

 title.Size=UDim2.new(1,-40,0,45)
 title.Position=UDim2.fromOffset(20,18)
 title.BackgroundTransparency=1
 title.Text="GTZ HUB — VERIFICATION REQUIRED"
 title.TextColor3=Color3.new(1,1,1)
 title.Font=Enum.Font.GothamBold
 title.TextSize=22
 title.Parent=box

 local text=Instance.new("TextLabel")

 text.Size=UDim2.new(1,-50,0,170)
 text.Position=UDim2.fromOffset(25,72)
 text.BackgroundTransparency=1

 text.Text=
  msg..
  "\n\nSession ID: "..tostring(id)..
  "\n\nConfirm or refuse the verification in the GTZ HUB notifications Discord channel."

 text.TextColor3=Color3.fromRGB(235,235,235)
 text.Font=Enum.Font.Gotham
 text.TextSize=16
 text.TextWrapped=true
 text.Parent=box

 _warningGui=sg

end

task.spawn(function()

 local wasWarning=false

 while true do

  task.wait(3)

  local _state=_http(
   _s(14),
   _A.."/session?token="..
   _H:UrlEncode(_token)
  )

  if _state and _state[_s(20)]==true then

   if _state.warning==true then

    if not wasWarning then

     wasWarning=true

     _showWarning(
      _state.controlId or "UNKNOWN",
      _state.warningMessage or
       "Verification required."
     )

     if getgenv and
      _ty(getgenv().GTZ_HUB_REMOTE_PAUSE)=="function"
     then

      _pc(
       getgenv().GTZ_HUB_REMOTE_PAUSE
      )

     end

    end

   else

    if wasWarning then

     wasWarning=false

     _destroyWarning()

     if getgenv and
      _ty(getgenv().GTZ_HUB_REMOTE_RESUME)=="function"
     then

      _pc(
       getgenv().GTZ_HUB_REMOTE_RESUME
      )

     end

    end

   end

  elseif _state and
   _state[_s(20)]~=true
  then

   _destroyWarning()

   if getgenv then

    local _disable=
     getgenv().GTZ_HUB_REMOTE_DISABLE

    if _ty(_disable)=="function" then
     _pc(_disable)
    end

   end

   break

  end

 end

end)