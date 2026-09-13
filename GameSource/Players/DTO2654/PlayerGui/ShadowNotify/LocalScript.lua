-- Decompiled with Potassium's decompiler.

local v1 = tick();
local u2 = false;
local u3 = false;
local _ = v1 - 45;

function GetQuality()
    -- upvalues: u3 (ref)
    local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel;
    local u4 = 6;
    pcall(function() -- Line: 15
        -- upvalues: u4 (ref), SavedQualityLevel (copy)
        u4 = SavedQualityLevel.Value;
    end);

    if game:GetService("GuiService"):IsTenFootInterface() then
        u4 = 10;
        u3 = true;
    end;

    return u4;
end;

function UpdateShadows()
    local v5 = GetQuality();
    local v6 = v5 == nil and 1 or v5;

    if v6 < 8 then
        game.Lighting.ShadowSoftness = 0;

        return;
    end;

    if v6 < 9 then
        game.Lighting.ShadowSoftness = 0.25;

        return;
    end;

    game.Lighting.ShadowSoftness = 0.3;
end;

function UpdateShadowCasters()
    -- upvalues: u3 (ref)
    local v7 = GetQuality();
    local v8 = v7 == nil and 1 or v7;

    if v8 < 7 or u3 then
        for _, descendant in pairs(game.ReplicatedStorage.Weapons:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CastShadow = false;
            end;
        end;

        for _, descendant in pairs(game.ReplicatedStorage.Particles:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CastShadow = false;
            end;
        end;
    else
        for _, descendant in pairs(game.ReplicatedStorage.Weapons:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CastShadow = true;
            end;
        end;

        for _, descendant in pairs(game.ReplicatedStorage.Particles:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.CastShadow = true;
            end;
        end;

        if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("EnableExperimentalDestruction") == nil then
            for _, descendant in pairs(workspace.Map:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    if descendant.Parent == workspace.Map.Clips or descendant.Parent == workspace.Map.Ignore then
                        descendant.CastShadow = true;
                    end;

                    if descendant.Size.magnitude <= 12 then
                        descendant.CastShadow = true;
                    end;
                end;
            end;
        end;
    end;

    if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("EnableExperimentalDestruction") == nil then
        if v8 < 7 then
            for _, descendant in pairs(workspace.Map:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    if u3 and descendant.Size.magnitude < 16 then
                        descendant.CastShadow = false;
                    end;

                    if descendant.Size.magnitude < 12 then
                        descendant.CastShadow = false;
                    end;

                    if descendant.Parent == workspace.Map.Clips or descendant.Parent == workspace.Map.Ignore then
                        descendant.CastShadow = false;
                    end;
                end;
            end;

            return;
        end;

        if v8 < 8 then
            for _, descendant in pairs(workspace.Map:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Size.magnitude < 7 then
                    descendant.CastShadow = false;
                end;
            end;
        end;
    end;
end;

function UpdateDetailFolder()
    if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Detail") then
        local v9 = GetQuality();

        if (v9 == nil and 1 or v9) < 4 then
            for _, descendant in pairs(workspace.Map.Detail:GetDescendants()) do
                if descendant:IsA("BasePart") and descendant.Parent.Name ~= "Decals" then
                    descendant.Transparency = 1;
                elseif descendant:IsA("SurfaceGui") then
                    descendant.Enabled = false;
                elseif descendant:IsA("BasePart") and descendant.Parent.Name == "Decals" then
                    for _, child in pairs(descendant:GetChildren()) do
                        child.Transparency = 1;
                    end;
                end;
            end;

            return;
        end;

        for _, descendant in pairs(workspace.Map.Detail:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Parent.Name ~= "Decals" then
                descendant.Transparency = 0;
            elseif descendant:IsA("SurfaceGui") then
                descendant.Enabled = true;
            elseif descendant:IsA("BasePart") and descendant.Parent.Name == "Decals" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:FindFirstChild("OriginalTransparency") then
                        child.Transparency = child.OriginalTransparency.Value;
                    else
                        child.Transparency = 0;
                    end;
                end;
            end;
        end;
    end;
end;

function UpdateGL()
    local v10 = GetQuality();

    if workspace:FindFirstChild("Map") and (workspace.Map:FindFirstChild("Ignore") and workspace.Map.Ignore:FindFirstChild("GLLights")) then
        if v10 < 10 then
            for _, descendant in pairs(workspace.Map.Ignore.GLLights:GetDescendants()) do
                if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                    if descendant.Shadows then
                        local BoolValue = Instance.new("BoolValue");
                        BoolValue.Parent = descendant;
                        BoolValue.Name = "ShadowCaster";
                    end;

                    descendant.Shadows = false;
                end;
            end;
        end;

        if v10 < 9 then
            for _, descendant in pairs(workspace.Map.Ignore.GLLights:GetDescendants()) do
                if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                    descendant.Enabled = false;
                end;
            end;
        elseif game.Players.LocalPlayer:FindFirstChild("Settings") and (game.Players.LocalPlayer.Settings:FindFirstChild("Shadows") and game.Players.LocalPlayer.Settings.Shadows.Value == false) then
            for _, descendant in pairs(workspace.Map.Ignore.GLLights:GetDescendants()) do
                if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                    descendant.Enabled = false;
                end;
            end;
        else
            for _, descendant in pairs(workspace.Map.Ignore.GLLights:GetDescendants()) do
                if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                    descendant.Enabled = true;
                end;
            end;
        end;

        if v10 >= 9 then
            for _, descendant in pairs(workspace.Map.Ignore.GLLights:GetDescendants()) do
                if (descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight"))) and descendant:FindFirstChild("ShadowCaster") then
                    descendant.Shadows = true;
                    descendant.ShadowCaster:Destroy();
                end;
            end;
        end;
    end;
end;

function UpdateLights()
    if game.Players.LocalPlayer:FindFirstChild("Settings") and (game.Players.LocalPlayer.Settings:FindFirstChild("Shadows") and game.Players.LocalPlayer.Settings.Shadows.Value == false) then
        for _, descendant in pairs(workspace.Map:GetDescendants()) do
            if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                descendant.Shadows = false;
            end;
        end;

        local v11 = game.Lighting:FindFirstChildOfClass("BloomEffect");

        if v11 then
            v11.Enabled = false;
        end;
    end;
end;

function UpdateTextures()
    -- upvalues: u3 (ref)
    local v12 = GetQuality();

    if workspace:FindFirstChild("Map") then
        for _, descendant in pairs(workspace.Map:GetDescendants()) do
            if descendant:IsA("Texture") or descendant:IsA("Decal") then
                if descendant.Name == "DizzyDetailTexture" then
                    if v12 <= 3 and u3 == false then
                        descendant.Transparency = 1;
                    else
                        descendant.Transparency = 0.8;

                        if descendant.Texture == "http://www.roblox.com/asset/?id=6043957790" then
                            descendant.Transparency = 0;
                        end;
                    end;
                elseif descendant.Name == "DizzyDetailTextureLevel2" then
                    if v12 <= 6 then
                        descendant.Transparency = 1;
                    else
                        descendant.Transparency = 0.75;
                    end;
                end;
            end;
        end;
    end;
end;

UpdateDetailFolder();
UpdateLights();
UpdateTextures();
local u13 = false;
UserSettings().GameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(function() -- Line: 279
    -- upvalues: u13 (ref), u2 (ref)
    GetQuality();
    UpdateDetailFolder();
    UpdateTextures();

    if u13 == false then
        u13 = true;

        repeat
            wait();
        until u2 == false;

        u13 = false;
    end;
end);
game:GetService("GuiService").MenuOpened:Connect(function() -- Line: 308
    -- upvalues: u2 (ref)
    u2 = true;
end);
game:GetService("GuiService").MenuClosed:Connect(function() -- Line: 312
    -- upvalues: u2 (ref)
    u2 = false;
end);
workspace.ChildAdded:Connect(function(p14) -- Line: 316
    if p14.Name == "Map" then
        wait();
        wait(4);
        UpdateDetailFolder();
        UpdateLights();
        UpdateDetailFolder();
        UpdateTextures();
    end;
end);