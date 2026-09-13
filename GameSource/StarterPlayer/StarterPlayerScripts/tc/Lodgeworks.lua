-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In);

function main()
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    local workspace_Map = workspace.Map;
    local sfx = workspace.Map.sfx;
    local Rain = sfx.Rain;
    local RainIndoor = sfx.RainIndoor;
    local Wind = sfx.Wind;
    Rain.Volume = 0;
    RainIndoor.Volume = 0;
    Rain:Play();
    RainIndoor:Play();
    Wind.Volume = 0;
    Wind:Play();
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace_Map.Ignore.NoRain };
    local LocalPlayer = game.Players.LocalPlayer;
    local v1 = false;

    while wait(0.5) and (workspace:FindFirstChild("Map") ~= nil and (not workspace:FindFirstChild("Map") or workspace.Map.Ignore:FindFirstChild("NoRain") ~= nil)) do
        if LocalPlayer.Character then
            local v2 = workspace:Raycast(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.CFrame.UpVector * 90, RaycastParams_new_ret);
            v1 = v2 and v2.Instance and true or false;
        end;

        if v1 and RainIndoor.Volume == 0 then
            local v3 = TweenService:Create(RainIndoor, TweenInfo_new_ret, {
                Volume = 0.15
            });
            local v4 = TweenService:Create(Wind, TweenInfo_new_ret, {
                Volume = 0
            });
            local v5 = TweenService:Create(Rain, TweenInfo_new_ret, {
                Volume = 0
            });
            v4:Play();
            v3:Play();
            v5:Play();
            game.Debris:AddItem(v3, 1);
            game.Debris:AddItem(v5, 1);
            game.Debris:AddItem(v4, 1);
        elseif not v1 and Rain.Volume == 0 then
            local v6 = TweenService:Create(RainIndoor, TweenInfo_new_ret, {
                Volume = 0
            });
            local v7 = TweenService:Create(Rain, TweenInfo_new_ret, {
                Volume = 0.06
            });
            local v8 = TweenService:Create(Wind, TweenInfo_new_ret, {
                Volume = 0.4
            });
            v6:Play();
            v7:Play();
            v8:Play();
            game.Debris:AddItem(v6, 1);
            game.Debris:AddItem(v7, 1);
            game.Debris:AddItem(v8, 1);
        end;
    end;
end;

if workspace:FindFirstChild("Map") and (workspace.Map:FindFirstChild("Ignore") and workspace.Map.Ignore:FindFirstChild("NoRain")) then
    main();
end;

workspace.ChildAdded:Connect(function(p9) -- Line: 81
    if p9.Name == "Map" then
        wait(1);

        if p9:FindFirstChild("Ignore") and p9.Ignore:FindFirstChild("NoRain") then
            main();
        end;
    end;
end);