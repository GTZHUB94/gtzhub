local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local API = "https://gustavo-hub-api.errpila.workers.dev"
local LOGO = "rbxassetid://125548024440666"

local RemoteDisabled = false
local WarningGui = nil
local MainGui = nil
local SessionToken = nil

local function getRequestFunction()
    local candidates = {
        function()
            if type(request) == "function" then
                return request
            end
        end,

        function()
            if type(http_request) == "function" then
                return http_request
            end
        end,

        function()
            if syn and type(syn.request) == "function" then
                return syn.request
            end
        end,

        function()
            if fluxus and type(fluxus.request) == "function" then
                return fluxus.request
            end
        end,

        function()
            if http and type(http.request) == "function" then
                return http.request
            end
        end,

        function()
            if http and type(http.request) == "table" and type(http.request.request) == "function" then
                return http.request.request
            end
        end,

        function()
            if getgenv then
                local env = getgenv()

                if type(env.request) == "function" then
                    return env.request
                end

                if type(env.http_request) == "function" then
                    return env.http_request
                end
            end
        end
    }

    for _, getCandidate in ipairs(candidates) do
        local ok, result = pcall(getCandidate)

        if ok and type(result) == "function" then
            return result
        end
    end

    return nil
end

local Request = getRequestFunction()

local function decodeResponse(response)
    if not response then
        return nil
    end

    local body =
        response.Body or
        response.body or
        response.ResponseBody or
        response.responseBody

    if type(body) ~= "string" or body == "" then
        return nil
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if ok and type(data) == "table" then
        return data
    end

    return nil
end

local function HTTP(method, url, body)
    if not Request then
        return nil
    end

    local options = {
        Url = url,
        Method = method,
        Headers = {
            ["Accept"] = "application/json",
            ["Cache-Control"] = "no-store",
            ["Pragma"] = "no-cache"
        }
    }

    if body ~= nil then
        options.Headers["Content-Type"] = "application/json"
        options.Body = HttpService:JSONEncode(body)
    end

    local ok, response = pcall(function()
        return Request(options)
    end)

    if not ok then
        return nil
    end

    return decodeResponse(response)
end

local function destroyGuiByName(name)
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local object = CoreGui:FindFirstChild(name)

        if object then
            object:Destroy()
        end
    end)

    pcall(function()
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")

        if PlayerGui then
            local object = PlayerGui:FindFirstChild(name)

            if object then
                object:Destroy()
            end
        end
    end)
end

local function destroyMainHub()
    destroyGuiByName("GustavoHub")
    destroyGuiByName("GTZHub")
    destroyGuiByName("GustavoHubGUI")
    destroyGuiByName("GTZHubKey")
end

local function remoteDisable()
    if RemoteDisabled then
        return
    end

    RemoteDisabled = true

    if getgenv then
        pcall(function()
            getgenv().GTZ_HUB_PAUSED = true
        end)

        pcall(function()
            getgenv().GTZ_HUB_REMOTE_DISABLED = true
        end)
    end

    destroyGuiByName("GTZHubVerificationWarning")
    destroyMainHub()

    if MainGui then
        pcall(function()
            MainGui:Destroy()
        end)

        MainGui = nil
    end
end

local function remotePause()
    if RemoteDisabled then
        return
    end

    if getgenv then
        pcall(function()
            getgenv().GTZ_HUB_PAUSED = true
        end)

        pcall(function()
            local fn = getgenv().GTZ_HUB_AIM_PAUSE

            if type(fn) == "function" then
                fn()
            end
        end)
    end
end

local function remoteResume()
    if RemoteDisabled then
        return
    end

    if getgenv then
        pcall(function()
            getgenv().GTZ_HUB_PAUSED = false
        end)

        pcall(function()
            local fn = getgenv().GTZ_HUB_AIM_RESUME

            if type(fn) == "function" then
                fn()
            end
        end)
    end
end

