local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local _b = Players.LocalPlayer
local _c = "\104\116\116\112\115\058\047\047\103\116\122\045\104\117\098\045\097\112\105\046\103\116\122\104\117\098\057\052\046\119\111\114\107\101\114\115\046\100\101\118"
local function _d()
    if type(_e) == "function" then
        local _f, _g = pcall(_e)
        if _f and _g then
            return _g
        end
    end
    local _f, _h = pcall(function()
        return game:GetService("CoreGui")
    end)
    if _f and _h then
        return _h
    end
    return _b:WaitForChild("PlayerGui")
end
local function _i()
    if type(request) == "function" then
        return request
    end
    if type(http_request) == "function" then
        return http_request
    end
    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    end
    if type(fluxus) == "table" and type(fluxus.request) == "function" then
        return fluxus.request
    end
    if type(http) == "table" and type(http.request) == "function" then
        return http.request
    end
    local _j = type(getgenv) == "function" and getgenv() or _k
    if type(_j.request) == "function" then
        return _j.request
    end
    if type(_j.http_request) == "function" then
        return _j.http_request
    end
    return nil
end
local _l = _i()
local _m = _d()
local function _n(_o)
    if type(_o) ~= "string" or _o == "" then
        return nil
    end
    local _f, _p = pcall(function()
        return HttpService:JSONDecode(_o)
    end)
    if _f and type(_p) == "table" then
        return _p
    end
    return nil
end
local function _q(_r, _s, _o)
    if not _l then
        return nil, "\072\084\084\080\095\082\069\081\085\069\083\084\095\085\078\065\086\065\073\076\065\066\076\069"
    end
    local _t = {
        Url = _s,
        Method = _r,
        Headers = {
            ["Content-Type"] = "application/json",
            ["Cache-Control"] = "no-store"
        }
    }
    if _o then
        _t.Body = HttpService:JSONEncode(_o)
    end
    local _f, _u = pcall(function()
        return _l(_t)
    end)
    if not _f or type(_u) ~= "table" then
        return nil, "\072\084\084\080\095\082\069\081\085\069\083\084\095\070\065\073\076\069\068"
    end
    local _v =
        tonumber(_u.StatusCode)
        or tonumber(_u.Status)
        or 0
    local _w =
        _u.Body
        or _u._o
        or ""
    return {
        StatusCode = _v,
        Body = _w,
        Data = _n(_w)
    }
end
local _x = _m:FindFirstChild("\071\084\090\095\072\085\066\095\075\069\089\095\083\089\083\084\069\077")
if _x then
    pcall(function()
        _x:Destroy()
    end)
