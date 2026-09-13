local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    Camera = Workspace.CurrentCamera
end)

local TEAM_COLORS = {
    ["TPC"] = Color3.fromRGB(170, 0, 255),
    ["TRC"] = Color3.fromRGB(255, 30, 30),
    ["TOC"] = Color3.fromRGB(255, 140, 0),
    ["TYC"] = Color3.fromRGB(255, 235, 0),
    ["TGC"] = Color3.fromRGB(0, 230, 70),
    ["TBC"] = Color3.fromRGB(0, 140, 255),
}

local TEAM_NAMES = {
    ["TPC"] = "Purple",
    ["TRC"] = "Red",
    ["TOC"] = "Orange",
    ["TYC"] = "Yellow",
    ["TGC"] = "Green",
    ["TBC"] = "Blue",
}

local CUSTOM_TEAM_COLORS = {
    ["TPC"] = Color3.fromRGB(170, 0, 255),
    ["TRC"] = Color3.fromRGB(255, 30, 30),
    ["TOC"] = Color3.fromRGB(255, 140, 0),
    ["TYC"] = Color3.fromRGB(255, 235, 0),
    ["TGC"] = Color3.fromRGB(0, 230, 70),
    ["TBC"] = Color3.fromRGB(0, 140, 255),
}

local ESP_SETTINGS = {
    Enabled = true,
    ShowTeammates = true,
    EnemiesOnly = false,
    UseCustomColors = false,
    FillTransparency = 0.4,
    OutlineTransparency = 0.1,
    ShowNameTags = true,
    ShowHealth = true,
    ShowDistance = true,
    TextSize = 14
}

local function isTeammate(player)
    if not player or player == LocalPlayer then return true end

    local lpTeam = LocalPlayer.Team
    local pTeam = player.Team

    if lpTeam and pTeam then
        if lpTeam == pTeam or (lpTeam.Name and pTeam.Name and lpTeam.Name == pTeam.Name) then
            return true
        end
    end

    local lpColor = LocalPlayer.TeamColor
    local pColor = player.TeamColor

    if lpColor and pColor then
        if lpColor == pColor or (lpColor.Name and pColor.Name and lpColor.Name == pColor.Name) or (lpColor.Color and pColor.Color and lpColor.Color == pColor.Color) then
            return true
        end
    end

    return false
end

local AIM_SETTINGS = {
    Enabled = false,
    AlwaysLock = false, -- Mobile mode: lock continuously without holding AimKey
    TeamCheck = true,
    WallCheck = true,
    SelectedParts = {"Head"}, -- Table of selected parts
    FOV = 150,
    ShowFOV = true,
    FOVColor = Color3.fromRGB(255, 255, 255),
    Smoothness = 0, -- 0 = Instant Lock, >0 = Smoother
    AimKey = Enum.UserInputType.MouseButton2 -- Right Click
}

local toggleKey = Enum.KeyCode.RightControl

local HttpService = game:GetService("HttpService")
local CONFIG_FILE = "ArsenalHub_Config.json"

local function ColorToTable(color)
    return {color.R, color.G, color.B}
end

local function TableToColor(tbl)
    if type(tbl) == "table" and #tbl >= 3 then
        return Color3.new(tbl[1], tbl[2], tbl[3])
    end
    return Color3.fromRGB(255, 255, 255)
end

local function saveConfig()
    if not writefile then return end

    local customColorsData = {}
    for k, v in pairs(CUSTOM_TEAM_COLORS) do
        customColorsData[k] = ColorToTable(v)
    end

    local data = {
        ESP_SETTINGS = ESP_SETTINGS,
        AIM_SETTINGS = {
            Enabled = AIM_SETTINGS.Enabled,
            TeamCheck = AIM_SETTINGS.TeamCheck,
            WallCheck = AIM_SETTINGS.WallCheck,
            SelectedParts = AIM_SETTINGS.SelectedParts,
            FOV = AIM_SETTINGS.FOV,
            ShowFOV = AIM_SETTINGS.ShowFOV,
            FOVColor = ColorToTable(AIM_SETTINGS.FOVColor),
            Smoothness = AIM_SETTINGS.Smoothness
        },
        CUSTOM_TEAM_COLORS = customColorsData,
        ToggleKeyName = toggleKey and toggleKey.Name or "RightControl"
    }

    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode(data))
    end)
