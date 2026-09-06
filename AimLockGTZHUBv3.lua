local a=game:GetService("Players")
local b=game:GetService("HttpService")
local c=game:GetService("CoreGui")
local d=game:GetService("UserInputService")
local e=a.LocalPlayer
local f="https://gtz-hub-api.gtzhub94.workers.dev"

local function g()
	local h=(type(getgenv)=="function" and getgenv()) or _G
	local i={
		type(request)=="function" and request or nil,
		type(http_request)=="function" and http_request or nil,
		type(syn)=="table" and type(syn.request)=="function" and syn.request or nil,
		type(http)=="table" and type(http.request)=="function" and http.request or nil,
		type(fluxus)=="table" and type(fluxus.request)=="function" and fluxus.request or nil,
		type(krnl)=="table" and type(krnl.request)=="function" and krnl.request or nil,
		type(h)=="table" and type(h.request)=="function" and h.request or nil,
		type(h)=="table" and type(h.http_request)=="function" and h.http_request or nil
	}
	for _,j in ipairs(i) do
		if type(j)=="function" then
			return j
		end
	end
end

local k=g()

local function l(m,n,o)
	if not k then
		return nil,"HTTP"
	end

	local p={
		Url=m,
		Method=n,
		Headers={
			["Content-Type"]="application/json",
			["Cache-Control"]="no-store"
		}
	}

	if o~=nil then
		p.Body=b:JSONEncode(o)
	end

	local q,r=pcall(function()
		return k(p)
	end)

	if not q or type(r)~="table" then
		return nil,"REQUEST"
	end

	local s=tonumber(r.StatusCode or r.Status or 0) or 0
	local t=r.Body or r.body or ""
	local u

	pcall(function()
		u=b:JSONDecode(t)
	end)

	return{
		StatusCode=s,
		Body=t,
		Data=u
	}
end

local function v(w)
	if type(w)~="string" or w=="" then
		return false
	end

	local x=loadstring or load
	if type(x)~="function" then
		return false,"LOAD"
	end

	local y,z=pcall(function()
		return x(w)
	end)

	if not y or type(z)~="function" then
		return false,"COMPILE"
	end

	local A,B=pcall(z)

	if not A then
		return false,B
	end

	return true
end

local function C(D)
	pcall(function()
		if D then
			D:Destroy()
		end
	end)
end

local E
pcall(function()
	E=c
end)

if not E then
	E=e:WaitForChild("PlayerGui")
end

local F=E:FindFirstChild("GTZ_HUB_KEY_SYSTEM")
if F then
	C(F)
end

local G=Instance.new("ScreenGui")
G.Name="GTZ_HUB_KEY_SYSTEM"
G.ResetOnSpawn=false
G.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
G.Parent=E

local H=Instance.new("Frame")
H.Size=UDim2.new(0,430,0,250)
H.Position=UDim2.new(.5,-215,.5,-125)
H.BackgroundColor3=Color3.fromRGB(20,16,30)
H.BorderSizePixel=0
H.Parent=G

local I=Instance.new("UICorner")
I.CornerRadius=UDim.new(0,14)
I.Parent=H

local J=Instance.new("UIStroke")
J.Color=Color3.fromRGB(130,70,220)
J.Thickness=2
J.Transparency=.15
J.Parent=H

local K=Instance.new("Frame")
K.Size=UDim2.new(1,0,0,60)
K.BackgroundColor3=Color3.fromRGB(28,20,42)
K.BorderSizePixel=0
K.Parent=H

local L=Instance.new("UICorner")
L.CornerRadius=UDim.new(0,14)
L.Parent=K

local M=Instance.new("ImageLabel")
M.Size=UDim2.new(0,42,0,42)
M.Position=UDim2.new(0,10,0,9)
M.BackgroundTransparency=1
M.Image="rbxassetid://125548024440666"
M.Parent=K

local N=Instance.new("TextLabel")
N.Size=UDim2.new(1,-65,0,28)
N.Position=UDim2.new(0,60,0,8)
N.BackgroundTransparency=1
N.Text="GTZ HUB"
N.TextColor3=Color3.fromRGB(210,170,255)
N.Font=Enum.Font.GothamBold
N.TextSize=21
N.TextXAlignment=Enum.TextXAlignment.Left
N.Parent=K

local O=Instance.new("TextLabel")
O.Size=UDim2.new(1,-65,0,18)
O.Position=UDim2.new(0,60,0,34)
O.BackgroundTransparency=1
O.Text="Key Verification"
O.TextColor3=Color3.fromRGB(155,145,170)
O.Font=Enum.Font.Gotham
O.TextSize=12
O.TextXAlignment=Enum.TextXAlignment.Left
O.Parent=K

local P=Instance.new("TextBox")
P.Size=UDim2.new(1,-40,0,48)
P.Position=UDim2.new(0,20,0,82)
P.BackgroundColor3=Color3.fromRGB(30,24,43)
P.BorderSizePixel=0
P.PlaceholderText="Enter your key..."
P.PlaceholderColor3=Color3.fromRGB(115,105,130)
P.Text=""
P.TextColor3=Color3.fromRGB(235,225,245)
P.Font=Enum.Font.Gotham
P.TextSize=14
P.ClearTextOnFocus=false
P.Parent=H