end
local _y = Instance.new("ScreenGui")
_y.Name = "\071\084\090\095\072\085\066\095\075\069\089\095\083\089\083\084\069\077"
_y.ResetOnSpawn = false
_y.IgnoreGuiInset = true
_y.ZIndexBehavior = Enum.ZIndexBehavior.Global
pcall(function()
    _y.DisplayOrder = 999999
end)
_y.Parent = _m
local _z = Instance.new("Frame")
_z.Name = "Main"
_z.Size = UDim2.new(0, 430, 0, 250)
_z.Position = UDim2.new(0.5, -215, 0.5, -125)
_z.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
_z.BorderSizePixel = 0
_z.Parent = _y
local _A = Instance.new("UICorner")
_A.CornerRadius = UDim.new(0, 14)
_A.Parent = _z
local _B = Instance.new("UIStroke")
_B.Color = Color3.fromRGB(130, 70, 220)
_B.Thickness = 2
_B.Transparency = 0.15
_B.Parent = _z
local _C = Instance.new("Frame")
_C.Name = "Top"
_C.Size = UDim2.new(1, 0, 0, 60)
_C.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
_C.BorderSizePixel = 0
_C.Parent = _z
local _D = Instance.new("UICorner")
_D.CornerRadius = UDim.new(0, 14)
_D.Parent = _C
local _E = Instance.new("ImageLabel")
_E.Name = "Logo"
_E.Size = UDim2.new(0, 42, 0, 42)
_E.Position = UDim2.new(0, 10, 0, 9)
_E.BackgroundTransparency = 1
_E.Image = "rbxassetid://125548024440666"
_E.ScaleType = Enum.ScaleType.Fit
_E.Parent = _C
local _F = Instance.new("TextLabel")
_F.Name = "Title"
_F.Size = UDim2.new(1, -65, 0, 28)
_F.Position = UDim2.new(0, 60, 0, 8)
_F.BackgroundTransparency = 1
_F.Text = "GTZ HUB"
_F.TextColor3 = Color3.fromRGB(210, 170, 255)
_F.Font = Enum.Font.GothamBold
_F.TextSize = 21
_F.TextXAlignment = Enum.TextXAlignment.Left
_F.Parent = _C
local _G = Instance.new("TextLabel")
_G.Name = "Subtitle"
_G.Size = UDim2.new(1, -65, 0, 18)
_G.Position = UDim2.new(0, 60, 0, 34)
_G.BackgroundTransparency = 1
_G.Text = "\075\101\121\032\086\101\114\105\102\105\099\097\116\105\111\110"
_G.TextColor3 = Color3.fromRGB(155, 145, 170)
_G.Font = Enum.Font.Gotham
_G.TextSize = 12
_G.TextXAlignment = Enum.TextXAlignment.Left
_G.Parent = _C
local _H = Instance.new("TextBox")
_H.Name = "KeyBox"
_H.Size = UDim2.new(1, -40, 0, 48)
_H.Position = UDim2.new(0, 20, 0, 82)
_H.BackgroundColor3 = Color3.fromRGB(30, 24, 43)
_H.BorderSizePixel = 0
_H.PlaceholderText = "\069\110\116\101\114\032\121\111\117\114\032\107\101\121\046\046\046"
_H.PlaceholderColor3 = Color3.fromRGB(115, 105, 130)
_H.Text = ""
_H.TextColor3 = Color3.fromRGB(235, 225, 245)
_H.Font = Enum.Font.Gotham
_H.TextSize = 14
_H.ClearTextOnFocus = false
_H.TextXAlignment = Enum.TextXAlignment.Left
_H.Parent = _z
local _I = Instance.new("UICorner")
_I.CornerRadius = UDim.new(0, 9)
_I.Parent = _H
local _J = Instance.new("UIStroke")
_J.Color = Color3.fromRGB(85, 65, 115)
_J.Thickness = 1
_J.Parent = _H
local _K = Instance.new("TextButton")
_K.Name = "VerifyButton"
_K.Size = UDim2.new(1, -40, 0, 42)
_K.Position = UDim2.new(0, 20, 0, 142)
_K.BackgroundColor3 = Color3.fromRGB(110, 55, 190)
_K.BorderSizePixel = 0
_K.Text = "\086\069\082\073\070\089\032\075\069\089"
_K.TextColor3 = Color3.fromRGB(255, 255, 255)
_K.Font = Enum.Font.GothamBold
_K.TextSize = 14
_K.AutoButtonColor = true
_K.Parent = _z
local _L = Instance.new("UICorner")
_L.CornerRadius = UDim.new(0, 9)
_L.Parent = _K
local _M = Instance.new("UIStroke")
_M.Color = Color3.fromRGB(150, 90, 235)
_M.Thickness = 1
_M.Transparency = 0.4
_M.Parent = _K
local _N = Instance.new("TextLabel")
_N.Name = "Status"
_N.Size = UDim2.new(1, -40, 0, 45)
_N.Position = UDim2.new(0, 20, 0, 194)
_N.BackgroundTransparency = 1
_N.Text = "Enter your key to continue."
_N.TextColor3 = Color3.fromRGB(155, 145, 170)
_N.Font = Enum.Font.Gotham
_N.TextSize = 12
_N.TextWrapped = true
_N.TextXAlignment = Enum.TextXAlignment.Center
_N.TextYAlignment = Enum.TextYAlignment.Center
_N.Parent = _z
local _O = false
local _P
local _Q
_C.InputBegan:Connect(function(_R)
    if _R.UserInputType == Enum.UserInputType.MouseButton1
        or _R.UserInputType == Enum.UserInputType.Touch then
        _O = true
        _P = _R.Position
        _Q = _z.Position
        _R.Changed:Connect(function()
            if _R.UserInputState == Enum.UserInputState.End then
                _O = false
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(_R)
    if not _O then
        return
    end
    if _R.UserInputType ~= Enum.UserInputType.MouseMovement
        and _R.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    local _S = _R.Position - _P
    _z.Position = UDim2.new(
        _Q.X.Scale,
        _Q.X.Offset + _S.X,
        _Q.Y.Scale,
        _Q.Y.Offset + _S.Y
    )
end)
local function _T(_U, _V)
    _N.Text = tostring(_U)
    if _V then
        _N.TextColor3 = _V
    end
end
if not _l then
    _T(
        "\072\084\084\080\032\114\101\113\117\101\115\116\032\065\080\073\032\117\110\097\118\097\105\108\097\098\108\101\032\105\110\032\116\104\105\115\032\101\120\101\099\117\116\111\114\046",
        Color3.fromRGB(255, 100, 100)
    )
    _K.Text = "\072\084\084\080\032\085\078\065\086\065\073\076\065\066\076\069"
    _K.Active = false
    _K.AutoButtonColor = false
end
local _W = false
local function _X()
    local _f, _Y = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if _f and type(_Y) == "table" and _Y.Name then
        return tostring(_Y.Name)
    end
    return "Unknown"
end
local function _Z(_aa)
    if type(_aa) ~= "string" or _aa == "" then
        return false, "\069\077\080\084\089\095\083\067\082\073\080\084"
    end
    local _ab = loadstring or load
    if type(_ab) ~= "function" then
        return false, "\076\079\065\068\083\084\082\073\078\071\095\085\078\065\086\065\073\076\065\066\076\069"
    end
    local _ac, _ad = pcall(function()
        return _ab(_aa)
    end)
    if not _ac or type(_ad) ~= "function" then
        return false, "\067\079\077\080\073\076\069\095\070\065\073\076\069\068"
    end
    local _ae, _af = pcall(function()
        return _ad()
    end)
    if not _ae then
        return false, _af
    end
    return true
end
local function _ag()
    _W = false
    _K.Text = "\086\069\082\073\070\089\032\075\069\089"
    _K.Active = true
    _K.AutoButtonColor = true
end
local function _ah()
    if _W then
        return
    end
    local _ai = tostring(_H.Text or "")
        :gsub("^%s+", "")
        :gsub("%s+$", "")
    if _ai == "" then
        _T(
            "\080\108\101\097\115\101\032\101\110\116\101\114\032\097\032\107\101\121\046",
            Color3.fromRGB(255, 120, 120)
        )
        return
    end
    if not _l then
        _T(
            "\072\084\084\080\032\114\101\113\117\101\115\116\032\065\080\073\032\117\110\097\118\097\105\108\097\098\108\101\032\105\110\032\116\104\105\115\032\101\120\101\099\117\116\111\114\046",
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    _W = true
    _K.Text = "\086\069\082\073\070\089\073\078\071\046\046\046"
    _K.Active = false
    _K.AutoButtonColor = false
    _T(
        "\067\111\110\116\097\099\116\105\110\103\032\071\084\090\032\072\085\066\032\115\101\114\118\101\114\046\046\046",
        Color3.fromRGB(190, 175, 210)
    )
    local _u, _aj = _q(
        "POST",
        _c .. "/validate",
        {
            _ai = _ai,
            _ak = tostring(_b.Name),
            _al = tostring(_b.UserId),
            _am = _X(),
            _an = tostring(game.PlaceId)
        }
    )
    if not _u then
        _ag()
        _T(
            "\067\111\110\110\101\099\116\105\111\110\032\102\097\105\108\101\100\058\032" .. tostring(_aj),
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    local _ao = _u.Data
    if type(_ao) ~= "table" then
        _ag()
        _T(
            "\073\110\118\097\108\105\100\032\115\101\114\118\101\114\032\114\101\115\112\111\110\115\101\046",
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    if _ao.valid ~= true then
        _ag()
        local _ap = tostring(
            _ao._ap
            or _ao.error
            or "\105\110\118\097\108\105\100\095\107\101\121"
        )
        local _aq = {
            _ar = "\075\101\121\032\110\111\116\032\102\111\117\110\100\046",
            _as = "\084\104\105\115\032\107\101\121\032\104\097\115\032\098\101\101\110\032\114\101\118\111\107\101\100\046",
            _at = "\084\104\105\115\032\107\101\121\032\104\097\115\032\101\120\112\105\114\101\100\046",
            _au = "\084\104\105\115\032\111\110\101\045\116\105\109\101\032\107\101\121\032\104\097\115\032\097\108\114\101\097\100\121\032\098\101\101\110\032\117\115\101\100\046",
            _av = "\073\110\118\097\108\105\100\032\107\101\121\032\100\097\116\097\046",
            _aw = "\077\105\115\115\105\110\103\032\107\101\121\046"
        }
        _T(
            _aq[_ap] or ("Key rejected: " .. _ap),
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    if type(_ao.script) ~= "string" or _ao.script == "" then
        _ag()
        _T(
            "\078\111\032\115\099\114\105\112\116\032\119\097\115\032\114\101\099\101\105\118\101\100\032\102\114\111\109\032\116\104\101\032\115\101\114\118\101\114\046",
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    _T(
        "\075\101\121\032\097\099\099\101\112\116\101\100\046\032\076\111\097\100\105\110\103\046\046\046",
        Color3.fromRGB(130, 255, 160)
    )
    local _f, _af = _Z(_ao.script)
    if not _f then
        _ag()
        _T(
            "\083\099\114\105\112\116\032\102\097\105\108\101\100\032\116\111\032\115\116\097\114\116\058\032" .. tostring(_af),
            Color3.fromRGB(255, 100, 100)
        )
        return
    end
    _W = false
    _ax.wait(0.8)
    pcall(function()
        _y:Destroy()
    end)
end
_K.MouseButton1Click:Connect(_ah)
_H.FocusLost:Connect(function(_ay)
    if _ay then
        _ah()
    end
end)
