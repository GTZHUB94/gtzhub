local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local API_URL = "https://gtz-hub-api.gtzhub94.workers.dev"

local function getGuiParent()
    if type(gethui) == "function" then
        local ok, gui = pcall(gethui)
        if ok and gui then
            return gui
        end
    end

    local ok, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)

    if ok and coreGui then
        return coreGui
    end

    return LocalPlayer:WaitForChild("PlayerGui")
end

local function findRequest()
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

    local env = type(getgenv) == "function" and getgenv() or _G

    if type(env.request) == "function" then
        return env.request
    end

    if type(env.http_request) == "function" then
        return env.http_request
    end

    return nil
end

local HTTP_REQUEST = findRequest()
local GUI_PARENT = getGuiParent()

local function decodeJSON(body)
    if type(body) ~= "string" or body == "" then
        return nil
    end

    local ok, result = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if ok and type(result) == "table" then
        return result
    end

    return nil
end

local function httpRequest(method, url, body)
    if not HTTP_REQUEST then
        return nil, "HTTP_REQUEST_UNAVAILABLE"
    end

    local options = {
        Url = url,
        Method = method,
        Headers = {
            ["Content-Type"] = "application/json",
            ["Cache-Control"] = "no-store"
        }
    }

    if body then
        options.Body = HttpService:JSONEncode(body)
    end

    local ok, response = pcall(function()
        return HTTP_REQUEST(options)
    end)

    if not ok or type(response) ~= "table" then
        return nil, "HTTP_REQUEST_FAILED"
    end

    local statusCode =
        tonumber(response.StatusCode)
        or tonumber(response.Status)
        or 0

    local responseBody =
        response.Body
        or response.body
        or ""

    return {
        StatusCode = statusCode,
        Body = responseBody,
        Data = decodeJSON(responseBody)
    }
end

local oldGui = GUI_PARENT:FindFirstChild("GTZ_HUB_KEY_SYSTEM")

if oldGui then
    pcall(function()
        oldGui:Destroy()
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GTZ_HUB_KEY_SYSTEM"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

pcall(function()
    ScreenGui.DisplayOrder = 999999
end)

ScreenGui.Parent = GUI_PARENT

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 430, 0, 250)
Main.Position = UDim2.new(0.5, -215, 0.5, -125)
Main.BackgroundColor3 = Color3.fromRGB(20, 16, 30)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(130, 70, 220)
Stroke.Thickness = 2
Stroke.Transparency = 0.15
Stroke.Parent = Main

local Top = Instance.new("Frame")
Top.Name = "Top"
Top.Size = UDim2.new(1, 0, 0, 60)
Top.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = Top

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 42, 0, 42)
Logo.Position = UDim2.new(0, 10, 0, 9)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://125548024440666"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Top

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -65, 0, 28)
Title.Position = UDim2.new(0, 60, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "GTZ HUB"
Title.TextColor3 = Color3.fromRGB(210, 170, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 21
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, -65, 0, 18)
Subtitle.Position = UDim2.new(0, 60, 0, 34)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Key Verification"
Subtitle.TextColor3 = Color3.fromRGB(155, 145, 170)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Top

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -40, 0, 48)
KeyBox.Position = UDim2.new(0, 20, 0, 82)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 24, 43)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(115, 105, 130)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(235, 225, 245)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
KeyBox.TextXAlignment = Enum.TextXAlignment.Left
KeyBox.Parent = Main

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 9)
KeyCorner.Parent = KeyBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(85, 65, 115)
KeyStroke.Thickness = 1
KeyStroke.Parent = KeyBox

local VerifyButton = Instance.new("TextButton")
VerifyButton.Name = "VerifyButton"
VerifyButton.Size = UDim2.new(1, -40, 0, 42)
VerifyButton.Position = UDim2.new(0, 20, 0, 142)
VerifyButton.BackgroundColor3 = Color3.fromRGB(110, 55, 190)
VerifyButton.BorderSizePixel = 0
VerifyButton.Text = "VERIFY KEY"
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.TextSize = 14
VerifyButton.AutoButtonColor = true
VerifyButton.Parent = Main

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 9)
VerifyCorner.Parent = VerifyButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(150, 90, 235)
ButtonStroke.Thickness = 1
ButtonStroke.Transparency = 0.4
ButtonStroke.Parent = VerifyButton

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(1, -40, 0, 45)
Status.Position = UDim2.new(0, 20, 0, 194)
Status.BackgroundTransparency = 1
Status.Text = "Enter your key to continue."
Status.TextColor3 = Color3.fromRGB(155, 145, 170)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.TextYAlignment = Enum.TextYAlignment.Center
Status.Parent = Main

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    Main.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end)