if getgenv then
    getgenv().GTZ_HUB_REMOTE_DISABLE = remoteDisable
    getgenv().GTZ_HUB_REMOTE_PAUSE = remotePause
    getgenv().GTZ_HUB_REMOTE_RESUME = remoteResume
end

local function createKeyGui()
    destroyGuiByName("GTZHubKey")

    local parent

    pcall(function()
        parent = game:GetService("CoreGui")
    end)

    if not parent then
        parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GTZHubKey"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 99999
    ScreenGui.Parent = parent

    MainGui = ScreenGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromOffset(420, 420)
    Main.Position = UDim2.new(0.5, -210, 0.5, -210)
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = Main

    local Background = Instance.new("ImageLabel")
    Background.Size = UDim2.fromScale(1, 1)
    Background.BackgroundTransparency = 1
    Background.Image = LOGO
    Background.ScaleType = Enum.ScaleType.Crop
    Background.ImageTransparency = 0.15
    Background.Parent = Main

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
    Overlay.BackgroundTransparency = 0.35
    Overlay.BorderSizePixel = 0
    Overlay.Parent = Main

    local OverlayCorner = Instance.new("UICorner")
    OverlayCorner.CornerRadius = UDim.new(0, 14)
    OverlayCorner.Parent = Overlay

    local Logo = Instance.new("ImageLabel")
    Logo.Size = UDim2.fromOffset(72, 72)
    Logo.Position = UDim2.new(0.5, -36, 0, 18)
    Logo.BackgroundTransparency = 1
    Logo.Image = LOGO
    Logo.ScaleType = Enum.ScaleType.Fit
    Logo.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 40)
    Title.Position = UDim2.fromOffset(20, 96)
    Title.BackgroundTransparency = 1
    Title.Text = "GTZ HUB"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 25
    Title.Parent = Main

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -40, 0, 25)
    Subtitle.Position = UDim2.fromOffset(20, 130)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Secure License Verification"
    Subtitle.TextColor3 = Color3.fromRGB(185, 185, 195)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextSize = 13
    Subtitle.Parent = Main

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -40, 0, 48)
    KeyBox.Position = UDim2.fromOffset(20, 170)
    KeyBox.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
    KeyBox.BorderSizePixel = 0
    KeyBox.PlaceholderText = "Enter your key..."
    KeyBox.PlaceholderColor3 = Color3.fromRGB(135, 135, 145)
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.new(1, 1, 1)
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 15
    KeyBox.ClearTextOnFocus = false
    KeyBox.TextXAlignment = Enum.TextXAlignment.Center
    KeyBox.Parent = Main

    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 9)
    KeyCorner.Parent = KeyBox

    local Validate = Instance.new("TextButton")
    Validate.Size = UDim2.new(1, -40, 0, 44)
    Validate.Position = UDim2.fromOffset(20, 232)
    Validate.BackgroundColor3 = Color3.fromRGB(145, 45, 230)
    Validate.BorderSizePixel = 0
    Validate.Text = "VALIDATE KEY"
    Validate.TextColor3 = Color3.new(1, 1, 1)
    Validate.Font = Enum.Font.GothamBold
    Validate.TextSize = 15
    Validate.Parent = Main

    local ValidateCorner = Instance.new("UICorner")
    ValidateCorner.CornerRadius = UDim.new(0, 9)
    ValidateCorner.Parent = Validate

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -40, 0, 70)
    Status.Position = UDim2.fromOffset(20, 292)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(225, 225, 230)
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 13
    Status.TextWrapped = true
    Status.Parent = Main

    if not Request then
        Status.Text = "HTTP request support was not detected."
        Validate.Text = "HTTP UNAVAILABLE"
        Validate.Active = false
        Validate.AutoButtonColor = false
        return nil, ScreenGui
    end

    local Result = nil
    local Busy = false

    local function validate()
        if Busy or RemoteDisabled then
            return
        end

        local key = tostring(KeyBox.Text or "")
        key = key:gsub("^%s+", ""):gsub("%s+$", "")

        if key == "" then
            Status.Text = "Enter a key."
            return
        end

        Busy = true
        Validate.Text = "VALIDATING..."
        Status.Text = "Contacting GTZ HUB security server..."

        Result = key
    end

    Validate.MouseButton1Click:Connect(validate)

    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            validate()
        end
    end)

    while Result == nil and not RemoteDisabled do
        task.wait()
    end

    if RemoteDisabled then
        return nil, ScreenGui
    end

    return Result, ScreenGui