end

local function loadConfig()
    if not (readfile and isfile and isfile(CONFIG_FILE)) then return end

    local success, content = pcall(function() return readfile(CONFIG_FILE) end)
    if not success or not content then return end

    local decodeSuccess, data = pcall(function() return HttpService:JSONDecode(content) end)
    if not decodeSuccess or type(data) ~= "table" then return end

    if data.ESP_SETTINGS then
        for k, v in pairs(data.ESP_SETTINGS) do
            ESP_SETTINGS[k] = v
        end
    end

    -- Ensure numeric ESP values stay valid numbers
    ESP_SETTINGS.FillTransparency = tonumber(ESP_SETTINGS.FillTransparency) or 0.4
    ESP_SETTINGS.OutlineTransparency = tonumber(ESP_SETTINGS.OutlineTransparency) or 0.1
    ESP_SETTINGS.TextSize = tonumber(ESP_SETTINGS.TextSize) or 14

    if data.AIM_SETTINGS then
        for k, v in pairs(data.AIM_SETTINGS) do
            if k == "FOVColor" then
                AIM_SETTINGS.FOVColor = TableToColor(v)
            else
                AIM_SETTINGS[k] = v
            end
        end
    end

    if data.CUSTOM_TEAM_COLORS then
        for k, v in pairs(data.CUSTOM_TEAM_COLORS) do
            CUSTOM_TEAM_COLORS[k] = TableToColor(v)
        end
    end

    if data.ToggleKeyName then
        pcall(function() toggleKey = Enum.KeyCode[data.ToggleKeyName] end)
    end
end

pcall(loadConfig)

-- FOV Circle setup safely
local fovCircle = nil
pcall(function()
    if Drawing and Drawing.new then
        fovCircle = Drawing.new("Circle")
        fovCircle.Thickness = 1.5
        fovCircle.Color = AIM_SETTINGS.FOVColor
        fovCircle.Filled = false
        fovCircle.Transparency = 0.8
        fovCircle.Visible = false
    end
end)

local lockedTargetPlayer = nil
local lockedTargetPart = nil