local function setStatus(text, color)
    Status.Text = tostring(text)

    if color then
        Status.TextColor3 = color
    end
end

if not HTTP_REQUEST then
    setStatus(
        "HTTP request API unavailable in this executor.",
        Color3.fromRGB(255, 100, 100)
    )

    VerifyButton.Text = "HTTP UNAVAILABLE"
    VerifyButton.Active = false
    VerifyButton.AutoButtonColor = false
end

local verifying = false

local function getGameName()
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)

    if ok and type(info) == "table" and info.Name then
        return tostring(info.Name)
    end

    return "Unknown"
end

local function runDownloadedScript(source)
    if type(source) ~= "string" or source == "" then
        return false, "EMPTY_SCRIPT"
    end

    local compiler = loadstring or load

    if type(compiler) ~= "function" then
        return false, "LOADSTRING_UNAVAILABLE"
    end

    local okCompile, fn = pcall(function()
        return compiler(source)
    end)

    if not okCompile or type(fn) ~= "function" then
        return false, "COMPILE_FAILED"
    end

    local okRuntime, runtimeError = pcall(function()
        return fn()
    end)

    if not okRuntime then
        return false, runtimeError
    end

    return true
end

local function resetButton()
    verifying = false
    VerifyButton.Text = "VERIFY KEY"
    VerifyButton.Active = true
    VerifyButton.AutoButtonColor = true
end

local function validate()
    if verifying then
        return
    end

    local key = tostring(KeyBox.Text or "")
        :gsub("^%s+", "")
        :gsub("%s+$", "")

    if key == "" then
        setStatus(
            "Please enter a key.",
            Color3.fromRGB(255, 120, 120)
        )
        return
    end

    if not HTTP_REQUEST then
        setStatus(
            "HTTP request API unavailable in this executor.",
            Color3.fromRGB(255, 100, 100)
        )
        return
    end

    verifying = true

    VerifyButton.Text = "VERIFYING..."
    VerifyButton.Active = false
    VerifyButton.AutoButtonColor = false

    setStatus(
        "Contacting GTZ HUB server...",
        Color3.fromRGB(190, 175, 210)
    )

    local response, err = httpRequest(
        "POST",
        API_URL .. "/validate",
        {
            key = key,
            username = tostring(LocalPlayer.Name),
            userId = tostring(LocalPlayer.UserId),
            gameName = getGameName(),
            placeId = tostring(game.PlaceId)
        }
    )

    if not response then
        resetButton()

        setStatus(
            "Connection failed: " .. tostring(err),
            Color3.fromRGB(255, 100, 100)
        )

        return
    end

    local data = response.Data

    if type(data) ~= "table" then
        resetButton()

        setStatus(
            "Invalid server response.",
            Color3.fromRGB(255, 100, 100)
        )

        return
    end

    if data.valid ~= true then
        resetButton()

        local reason = tostring(
            data.reason
            or data.error
            or "invalid_key"
        )

        local messages = {
            key_not_found = "Key not found.",
            revoked = "This key has been revoked.",
            expired = "This key has expired.",
            already_used = "This one-time key has already been used.",
            invalid_data = "Invalid key data.",
            missing_key = "Missing key."
        }

        setStatus(
            messages[reason] or ("Key rejected: " .. reason),
            Color3.fromRGB(255, 100, 100)
        )

        return
    end

    if type(data.script) ~= "string" or data.script == "" then
        resetButton()

        setStatus(
            "No script was received from the server.",
            Color3.fromRGB(255, 100, 100)
        )

        return
    end

    setStatus(
        "Key accepted. Loading...",
        Color3.fromRGB(130, 255, 160)
    )

    local ok, runtimeError = runDownloadedScript(data.script)

    if not ok then
        resetButton()

        setStatus(
            "Script failed to start: " .. tostring(runtimeError),
            Color3.fromRGB(255, 100, 100)
        )

        return
    end

    verifying = false

    task.wait(0.8)

    pcall(function()
        ScreenGui:Destroy()
    end)
end

VerifyButton.MouseButton1Click:Connect(validate)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validate()
    end
end)