local Q=Instance.new("UICorner")
Q.CornerRadius=UDim.new(0,9)
Q.Parent=P

local R=Instance.new("UIStroke")
R.Color=Color3.fromRGB(85,65,115)
R.Thickness=1
R.Parent=P

local S=Instance.new("TextButton")
S.Size=UDim2.new(1,-40,0,42)
S.Position=UDim2.new(0,20,0,142)
S.BackgroundColor3=Color3.fromRGB(110,55,190)
S.BorderSizePixel=0
S.Text="VERIFY KEY"
S.TextColor3=Color3.fromRGB(255,255,255)
S.Font=Enum.Font.GothamBold
S.TextSize=14
S.Parent=H

local T=Instance.new("UICorner")
T.CornerRadius=UDim.new(0,9)
T.Parent=S

local U=Instance.new("TextLabel")
U.Size=UDim2.new(1,-40,0,45)
U.Position=UDim2.new(0,20,0,194)
U.BackgroundTransparency=1
U.Text="Enter your key to continue."
U.TextColor3=Color3.fromRGB(155,145,170)
U.Font=Enum.Font.Gotham
U.TextSize=12
U.TextWrapped=true
U.Parent=H

local V=false
local W=false
local X
local Y

local function Z(aa,ab)
	U.Text=aa
	if ab then
		U.TextColor3=ab
	end
end

local function ac()
	if V then
		return
	end

	local ad=tostring(P.Text or ""):gsub("^%s+",""):gsub("%s+$","")

	if ad=="" then
		Z("Please enter a key.",Color3.fromRGB(255,120,120))
		return
	end

	V=true
	S.Text="VERIFYING..."
	S.Active=false
	S.AutoButtonColor=false

	Z("Contacting GTZ HUB server.",Color3.fromRGB(190,175,210))

	local ae
	local af

	pcall(function()
		ae=game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)

	ae=ae or "Unknown"

	af= l(
		f.."/validate",
		"POST",
		{
			key=ad,
			username=tostring(e.Name),
			userId=tostring(e.UserId),
			gameName=tostring(ae),
			placeId=tostring(game.PlaceId)
		}
	)

	local ag=af

	if not ag then
		V=false
		S.Text="VERIFY KEY"
		S.Active=true
		S.AutoButtonColor=true
		Z("Connection failed.",Color3.fromRGB(255,100,100))
		return
	end

	local ah=ag.Data

	if type(ah)~="table" then
		V=false
		S.Text="VERIFY KEY"
		S.Active=true
		S.AutoButtonColor=true
		Z("Invalid server response.",Color3.fromRGB(255,100,100))
		return
	end

	if ah.valid~=true then
		V=false
		S.Text="VERIFY KEY"
		S.Active=true
		S.AutoButtonColor=true

		local ai=tostring(ah.reason or "invalid_key")

		local aj={
			key_not_found="Key not found.",
			revoked="This key has been revoked.",
			expired="This key has expired.",
			already_used="This one-time key has already been used.",
			invalid_data="Invalid key data.",
			missing_key="Missing key."
		}

		Z(aj[ai] or "Key rejected.",Color3.fromRGB(255,100,100))
		return
	end

	local ak=ah.script

	if type(ak)~="string" or ak=="" then
		V=false
		S.Text="VERIFY KEY"
		S.Active=true
		S.AutoButtonColor=true
		Z("Script unavailable.",Color3.fromRGB(255,100,100))
		return
	end

	Z("Key accepted. Loading...",Color3.fromRGB(130,255,160))

	local al,am=v(ak)

	if not al then
		V=false
		S.Text="VERIFY KEY"
		S.Active=true
		S.AutoButtonColor=true
		Z("Failed to start.",Color3.fromRGB(255,100,100))
		return
	end

	W=true
	X=nil
	Y=nil
	V=false

	C(G)
end

if not k then
	Z("HTTP request API unavailable.",Color3.fromRGB(255,100,100))
	S.Text="HTTP UNAVAILABLE"
	S.Active=false
	S.AutoButtonColor=false
else
	S.MouseButton1Click:Connect(ac)

	P.FocusLost:Connect(function(ao)
		if ao then
			ac()
		end
	end)
end

local ap=false
local aq
local ar

K.InputBegan:Connect(function(as)
	if as.UserInputType==Enum.UserInputType.MouseButton1 then
		ap=true
		aq=as.Position
		ar=H.Position

		as.Changed:Connect(function()
			if as.UserInputState==Enum.UserInputState.End then
				ap=false
			end
		end)
	end
end)

d.InputChanged:Connect(function(at)
	if not ap then
		return
	end

	if at.UserInputType~=Enum.UserInputType.MouseMovement then
		return
	end

	local au=at.Position-aq

	H.Position=UDim2.new(
		ar.X.Scale,
		ar.X.Offset+au.X,
		ar.Y.Scale,
		ar.Y.Offset+au.Y
	)
end)