local function getTargetPart(player, char)
    if not char then return nil end

    if lockedTargetPlayer == player and lockedTargetPart and lockedTargetPart:IsDescendantOf(char) then
        return lockedTargetPart
    end

    local selected = AIM_SETTINGS.SelectedParts
    local validParts = {}

    if type(selected) == "table" then
        -- Handle both array-style tables {"Head"} and dictionary-style tables {Head = true} from WindUI/JSON
        local partsList = {}
        for key, val in pairs(selected) do
            if type(key) == "number" and type(val) == "string" then
                table.insert(partsList, val)
            elseif type(key) == "string" and val == true then
                table.insert(partsList, key)
            elseif type(val) == "string" then
                table.insert(partsList, val)
            end
        end

        for _, partName in ipairs(partsList) do
            local p = char:FindFirstChild(partName)
            if p then
                table.insert(validParts, p)
            end
        end
    elseif type(selected) == "string" then
        local p = char:FindFirstChild(selected)
        if p then
            table.insert(validParts, p)
        end
    end

    if #validParts > 0 then
        return validParts[math.random(1, #validParts)]
    end

    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function isPlayerVisible(targetPart)
    if not AIM_SETTINGS.WallCheck then return true end
    if not Camera then return false end

    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local filterList = {Camera}
    if LocalPlayer.Character then
        table.insert(filterList, LocalPlayer.Character)
    end
    raycastParams.FilterDescendantsInstances = filterList

    local result = Workspace:Raycast(origin, direction, raycastParams)
    if not result then
        return true
    end

    if result.Instance:IsDescendantOf(targetPart.Parent) then
        return true
    end

    return false
end

local function getClosestPlayerToCursor()
    local closestPlayer = nil
    local shortestDistance = AIM_SETTINGS.FOV
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local targetPart = getTargetPart(player, char)

            if hum and hum.Health > 0 and targetPart then
                -- Team check using proper helper
                if not (AIM_SETTINGS.TeamCheck and isTeammate(player)) then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen and screenPos.Z > 0 then
                        local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                        local dist = (screenVec - mousePos).Magnitude

                        if dist <= shortestDistance then
                            if isPlayerVisible(targetPart) then
                                shortestDistance = dist
                                closestPlayer = {
                                    Player = player,
                                    TargetPart = targetPart
                                }
                            end
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Aimbot / SilentAim RenderStepped loop & Target Caching
local currentTargetData = nil

RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if fovCircle then
        local mousePos = UserInputService:GetMouseLocation()
        fovCircle.Position = mousePos
        fovCircle.Radius = AIM_SETTINGS.FOV
        fovCircle.Color = AIM_SETTINGS.FOVColor
        fovCircle.Visible = AIM_SETTINGS.Enabled and AIM_SETTINGS.ShowFOV
    end

    -- Target locking & Caching (Calculated ONCE per frame for 144+ FPS performance)
    if AIM_SETTINGS.Enabled then
        currentTargetData = getClosestPlayerToCursor()
        if currentTargetData and currentTargetData.TargetPart then
            lockedTargetPlayer = currentTargetData.Player
            lockedTargetPart = currentTargetData.TargetPart
        else
            lockedTargetPlayer = nil
            lockedTargetPart = nil
        end
    else
        currentTargetData = nil
        lockedTargetPlayer = nil
        lockedTargetPart = nil
    end

    -- Camera aim
    if AIM_SETTINGS.Enabled and currentTargetData and currentTargetData.TargetPart then
        local isAimingKey = AIM_SETTINGS.AlwaysLock or UserInputService:IsMouseButtonPressed(AIM_SETTINGS.AimKey)
        if isAimingKey then
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, currentTargetData.TargetPart.Position)
            if AIM_SETTINGS.Smoothness <= 0 then
                Camera.CFrame = targetCFrame
            else
                Camera.CFrame = currentCFrame:Lerp(targetCFrame, math.clamp(AIM_SETTINGS.Smoothness, 0.01, 1))
            end
        end
    end
end)

local function getPlayerColor(player)
    local team = player.Team
    if team then
        local name = team.Name
        if ESP_SETTINGS.UseCustomColors and CUSTOM_TEAM_COLORS[name] then
            return CUSTOM_TEAM_COLORS[name]
        elseif TEAM_COLORS[name] then
            return TEAM_COLORS[name]
        end
        local teamColor = player.TeamColor
        if teamColor then
            return teamColor.Color
        end
    end
    return Color3.fromRGB(255, 255, 255)
end

local function updateHighlightStyle(player)
    if player == LocalPlayer or not player.Character then return end
    local highlight = player.Character:FindFirstChild("ArsenalESP_Highlight")
    if highlight then
        highlight.FillTransparency = ESP_SETTINGS.FillTransparency
        highlight.OutlineTransparency = ESP_SETTINGS.OutlineTransparency
        highlight.FillColor = getPlayerColor(player)
        highlight.OutlineColor = getPlayerColor(player)
    end
end