end

local Key, KeyGui = createKeyGui()

if not Key then
    return
end

local function setKeyStatus(text)
    pcall(function()
        local status = KeyGui
            and KeyGui:FindFirstChildWhichIsA("Frame")
            and KeyGui:FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel")

        if status then
            status.Text = text
        end
    end)
end

Key = tostring(Key)
Key = Key:gsub("^%s+", "")
Key = Key:gsub("%s+$", "")
Key = Key:upper()

if RemoteDisabled then
    return
end

local username = "Unknown"
local userId = "Unknown"
local gameName = "Unknown game"
local placeId = tostring(game.PlaceId)

pcall(function()
    username = tostring(LocalPlayer.Name)
    userId = tostring(LocalPlayer.UserId)
end)

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)

    if info and info.Name then
        gameName = tostring(info.Name)
    end
end)

local validation = HTTP(
    "POST",
    API .. "/validate",
    {
        key = Key,
        username = username,
        userId = userId,
        gameName = gameName,
        placeId = placeId
    }
)

if not validation then
    warn("GTZ HUB: unable to contact the license server.")

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

if validation.valid ~= true then
    warn(
        "GTZ HUB: key rejected (" ..
        tostring(validation.reason or "invalid_key") ..
        ")."
    )

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

local Token = validation.token

if type(Token) ~= "string" or Token == "" then
    warn("GTZ HUB: secure session token was not received.")

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

SessionToken = Token

local ScriptResponse = HTTP(
    "POST",
    API .. "/script",
    {
        token = Token
    }
)

if not ScriptResponse then
    warn("GTZ HUB: unable to retrieve the protected script.")

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

if ScriptResponse.success ~= true then
    warn(
        "GTZ HUB: script delivery rejected (" ..
        tostring(ScriptResponse.reason or "server_error") ..
        ")."
    )

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

local Code = ScriptResponse.script

if type(Code) ~= "string" or Code == "" then
    warn("GTZ HUB: protected script was empty.")

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

if getgenv then
    pcall(function()
        getgenv().GUSTAVO_HUB_TOKEN = Token
    end)
end

local load = loadstring

if type(load) ~= "function" then
    warn("GTZ HUB: loadstring is unavailable.")

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

if not Code:find("GTZ_HUB_REMOTE_DISABLE", 1, true) then

    local Marker = "local ESPObjects = {}"

    local Hook = [[
if getgenv then

    getgenv().GTZ_HUB_REMOTE_DISABLE = function()

        ScriptEnabled = false
        AimEnabled = false
        Aiming = false
        LockedTarget = nil

        pcall(function()
            if FOVCircle then
                FOVCircle.Visible = false
                FOVCircle:Remove()
            end
        end)

        pcall(function()
            if ESPObjects then
                for _, Data in pairs(ESPObjects) do
                    if type(Data) == "table" then
                        for _, Object in pairs(Data) do
                            pcall(function()
                                if Object.Remove then
                                    Object:Remove()
                                elseif Object.Destroy then
                                    Object:Destroy()
                                end
                            end)
                        end
                    end
                end

                ESPObjects = {}
            end
        end)

        pcall(function()
            if GUI then
                GUI:Destroy()
            end
        end)

    end

    getgenv().GTZ_HUB_REMOTE_PAUSE = function()

        if getgenv().GTZ_HUB_PAUSED then
            return
        end

        getgenv().GTZ_HUB_PAUSED = true
        getgenv().GTZ_HUB_PREV_AIM_ENABLED = AimEnabled

        AimEnabled = false
        Aiming = false
        LockedTarget = nil

        pcall(function()
            if FOVCircle then
                FOVCircle.Visible = false
            end
        end)

    end

    getgenv().GTZ_HUB_REMOTE_RESUME = function()

        if not getgenv().GTZ_HUB_PAUSED then
            return
        end

        getgenv().GTZ_HUB_PAUSED = false

        if getgenv().GTZ_HUB_PREV_AIM_ENABLED == true then
            AimEnabled = true
        end

    end

end
]]

    if Code:find(Marker, 1, true) then
        Code = Code:gsub(
            Marker,
            Marker .. Hook,
            1
        )
    end
