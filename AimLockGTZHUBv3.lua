local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local API_URL = "https://gtz-hub-api.gtzhub94.workers.dev"

local function getGameName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)

    if success and info and info.Name then
        return info.Name
    end

    return "Unknown"
end

local function notify(message)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "GTZ HUB",
            Text = message,
            Duration = 5
        })
    end)
end

local function validateKey(key)
    local body = {
        key = tostring(key),
        username = tostring(LocalPlayer.Name),
        userId = tostring(LocalPlayer.UserId),
        gameName = getGameName(),
        placeId = tostring(game.PlaceId)
    }

    local success, response = pcall(function()
        return request({
            Url = API_URL .. "/validate",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(body)
        })
    end)

    if not success then
        return nil, "Não foi possível contactar o servidor."
    end

    if not response or not response.Body then
        return nil, "Resposta inválida do servidor."
    end

    local decodeSuccess, data = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)

    if not decodeSuccess or type(data) ~= "table" then
        return nil, "Resposta inválida do servidor."
    end

    if not response.StatusCode or response.StatusCode < 200 or response.StatusCode >= 300 then
        return nil, data.error or "Key inválida."
    end

    if data.valid ~= true then
        return nil, data.error or "Key inválida."
    end

    if type(data.script) ~= "string" or data.script == "" then
        return nil, "Script não encontrado."
    end

    return data.script, nil
end

local function executeScript(scriptSource)
    local success, loaded = pcall(function()
        return loadstring(scriptSource)
    end)

    if not success or type(loaded) ~= "function" then
        return false, "Não foi possível carregar o script."
    end

    local executeSuccess, result = pcall(loaded)

    if not executeSuccess then
        return false, tostring(result)
    end

    return true
end

local function start()
    local key = ""

    if type(getgenv) == "function" and type(getgenv().GTZ_KEY) == "string" then
        key = getgenv().GTZ_KEY
    end

    if key == "" then
        if type(readfile) == "function" and type(isfile) == "function" and isfile("GTZ_KEY.txt") then
            local success, content = pcall(function()
                return readfile("GTZ_KEY.txt")
            end)

            if success and type(content) == "string" then
                key = content:gsub("%s+", "")
            end
        end
    end

    if key == "" then
        notify("Key não encontrada.")
        return
    end

    notify("A validar key...")

    local scriptSource, errorMessage = validateKey(key)

    if not scriptSource then
        notify(errorMessage or "Key inválida.")
        return
    end

    notify("Key válida. A carregar...")

    local success, executeError = executeScript(scriptSource)

    if not success then
        notify(executeError or "Erro ao executar o script.")
        return
    end
end

start()