local function applyESP(player)
    if player == LocalPlayer then return end

    local function setupCharacter(char)
        if not char then return end

        local existingHighlight = char:FindFirstChild("ArsenalESP_Highlight")
        if existingHighlight then existingHighlight:Destroy() end
        local existingGui = char:FindFirstChild("ArsenalESP_Gui")
        if existingGui then existingGui:Destroy() end

        if not ESP_SETTINGS.Enabled then return end

        if (ESP_SETTINGS.EnemiesOnly or not ESP_SETTINGS.ShowTeammates) and isTeammate(player) then
            return
        end

        local color = getPlayerColor(player)

        local highlight = Instance.new("Highlight")
        highlight.Name = "ArsenalESP_Highlight"
        highlight.Adornee = char
        highlight.FillColor = color
        highlight.FillTransparency = ESP_SETTINGS.FillTransparency
        highlight.OutlineColor = color
        highlight.OutlineTransparency = ESP_SETTINGS.OutlineTransparency
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = char

        if ESP_SETTINGS.ShowNameTags then
            task.spawn(function()
                local head = char:WaitForChild("Head", 5)
                if not head or not char.Parent then return end

                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ArsenalESP_Gui"
                billboard.Adornee = head
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 2.8, 0)
                billboard.AlwaysOnTop = true

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = color
                textLabel.TextStrokeTransparency = 0.2
                textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.TextSize = ESP_SETTINGS.TextSize
                textLabel.Parent = billboard

                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")

                local function updateText()
                    if not ESP_SETTINGS.Enabled or not ESP_SETTINGS.ShowNameTags or ((ESP_SETTINGS.EnemiesOnly or not ESP_SETTINGS.ShowTeammates) and isTeammate(player)) then
                        billboard.Enabled = false
                        return
                    end
                    billboard.Enabled = true
                    textLabel.TextSize = ESP_SETTINGS.TextSize
                    textLabel.TextColor3 = getPlayerColor(player)

                    local rawTeam = player.Team and player.Team.Name or "No Team"
                    local teamStr = TEAM_NAMES[rawTeam] or rawTeam
                    local str = string.format("%s [%s]", player.DisplayName or player.Name, teamStr)

                    if ESP_SETTINGS.ShowHealth and humanoid then
                        local hp = math.floor(humanoid.Health)
                        local maxHp = math.floor(humanoid.MaxHealth)
                        str = str .. string.format("\nHP: %d/%d", hp, maxHp)
                    end

                    if ESP_SETTINGS.ShowDistance and hrp and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local myHrp = LocalPlayer.Character.HumanoidRootPart
                        local dist = math.floor((hrp.Position - myHrp.Position).Magnitude)
                        str = str .. string.format(" [%dm]", dist)
                    end

                    textLabel.Text = str
                end

                updateText()
                billboard.Parent = head

                if humanoid then
                    humanoid:GetPropertyChangedSignal("Health"):Connect(updateText)
                end

                task.spawn(function()
                    while char and char.Parent and head and head.Parent and billboard and billboard.Parent do
                        updateText()
                        task.wait(0.4)
                    end
                end)
            end)
        end
    end

    if player.Character then
        task.spawn(setupCharacter, player.Character)
    end
    player.CharacterAdded:Connect(setupCharacter)
end

local function refreshAllESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then
                local highlight = player.Character:FindFirstChild("ArsenalESP_Highlight")
                if highlight then highlight:Destroy() end
                local gui = player.Character:FindFirstChild("ArsenalESP_Gui")
                if gui then gui:Destroy() end
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local headGui = head:FindFirstChild("ArsenalESP_Gui")
                    if headGui then headGui:Destroy() end
                end
                if ESP_SETTINGS.Enabled then
                    applyESP(player)
                end
            end
        end
    end
end

local function fastStyleUpdate()
    for _, player in ipairs(Players:GetPlayers()) do
        updateHighlightStyle(player)
    end
end

local playerConnections = {}

local function listenPlayerTeam(player)
    if playerConnections[player] then return end
    playerConnections[player] = true

    local function onTeamChange()
        task.wait(0.1)
        refreshAllESP()
    end

    pcall(function() player:GetPropertyChangedSignal("Team"):Connect(onTeamChange) end)
    pcall(function() player:GetPropertyChangedSignal("TeamColor"):Connect(onTeamChange) end)
end

pcall(function() LocalPlayer:GetPropertyChangedSignal("Team"):Connect(refreshAllESP) end)
pcall(function() LocalPlayer:GetPropertyChangedSignal("TeamColor"):Connect(refreshAllESP) end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        listenPlayerTeam(player)
        applyESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        listenPlayerTeam(player)
        applyESP(player)
    end
end)

local Window = WindUI:CreateWindow({
    Title = "Arsenal Hub",
    Icon = "target",
    Author = "By Barron",
    Folder = "ArsenalHubConfig",
    Size = UDim2.fromOffset(640, 480),
    KeySystem = false
})