end

local ScriptFunction, LoadError = load(Code)

if not ScriptFunction then
    warn(
        "GTZ HUB: protected script compilation failed: " ..
        tostring(LoadError)
    )

    pcall(function()
        KeyGui:Destroy()
    end)

    MainGui = nil
    return
end

pcall(function()
    KeyGui:Destroy()
end)

MainGui = nil

task.spawn(function()

    if RemoteDisabled then
        return
    end

    local ok, runtimeError = pcall(function()
        ScriptFunction()
    end)

    if not ok then
        warn(
            "GTZ HUB: protected script execution failed: " ..
            tostring(runtimeError)
        )
    end
end)

local function destroyWarning()
    if WarningGui then
        pcall(function()
            WarningGui:Destroy()
        end)

        WarningGui = nil
    end
end

local function showWarning(controlId, message)

    if WarningGui or RemoteDisabled then
        return
    end

    local parent

    pcall(function()
        parent = game:GetService("CoreGui")
    end)

    if not parent then
        parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GTZHubVerificationWarning"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 999999
    ScreenGui.Parent = parent

    local Background = Instance.new("Frame")
    Background.Size = UDim2.fromScale(1, 1)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.25
    Background.BorderSizePixel = 0
    Background.Parent = ScreenGui

    local Box = Instance.new("Frame")
    Box.Size = UDim2.fromOffset(520, 300)
    Box.Position = UDim2.new(0.5, -260, 0.5, -150)
    Box.BackgroundColor3 = Color3.fromRGB(25, 18, 32)
    Box.BorderSizePixel = 0
    Box.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = Box

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 45)
    Title.Position = UDim2.fromOffset(20, 18)
    Title.BackgroundTransparency = 1
    Title.Text = "GTZ HUB — VERIFICATION REQUIRED"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22
    Title.Parent = Box

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -50, 0, 180)
    Text.Position = UDim2.fromOffset(25, 72)
    Text.BackgroundTransparency = 1
    Text.Text =
        tostring(message or "Verification required.") ..
        "\n\nSession ID: " ..
        tostring(controlId or "UNKNOWN") ..
        "\n\nConfirm or refuse the verification in Discord."
    Text.TextColor3 = Color3.fromRGB(235, 235, 235)
    Text.Font = Enum.Font.Gotham
    Text.TextSize = 16
    Text.TextWrapped = true
    Text.Parent = Box

    WarningGui = ScreenGui
end

task.spawn(function()

    local wasWarning = false

    while not RemoteDisabled do

        task.wait(3)

        if RemoteDisabled then
            break
        end

        local token = SessionToken

        if type(token) ~= "string" or token == "" then
            remoteDisable()
            break
        end

        local encodedToken

        pcall(function()
            encodedToken = HttpService:UrlEncode(token)
        end)

        if not encodedToken then
            remoteDisable()
            break
        end

        local state = HTTP(
            "GET",
            API .. "/session?token=" .. encodedToken
        )

        if state and state.valid == true then

            if state.warning == true then

                if not wasWarning then
                    wasWarning = true

                    showWarning(
                        state.controlId or "UNKNOWN",
                        state.warningMessage or
                        "Verification required."
                    )

                    remotePause()
                end

            else

                if wasWarning then
                    wasWarning = false

                    destroyWarning()
                    remoteResume()
                end
            end

        elseif state and state.valid ~= true then

            wasWarning = false
            destroyWarning()
            remoteDisable()

            break
        end
    end
end)