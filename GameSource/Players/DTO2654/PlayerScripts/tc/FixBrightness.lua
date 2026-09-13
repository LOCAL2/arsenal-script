-- Decompiled with Potassium's decompiler.

function applyLowLighting(p1)
    local Attribute = p1:GetAttribute("Brightness");
    local Attribute2 = p1:GetAttribute("DisableBloom");
    local Attribute3 = p1:GetAttribute("DisableIllumination");
    local Attribute4 = p1:GetAttribute("MultiplyBrightness");
    local Attribute5 = p1:GetAttribute("MultiplyLocalLights");

    if Attribute then
        game.Lighting.Brightness = Attribute;
    end;

    if Attribute2 then
        for _, child in game.Lighting:GetChildren() do
            if child:IsA("BloomEffect") then
                child.Enabled = false;
            end;
        end;
    end;

    if Attribute3 and workspace:FindFirstChild("Map") then
        for _, descendant in workspace.Map:GetDescendants() do
            if (descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight"))) and not descendant:GetAttribute("ForceOn") then
                descendant.Enabled = false;
            end;
        end;
    end;

    if Attribute4 then
        local game_Lighting = game.Lighting;
        game_Lighting.Brightness = game_Lighting.Brightness * Attribute4;
    end;

    if Attribute5 then
        for _, descendant in workspace.Map:GetDescendants() do
            if descendant:IsA("PointLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("SpotLight")) then
                descendant.Brightness = descendant.Brightness * Attribute5;
            end;
        end;
    end;
end;

workspace.ChildAdded:Connect(function(p2) -- Line: 47
    if p2.Name == "Map" then
        wait(1);

        if p2:FindFirstChild("LightingLow") and not game.Lighting.GlobalShadows then
            applyLowLighting(p2.LightingLow);
        end;
    end;
end);
game.Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function() -- Line: 55
    if game.Lighting.GlobalShadows == false and (workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("LightingLow")) then
        applyLowLighting(workspace.Map.LightingLow);
    end;
end);