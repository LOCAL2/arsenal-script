-- Decompiled with Potassium's decompiler.

local v1 = {};
local Lighting = game:GetService("Lighting");
local u2 = { "Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", "EnvironmentSpecularScale", "GlobalShadows", "OutdoorAmbient", "ShadowSoftness", "ClockTime", "GeographicLatitude", "ExposureCompensation", "FogColor", "FogEnd", "FogStart" };
local u3 = false;

function LoadAttributes(p4)
    -- upvalues: Lighting (copy), u2 (copy)
    for _, child in p4:GetChildren() do
        local v5 = child:Clone();

        if v5:IsA("Clouds") then
            v5.Name = "Clouds";
            v5.Parent = workspace.Terrain;
        else
            v5.Parent = Lighting;
        end;
    end;

    for _, v in ipairs(u2) do
        local Attribute = p4:GetAttribute(v);

        if Attribute then
            Lighting[v] = Attribute;
        end;
    end;
end;

function LoadValues(p6)
    -- upvalues: Lighting (copy)
    if p6:FindFirstChild("Lighting") then
        for _, descendant in pairs(p6.Lighting:GetDescendants()) do
            if descendant:IsA("Sky") or descendant:IsA("Atmosphere") then
                descendant.Parent = Lighting;
            elseif descendant.Parent.Name == "Shaders" then
                descendant.Parent = Lighting;
            elseif not descendant:IsA("Folder") then
                Lighting[descendant.Name] = descendant.Value;
            end;
        end;
    end;
end;

function v1.ClearLighting() -- Line: 53
    -- upvalues: Lighting (copy)
    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    if workspace.Terrain:FindFirstChild("Clouds") then
        workspace.Terrain.Clouds:Destroy();
    end;

    game.Lighting.ExposureCompensation = 0;
end;

local u7 = { "Lighting", "SavedLighting", "ConvertedLighting" };

function v1.LoadLighting(p8) -- Line: 65
    -- upvalues: u7 (copy)
    local v9 = nil;

    for _, v in ipairs(u7) do
        local v10 = p8:FindFirstChild(v);

        if v10 then
            v9 = v10;
        end;
    end;

    if v9 then
        if v9:IsA("Configuration") then
            LoadAttributes(v9);

            return;
        end;

        LoadValues(p8);

        return;
    end;

    LoadAttributes(script.Default);
    warn("Loaded default lighting fallback");
end;

local u11 = true;

function v1.StartDynamicTime(p12) -- Line: 87
    -- upvalues: u3 (ref), u11 (ref), Lighting (copy)
    local v13 = p12 or 1;
    local u14 = 5 / v13;
    local u15 = 0.001 * v13;
    u3 = true;
    task.spawn(function() -- Line: 95
        -- upvalues: u11 (ref), u14 (copy), u3 (ref), Lighting (ref), u15 (copy)
        if not u11 then
            repeat
                wait();
            until u11;
        end;

        while wait(u14) do
            u11 = false;

            if not u3 then
                u11 = true;

                return;
            end;

            local v16 = Lighting;
            v16.ClockTime = v16.ClockTime + u15;
        end;
    end);
end;

function v1.StopDynamicTime() -- Line: 110
    -- upvalues: u3 (ref)
    u3 = false;
end;

return v1;