local CombatTab = Window:Tab({
    Title = "Combat / Aim",
    Icon = "crosshair"
})

CombatTab:Section({
    Title = "Aimbot Main"
})

CombatTab:Toggle({
    Title = "Enable Aimbot (Camera)",
    Desc = "Locks camera onto targets when holding Right Click or Mobile Toggle",
    Value = AIM_SETTINGS.Enabled,
    Callback = function(Value)
        AIM_SETTINGS.Enabled = Value
        saveConfig()
    end
})

CombatTab:Toggle({
    Title = "Always Lock (Mobile Mode)",
    Desc = "Auto-lock target continuously without holding Right Click",
    Value = AIM_SETTINGS.AlwaysLock,
    Callback = function(Value)
        AIM_SETTINGS.AlwaysLock = Value
        saveConfig()
    end
})

CombatTab:Toggle({
    Title = "Team Check",
    Desc = "Ignore teammates",
    Value = AIM_SETTINGS.TeamCheck,
    Callback = function(Value)
        AIM_SETTINGS.TeamCheck = Value
        saveConfig()
    end
})

CombatTab:Toggle({
    Title = "Wall Check (Visibility)",
    Desc = "Only aim at enemies behind no obstacles",
    Value = AIM_SETTINGS.WallCheck,
    Callback = function(Value)
        AIM_SETTINGS.WallCheck = Value
        saveConfig()
    end
})

CombatTab:Dropdown({
    Title = "Aim Target Part",
    Desc = "Select target body parts (Selecting multiple will pick randomly)",
    Multi = true,
    Values = {
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso"
    },
    Value = AIM_SETTINGS.SelectedParts,
    Callback = function(Value)
        if type(Value) == "table" then
            AIM_SETTINGS.SelectedParts = Value
        else
            AIM_SETTINGS.SelectedParts = {Value}
        end
        saveConfig()
    end
})

CombatTab:Section({
    Title = "FOV & Smoothness"
})

CombatTab:Toggle({
    Title = "Show FOV Circle",
    Desc = "Draw circle around mouse cursor",
    Value = AIM_SETTINGS.ShowFOV,
    Callback = function(Value)
        AIM_SETTINGS.ShowFOV = Value
        saveConfig()
    end
})

CombatTab:Slider({
    Title = "FOV Radius",
    Desc = "Aimbot targeting range around cursor",
    Value = {
        Min = 30,
        Max = 500,
        Default = AIM_SETTINGS.FOV
    },
    Step = 5,
    Callback = function(val)
        local num = type(val) == "table" and (val.Value or val.val or val[1]) or val
        if type(num) == "number" then
            AIM_SETTINGS.FOV = num
            saveConfig()
        end
    end
})

CombatTab:Slider({
    Title = "Smoothness",
    Desc = "Aim speed / smoothness (0 = Instant Lock, Higher = Snappier/Smoother)",
    Value = {
        Min = 0,
        Max = 1,
        Default = AIM_SETTINGS.Smoothness
    },
    Step = 0.05,
    Callback = function(val)
        local num = type(val) == "table" and (val.Value or val.val or val[1]) or val
        if type(num) == "number" then
            AIM_SETTINGS.Smoothness = num
            saveConfig()
        end
    end
})

CombatTab:Colorpicker({
    Title = "FOV Circle Color",
    Default = AIM_SETTINGS.FOVColor,
    Callback = function(Value)
        AIM_SETTINGS.FOVColor = Value
        saveConfig()
    end
})

local VisualsTab = Window:Tab({
    Title = "Visuals / ESP",
    Icon = "eye"
})

VisualsTab:Section({
    Title = "Main Controls"
})

