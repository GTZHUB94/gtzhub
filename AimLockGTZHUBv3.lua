local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local API_URL = "https://gtz-hub-api.gtzhub94.workers.dev"

local G = (type(getgenv) == "function" and getgenv()) or _G

local function findRequest()
    local r = {}

    if type(request) == "function" then
        table.insert(r, request)
    end

    if type(http_request) == "function" then
        table.insert(r, http_request)
    end

    if type(syn) == "table" and type(syn.request) == "function" then
        table.insert(r, syn.request)
    end

    if type(fluxus) == "table" and type(fluxus.request) == "function" then
        table.insert(r, fluxus.request)
    end

    if type(http) == "table" and type(http.request) == "function" then
        table.insert(r, http.request)
    end

    if type(G) == "table" then
        if type(G.request) == "function" then
            table.insert(r, G.request)
        end

        if type(G.http_request) == "function" then
            table.insert(r, G.http_request)
        end
    end

    for _, fn in ipairs(r) do
        if type(fn) == "function" then
            return fn
        end
    end

    return nil
end

local HTTP_REQUEST = findRequest()

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

    if body ~= nil then
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

local function destroyGui(gui)
    if gui then
        pcall(function()
            gui:Destroy()
        end)
    end
end

local function getGuiParent()
    local ok, result = pcall(function()
        return CoreGui
    end)

    if ok and result then
        return result
    end

    return LocalPlayer:WaitForChild("PlayerGui")
end

local GUI_PARENT = getGuiParent()

local oldGui =
    GUI_PARENT:FindFirstChild(
        "GTZ_HUB_KEY_SYSTEM"
    )

if oldGui then
    destroyGui(oldGui)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GTZ_HUB_KEY_SYSTEM"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GUI_PARENT

local Main = Instance.new("Frame")
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
Top.Size = UDim2.new(1, 0, 0, 60)
Top.BackgroundColor3 = Color3.fromRGB(28, 20, 42)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = Top

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 42, 0, 42)
Logo.Position = UDim2.new(0, 10, 0, 9)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://125548024440666"
Logo.Parent = Top

local Title = Instance.new("TextLabel")
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
KeyBox.Parent = Main

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 9)
KeyCorner.Parent = KeyBox

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(85, 65, 115)
KeyStroke.Thickness = 1
KeyStroke.Parent = KeyBox

local VerifyButton = Instance.new("TextButton")
VerifyButton.Size = UDim2.new(1, -40, 0, 42)
VerifyButton.Position = UDim2.new(0, 20, 0, 142)
VerifyButton.BackgroundColor3 = Color3.fromRGB(110, 55, 190)
VerifyButton.BorderSizePixel = 0
VerifyButton.Text = "VERIFY KEY"
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.TextSize = 14
VerifyButton.Parent = Main

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 9)
VerifyCorner.Parent = VerifyButton

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -40, 0, 45)
Status.Position = UDim2.new(0, 20, 0, 194)
Status.BackgroundTransparency = 1
Status.Text = "Enter your key to continue."
Status.TextColor3 = Color3.fromRGB(155, 145, 170)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextWrapped = true
Status.Parent = Main

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

    if input.UserInputType ~= Enum.UserInputType.MouseMovement then
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
    Status.Text = text

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

    return
end

local verifying = false

local function getGameName()
    local ok, info = pcall(function()
        return game:GetService(
            "MarketplaceService"
        ):GetProductInfo(
            game.PlaceId
        )
    end)

    if ok and info and info.Name then
        return tostring(info.Name)
    end

    return "Unknown"
end

local function resetButton()
    VerifyButton.Text = "VERIFY KEY"
    VerifyButton.Active = true
    VerifyButton.AutoButtonColor = true
end

local function validate()
    if verifying then
        return
    end

    local key =
        tostring(
            KeyBox.Text or ""
        ):gsub(
            "^%s+",
            ""
        ):gsub(
            "%s+$",
            ""
        )

    if key == "" then
        setStatus(
            "Please enter a key.",
            Color3.fromRGB(255, 120, 120)
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

    local response, err =
        httpRequest(
            "POST",
            API_URL .. "/validate",
            {
                key = key,
                username =
                    tostring(
                        LocalPlayer.Name
                    ),
                userId =
                    tostring(
                        LocalPlayer.UserId
                    ),
                gameName =
                    getGameName(),
                placeId =
                    tostring(
                        game.PlaceId
                    )
            }
        )

    if not response then
        verifying = false
        resetButton()

        setStatus(
            "Connection failed: " ..
                tostring(err),
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    local data = response.Data

    if type(data) ~= "table" then
        verifying = false
        resetButton()

        setStatus(
            "Invalid server response.",
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    if data.valid ~= true then
        verifying = false
        resetButton()

        local reason =
            tostring(
                data.error
                or "INVALID_KEY"
            )

        local messages = {
            INVALID_REQUEST =
                "Invalid request.",
            INVALID_KEY =
                "Invalid key format.",
            KEY_NOT_FOUND =
                "Key not found.",
            KEY_REVOKED =
                "This key has been revoked.",
            KEY_EXPIRED =
                "This key has expired.",
            KEY_ALREADY_USED =
                "This one-time key has already been used.",
            SCRIPT_NOT_FOUND =
                "Key accepted, but script was not found."
        }

        setStatus(
            messages[reason]
                or (
                    "Key rejected: " ..
                    reason
                ),
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    local scriptSource =
        data.script

    if type(scriptSource) ~= "string"
        or scriptSource == "" then

        verifying = false
        resetButton()

        setStatus(
            "Key accepted, but script was not found.",
            Color3.fromRGB(
                255,
                180,
                100
            )
        )

        return
    end

    G.GTZ_HUB_KEY_VALID = true
    G.GTZ_HUB_KEY = key
    G.GTZ_HUB_KEY_EXPIRES_AT =
        data.expiresAt
    G.GTZ_HUB_KEY_ONE_TIME =
        data.oneTime == true

    setStatus(
        "Key accepted. Loading script...",
        Color3.fromRGB(
            130,
            255,
            160
        )
    )

    VerifyButton.Text = "LOADING..."

    if type(loadstring) ~= "function" then
        verifying = false
        resetButton()

        setStatus(
            "Executor does not support loadstring.",
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    local chunk, compileError =
        loadstring(
            scriptSource
        )

    if not chunk then
        verifying = false
        resetButton()

        setStatus(
            "Script compile error: " ..
                tostring(
                    compileError
                ),
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    local ok, runtimeError =
        pcall(chunk)

    if not ok then
        verifying = false
        resetButton()

        setStatus(
            "Script error: " ..
                tostring(
                    runtimeError
                ),
            Color3.fromRGB(
                255,
                100,
                100
            )
        )

        return
    end

    setStatus(
        "Script loaded successfully.",
        Color3.fromRGB(
            130,
            255,
            160
        )
    )

    VerifyButton.Text = "LOADED"
    VerifyButton.Active = false
    VerifyButton.AutoButtonColor = false

    verifying = false

    task.wait(0.8)

    destroyGui(
        ScreenGui
    )
end

VerifyButton.MouseButton1Click:Connect(
    validate
)

KeyBox.FocusLost:Connect(
    function(enterPressed)
        if enterPressed then
            validate()
        end
    end
)