VisualsTab:Toggle({
    Title = "Enable Team ESP",
    Desc = "Toggle entire ESP System",
    Value = ESP_SETTINGS.Enabled,
    Callback = function(Value)
        ESP_SETTINGS.Enabled = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Toggle({
    Title = "Show Enemies Only",
    Desc = "Only display ESP on enemy players (Hide Teammates)",
    Value = ESP_SETTINGS.EnemiesOnly,
    Callback = function(Value)
        ESP_SETTINGS.EnemiesOnly = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Toggle({
    Title = "Show Teammates",
    Desc = "Include players in your own team",
    Value = ESP_SETTINGS.ShowTeammates,
    Callback = function(Value)
        ESP_SETTINGS.ShowTeammates = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Section({
    Title = "NameTag Customization"
})

VisualsTab:Toggle({
    Title = "Show NameTags",
    Desc = "Show player name and team tag above head",
    Value = ESP_SETTINGS.ShowNameTags,
    Callback = function(Value)
        ESP_SETTINGS.ShowNameTags = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Toggle({
    Title = "Show HP Status",
    Desc = "Display health points on NameTag",
    Value = ESP_SETTINGS.ShowHealth,
    Callback = function(Value)
        ESP_SETTINGS.ShowHealth = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Toggle({
    Title = "Show Distance",
    Desc = "Display distance in meters on NameTag",
    Value = ESP_SETTINGS.ShowDistance,
    Callback = function(Value)
        ESP_SETTINGS.ShowDistance = Value
        refreshAllESP()
        saveConfig()
    end
})

VisualsTab:Slider({
    Title = "Text Size",
    Desc = "Adjust NameTag font size",
    Value = {
        Min = 10,
        Max = 24,
        Default = ESP_SETTINGS.TextSize
    },
    Step = 1,
    Callback = function(val)
        local num = type(val) == "table" and (val.Value or val.val or val[1]) or val
        if type(num) == "number" then
            ESP_SETTINGS.TextSize = num
            fastStyleUpdate()
            saveConfig()
        end
    end
})

VisualsTab:Section({
    Title = "Highlight Style"
})

VisualsTab:Slider({
    Title = "Fill Transparency",
    Desc = "Highlight inner body transparency",
    Value = {
        Min = 0,
        Max = 1,
        Default = ESP_SETTINGS.FillTransparency
    },
    Step = 0.05,
    Callback = function(val)
        local num = type(val) == "table" and (val.Value or val.val or val[1]) or val
        if type(num) == "number" then
            ESP_SETTINGS.FillTransparency = num
            fastStyleUpdate()
            saveConfig()
        end
    end
})

VisualsTab:Slider({
    Title = "Outline Transparency",
    Desc = "Highlight border outline transparency",
    Value = {
        Min = 0,
        Max = 1,
        Default = ESP_SETTINGS.OutlineTransparency
    },
    Step = 0.05,
    Callback = function(val)
        local num = type(val) == "table" and (val.Value or val.val or val[1]) or val
        if type(num) == "number" then
            ESP_SETTINGS.OutlineTransparency = num
            fastStyleUpdate()
            saveConfig()
        end
    end
})

local ColorsTab = Window:Tab({
    Title = "Team Colors",
    Icon = "palette"
})

ColorsTab:Section({
    Title = "Custom Color Toggle"
})

ColorsTab:Toggle({
    Title = "Use Custom Team Colors",
    Desc = "Override default game team colors with custom color pickers below",
    Value = ESP_SETTINGS.UseCustomColors,
    Callback = function(Value)
        ESP_SETTINGS.UseCustomColors = Value
        fastStyleUpdate()
        saveConfig()
    end
})

ColorsTab:Section({
    Title = "Customize Each Team Color"
})

ColorsTab:Colorpicker({
    Title = "TPC (Purple Team)",
    Default = CUSTOM_TEAM_COLORS["TPC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TPC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

ColorsTab:Colorpicker({
    Title = "TRC (Red Team)",
    Default = CUSTOM_TEAM_COLORS["TRC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TRC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

ColorsTab:Colorpicker({
    Title = "TOC (Orange Team)",
    Default = CUSTOM_TEAM_COLORS["TOC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TOC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

ColorsTab:Colorpicker({
    Title = "TYC (Yellow Team)",
    Default = CUSTOM_TEAM_COLORS["TYC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TYC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

ColorsTab:Colorpicker({
    Title = "TGC (Green Team)",
    Default = CUSTOM_TEAM_COLORS["TGC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TGC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

ColorsTab:Colorpicker({
    Title = "TBC (Blue Team)",
    Default = CUSTOM_TEAM_COLORS["TBC"],
    Callback = function(Value)
        CUSTOM_TEAM_COLORS["TBC"] = Value
        if ESP_SETTINGS.UseCustomColors then fastStyleUpdate() end
        saveConfig()
    end
})

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings"
})

SettingsTab:Section({
    Title = "Configuration Storage"
})

SettingsTab:Button({
    Title = "Save Settings",
    Desc = "Save all current settings to config file",
    Callback = function()
        saveConfig()
        if WindUI and WindUI.Notify then
            pcall(function()
                WindUI:Notify({
                    Title = "Config Saved",
                    Content = "Successfully saved settings to ArsenalHub_Config.json",
                    Duration = 3
                })
            end)
        end
    end
})

SettingsTab:Button({
    Title = "Load Settings",
    Desc = "Reload saved settings from config file",
    Callback = function()
        loadConfig()
        refreshAllESP()
        if WindUI and WindUI.Notify then
            pcall(function()
                WindUI:Notify({
                    Title = "Config Loaded",
                    Content = "Successfully loaded settings from config file!",
                    Duration = 3
                })
            end)
        end
    end
})

SettingsTab:Section({
    Title = "UI Menu Keybind"
})

SettingsTab:Keybind({
    Title = "Toggle UI Menu Key",
    Desc = "Press key to hide or show menu UI",
    Value = toggleKey and toggleKey.Name or "RightControl",
    Callback = function(key)
        if key then
            if type(key) == "string" then
                local success, enumVal = pcall(function() return Enum.KeyCode[key] end)
                if success and enumVal then
                    toggleKey = enumVal
                end
            elseif typeof(key) == "EnumItem" then
                toggleKey = key
            end
            saveConfig()
        end
    end
})

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == toggleKey then
        if Window and Window.Toggle then
            Window:Toggle()
        end
    end
end)

SettingsTab:Section({
    Title = "Menu Management"
})

SettingsTab:Button({
    Title = "Toggle Menu Visibility",
    Desc = "Manually open / close the UI window",
    Callback = function()
        if Window and Window.Toggle then
            Window:Toggle()
        end
    end
})

-- Create Floating Mobile Toggle Button (Touch Screen Support)
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "ArsenalHub_MobileGui"
mobileGui.ResetOnSpawn = false

local mobileBtn = Instance.new("TextButton")
mobileBtn.Name = "MobileToggleBtn"
mobileBtn.Size = UDim2.fromOffset(50, 50)
mobileBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
mobileBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mobileBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mobileBtn.Text = "🎯"
mobileBtn.TextSize = 24
mobileBtn.Font = Enum.Font.GothamBold
mobileBtn.Active = true
mobileBtn.Draggable = true
mobileBtn.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mobileBtn

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 2
stroke.Parent = mobileBtn

local CoreGui = game:GetService("CoreGui")
pcall(function()
    mobileGui.Parent = CoreGui
end)
if not mobileGui.Parent then
    mobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

mobileBtn.MouseButton1Click:Connect(function()
    if Window and Window.Toggle then
        Window:Toggle()
    end
end)

SettingsTab:Button({
    Title = "Unload / Destroy Hub",
    Desc = "Remove UI and clear all ESP & Aimbot connections",
    Callback = function()
        ESP_SETTINGS.Enabled = false
        AIM_SETTINGS.Enabled = false
        refreshAllESP()
        if fovCircle then pcall(function() fovCircle:Destroy() end) end
        if mobileGui then pcall(function() mobileGui:Destroy() end) end
        if Window and Window.Destroy then
            Window:Destroy()
        end
    end
})

pcall(function()
    if CombatTab and CombatTab.Select then
        CombatTab:Select()
    elseif Window and Window.SelectTab then
        Window:SelectTab(CombatTab)
    end
end)