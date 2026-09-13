-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local TweenService = game:GetService("TweenService");
local ServerStorage = game:GetService("ServerStorage");
game:GetService("ContentProvider");
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = false;
local u5 = game:GetService("RunService"):IsStudio() and 0.8 or 1;

local function getTarget() -- Line: 24
    -- upvalues: Players (copy)
    local v6 = {};

    for _, child in pairs(Players:GetChildren()) do
        if child.Character and (child.Character:FindFirstChild("Humanoid") and (child.Character.Humanoid.Health > 0 and (child.Character:FindFirstChild("HumanoidRootPart") and (child:FindFirstChild("Status") and child.Status.Alive.Value)))) then
            table.insert(v6, child);
        end;
    end;

    return #v6 >= 1 and v6[math.random(1, #v6)] or nil;
end;

local function getY(p7, p8) -- Line: 36
    return -1 * p7 ^ 2 + p8 * p7;
end;

function u1.spinPlate(u9) -- Line: 40
    u9.Geometry.Ring.Mass.AV.AngularVelocity = Vector3.new(0, 0.2617994, 0);
    spawn(function() -- Line: 43
        -- upvalues: u9 (copy)
        wait(math.random(4, 9) + math.random(0, 1000) / 1000);
        u9.Geometry.Ring.Mass.AV.AngularVelocity = Vector3.new(0, 0, 0);
    end);
end;

local function doTarget(p10) -- Line: 50
    -- upvalues: Players (copy)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and (v.Character.HumanoidRootPart.CFrame.p - p10.Boss.HumanoidRootPart.CFrame.p).magnitude <= 250) then
            return v;
        end;
    end;

    return false;
end;

local function checkTargets(p11) -- Line: 60
    -- upvalues: u2 (ref), doTarget (copy), u3 (ref)
    if not u2 or (not u2.Character or u2.Character and not u2.Character:FindFirstChild("HumanoidRootPart")) or u2.Character and (u2.Character:FindFirstChild("HumanoidRootPart") and (u2.Character.HumanoidRootPart.CFrame.p - p11.Boss.HumanoidRootPart.CFrame.p).magnitude > 250) then
        u2 = doTarget(p11);
    end;

    if not u3 or (not u3.Character or u3.Character and not u3.Character:FindFirstChild("HumanoidRootPart")) or u3.Character and (u3.Character:FindFirstChild("HumanoidRootPart") and (u3.Character.HumanoidRootPart.CFrame.p - p11.Boss.HumanoidRootPart.CFrame.p).magnitude > 250) then
        u3 = doTarget(p11);
    end;
end;

local function doRay(p12, p13, p14, p15, p16) -- Line: 70
    -- upvalues: Workspace (copy)
    local v17, v18 = Workspace:FindPartOnRay(Ray.new(p13.p, (p14 - p13.p).unit * 500), p12, false, true);

    if v17 and p16 then
        local magnitude = (p14 - p13.p).magnitude;
        p15.CFrame = CFrame.new(p13.p, v18) * CFrame.new(0, 0, -magnitude / 2);
        p15.Size = Vector3.new(p16, p16, magnitude);
    end;

    return v17, v18;
end;

function u1.shootGun(p19) -- Line: 83
    -- upvalues: u2 (ref), doTarget (copy), u3 (ref), checkTargets (copy), doRay (copy), Players (copy), ServerStorage (copy)
    if p19.Boss.Gun:FindFirstChild("Beam") then
        return;
    end;

    u2 = doTarget(p19);
    u3 = doTarget(p19);
    local v20 = script.Beam:Clone();
    v20.CFrame = p19.Boss.Gun_L.CFrame;
    v20.Parent = p19.Boss.Gun_L;
    local v21 = script.Beam:Clone();
    v21.CFrame = p19.Boss.Gun.CFrame;
    v21.Parent = p19.Boss.Gun;
    local v22 = nil;
    local v23 = nil;

    for i = 8, 0, -0.1 do
        checkTargets(p19);

        if u2 then
            local v24;
            v24, v22 = doRay(p19, p19.Boss.Gun_L.CFrame, u2.Character.HumanoidRootPart.CFrame.p, v20, i);
        end;

        if u3 then
            local v25;
            v25, v23 = doRay(p19, p19.Boss.Gun.CFrame, u3.Character.HumanoidRootPart.CFrame.p, v21, i);
        end;

        wait(0.02);
        local _ = i;
    end;

    wait(0.5);
    checkTargets(p19);

    if u2 then
        local v26, _ = doRay(p19, p19.Boss.Gun_L.CFrame, v22, v20, false);
        local v27 = v26 and Players:GetPlayerFromCharacter(v26.Parent);

        if v27 then
            v26 = v27;
        elseif v26 then
            v26 = Players:GetPlayerFromCharacter(v26.Parent.Parent);
        end;

        if v26 then
            local Health = v26.NRPBS.Health;
            Health.Value = Health.Value - 25;
        end;
    end;

    if u3 then
        local v28, _ = doRay(p19, p19.Boss.Gun_L.CFrame, v23, v21, false);
        local v29 = v28 and Players:GetPlayerFromCharacter(v28.Parent);

        if v29 then
            v28 = v29;
        elseif v28 then
            v28 = Players:GetPlayerFromCharacter(v28.Parent.Parent);
        end;

        if v28 then
            local Health = v28.NRPBS.Health;
            Health.Value = Health.Value - 25;
        end;
    end;

    v20:Destroy();
    v21:Destroy();
    ServerStorage.Anim:Fire("Fire");
end;

local u30 = nil;

function getp(p31)
    return math.ceil(p31.Boss.Humanoid.Health * 100 / p31.Boss.Humanoid.MaxHealth);
end;

function equaterooms(p32)
    local v33 = getp(p32) * 8 / 100;
    local v34 = 10 - math.ceil(v33);

    return math.clamp(v34, 2, 9);
end;

function u1.generateObby(u35) -- Line: 156
    -- upvalues: u30 (ref), u1 (copy), ServerStorage (copy), Players (copy), TweenService (copy), u5 (ref)
    if u30 then
        u30:disconnect();
    end;

    u35.Procedural:ClearAllChildren();
    local u36 = equaterooms(u35);
    local v37 = nil;
    u30 = u35.Boss.Humanoid:GetPropertyChangedSignal("Health"):connect(function() -- Line: 168
        -- upvalues: u35 (copy), u36 (ref), u1 (ref)
        if equaterooms(u35) ~= u36 then
            u36 = equaterooms(u35);
            u1.generateObby(u35);
        end;
    end);

    for i = 1, u36 do
        local u38 = ServerStorage.Obby_Kit.Room:Clone();
        local Children = ServerStorage.Obby_Kit.A:GetChildren();
        local v39 = Children[math.random(1, #Children)]:Clone();
        local Children2 = ServerStorage.Obby_Kit.B:GetChildren();
        local v40 = Children2[math.random(1, #Children2)]:Clone();
        local Children3 = ServerStorage.Obby_Kit.C:GetChildren();
        local v41 = Children3[math.random(1, #Children3)]:Clone();
        v39.Parent = u38.Trap;
        v40.Parent = u38.Trap;
        v41.Parent = u38.Trap;

        if i == 1 then
            v39:Destroy();
        end;

        u38.Name = "Room" .. i;
        u38:SetPrimaryPartCFrame(v37 and v37.HookB.CFrame or u35.Ignore.ObbyStart.CFrame);
        u38.Parent = u35.Procedural;
        local v42 = i;

        for _, descendant in pairs(u38.Trap:GetDescendants()) do
            local v43 = descendant:IsA("Animation") and descendant.Parent and descendant.Parent:FindFirstChild("Cube.001") == nil;
            local v44 = descendant.Parent:FindFirstChild("AnimationController") or descendant.Parent:FindFirstChild("Humanoid");

            if v43 and v44 then
                local v45 = v44:LoadAnimation(descendant);
                v45.Looped = true;
                v45:Play();
            end;

            local u46;

            if descendant.Name == "Axe_Blade" or (descendant.Name == "Obby_Gullotine" or descendant.Name == "Spikes") then
                u46 = descendant:IsA("BasePart") and descendant;
            else
                u46 = false;
            end;

            if u46 then
                local u47 = {};
                u46.Touched:connect(function(p48) -- Line: 211
                    -- upvalues: Players (ref), u47 (copy), u46 (copy), u38 (copy)
                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p48.Parent);

                    if PlayerFromCharacter and (not u47[PlayerFromCharacter] or os.time() - u47[PlayerFromCharacter] >= 3) and u46.CFrame.Y >= u38.HookA.CFrame.Y then
                        u47[PlayerFromCharacter] = os.time();
                        PlayerFromCharacter.NRPBS.Health.Value = 0;
                    end;
                end);
            end;
        end;

        if v42 == 1 then
            u38.Bonk.DoorA.Transparency = 0;
            u38.Bonk.DoorA.CanCollide = true;
            u38.Bonk.DoorB:Destroy();
            u38.Portal:Destroy();
        elseif v42 == u36 then
            u38.Bonk.DoorB.Transparency = 0;
            u38.Bonk.DoorB.CanCollide = true;
            u38.Bonk.DoorA:Destroy();
            u38.Portal.Portal.Enabled = true;
            local u49 = false;
            u38.Portal.Touched:connect(function(p50) -- Line: 235
                -- upvalues: Players (ref), u49 (ref), u35 (copy)
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p50.Parent);

                if PlayerFromCharacter and not u49 then
                    u49 = true;
                    local Children4 = u35.Spawns:GetChildren();
                    PlayerFromCharacter.NRPBS.Underbelly.Value = false;
                    PlayerFromCharacter.Character.HumanoidRootPart.CFrame = Children4[math.random(1, #Children4)].CFrame * CFrame.new(0, 1.5, 0);
                    wait(0.5);
                    u49 = false;
                end;
            end);
            TweenService:Create(u38.Portal.Portal.Spiral, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, (1 / 0)), {
                Rotation = 360
            }):Play();
        else
            u38.Portal:Destroy();
            u38.Bonk.DoorA:Destroy();
            u38.Bonk.DoorB:Destroy();
        end;

        v37 = u38;
    end;

    local u51 = {};

    for _, child in pairs(u35.Procedural:GetChildren()) do
        if child:FindFirstChild("Trap") and child.Trap:FindFirstChild("Tentacles") then
            for _, child2 in pairs(child.Trap:GetChildren()) do
                if child2.Name == "Tentacles" then
                    for _, child3 in pairs(child2:GetChildren()) do
                        local Tentacle = child3.Tentacle;
                        local v52 = Tentacle.AnimationController:LoadAnimation(script.Hole);
                        local u53 = {};
                        Tentacle["Cube.001"].Transparency = 1;
                        Tentacle["Cube.001"].Hitbox.Transparency = u5;
                        Tentacle["Cube.001"].Hitbox.Touched:connect(function(p54) -- Line: 274
                            -- upvalues: Players (ref), u53 (copy), Tentacle (copy)
                            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p54.Parent);

                            if PlayerFromCharacter and (not u53[PlayerFromCharacter] and Tentacle["Cube.001"].Transparency <= 0) then
                                u53[PlayerFromCharacter] = true;
                                PlayerFromCharacter.NRPBS.Health.Value = 0;
                                wait(3);
                                u53[PlayerFromCharacter] = false;
                            end;
                        end);
                        u51[Tentacle] = v52;
                    end;
                end;
            end;
        end;
    end;

    spawn(function() -- Line: 294
        -- upvalues: u35 (copy), u51 (copy)
        while u35 and (u35.Parent and (u35:FindFirstChild("Boss") and wait(0))) do
            for i, v in pairs(u51) do
                pcall(function() -- Line: 297
                    -- upvalues: v (copy), i (copy)
                    if not v.IsPlaying and (math.random(1, 25) == 1 and i["Cube.001"].Transparency >= 1) then
                        v:Play();
                        v:AdjustSpeed(0.5);
                        spawn(function() -- Line: 302
                            -- upvalues: i (ref)
                            wait(0.25);
                            i["Cube.001"].Transparency = 0;
                        end);
                        spawn(function() -- Line: 307
                            -- upvalues: v (ref), i (ref)
                            wait(v.Length * 2);

                            if i and i:FindFirstChild("Cube.001") then
                                i["Cube.001"].Transparency = 1;
                            end;
                        end);
                    end;
                end);

                if i["Cube.001"].Transparency <= 0 or v.IsPlaying then
                    local v55 = i["Cube.001"].Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"]["Bone.005"];

                    if v55 then
                        i["Cube.001"].Hitbox.CFrame = v55.TransformedWorldCFrame;
                    end;
                end;
            end;
        end;
    end);
end;

function u1.Cannons(p56) -- Line: 329
    -- upvalues: getTarget (copy), Players (copy), TweenService (copy)
    for _, child in pairs(p56.Cannons:GetChildren()) do
        spawn(function() -- Line: 331
            -- upvalues: getTarget (ref), child (copy), Players (ref), TweenService (ref)
            local v57 = getTarget();

            if v57 then
                local v58 = v57.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
                local CFrame2 = child.CFrame;
                local magnitude = (CFrame2.p - v58.p).magnitude;
                local v59 = {
                    X = CFrame2.X - v58.X,
                    Y = CFrame2.Y - v58.Y,
                    Z = CFrame2.Z - v58.Z
                };
                child.CFrame = CFrame.new(child.CFrame.p, (Vector3.new(v58.X, child.CFrame.Y, v58.Z))) * CFrame.Angles(0, -1.5707963267948966, -0.5235987755982988);
                local u60 = script.Ball:Clone();
                u60.CFrame = child.CFrame;
                u60.Parent = child;
                local u61 = nil;
                u61 = u60.Touched:connect(function(p62) -- Line: 351
                    -- upvalues: Players (ref), u60 (copy), u61 (ref)
                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p62.Parent);

                    if PlayerFromCharacter then
                        local Health = PlayerFromCharacter.NRPBS.Health;
                        local v63 = PlayerFromCharacter.NRPBS.Health.Value - (math.random(15, 35) + bonus()) * 1;
                        Health.Value = math.clamp(v63, 0, 100);
                        local v64 = CFrame.new(u60.CFrame.p, PlayerFromCharacter.Character.PrimaryPart.CFrame.p).lookVector * 15 + Vector3.new(0, 25, 0);
                        game.ServerStorage.ApplyVel:Fire(PlayerFromCharacter, v64, 1, "Knife", PlayerFromCharacter.Name, 1);
                        u60:Destroy();
                        u61:disconnect();
                    end;
                end);

                for i = 1, magnitude + 1 do
                    if not u60 or u60 and not u60.Parent then
                        break;
                    end;

                    local v65;

                    if i % 2 == 0 or (i == magnitude + 1 or i == 1) then
                        local CFrame_new_ret = CFrame.new(CFrame2.X - v59.X / magnitude * (i - 1), (-1 * i ^ 2 + (magnitude + 1) * i) / 75 + (CFrame2.Y - v59.Y / magnitude * (i - 1)), CFrame2.Z - v59.Z / magnitude * (i - 1));
                        local v66 = TweenService:Create(u60, TweenInfo.new(0.005, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            CFrame = CFrame_new_ret
                        });
                        v66:Play();
                        wait(0.005);
                        v66:Destroy();
                        v65 = i;
                    else
                        v65 = i;
                    end;
                end;

                wait(0.1);

                if u60 and u60.Parent then
                    u60:Destroy();
                    u61:disconnect();
                end;
            end;
        end);
    end;
end;

function bonus()
    return math.random(-1, 1) * 5;
end;

function u1.Tentacles(u67) -- Line: 396
    -- upvalues: u4 (ref), u5 (ref), Players (copy)
    if u4 then
        return;
    end;

    local u68 = false;
    local u69 = {};
    u4 = true;

    for _, child in pairs(u67.Ignore.Tentacles:GetChildren()) do
        if child["Cube.001"].Transparency >= 1 then
            child["Cube.001"].CFrame = child["Cube.001"].CFrame * CFrame.Angles(0, math.rad(-360, 360) + math.random(0, 1000) / 1000, 0);
            u68 = child.AnimationController.Animator:LoadAnimation(script.Thwack);
            u68.Looped = false;
            u68:Play();
            u68:AdjustSpeed(0.5);
            local u70 = {};
            child["Cube.001"].Hitbox.Transparency = u5;
            u69[child] = child["Cube.001"].Hitbox.Touched:connect(function(p71) -- Line: 416
                -- upvalues: Players (ref), u70 (copy)
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p71.Parent);

                if PlayerFromCharacter and not u70[PlayerFromCharacter] then
                    u70[PlayerFromCharacter] = true;
                    local Health = PlayerFromCharacter.NRPBS.Health;
                    local v72 = PlayerFromCharacter.NRPBS.Health.Value - (math.random(35, 75) + bonus()) * 1;
                    Health.Value = math.clamp(v72, 0, 100);
                    wait(3);
                    u70[PlayerFromCharacter] = false;
                end;
            end);
        end;
    end;

    local u73 = false;
    spawn(function() -- Line: 435
        -- upvalues: u68 (ref), u73 (ref), u67 (copy), u4 (ref), u69 (copy)
        wait(u68.Length * 2);
        u73 = true;

        for _, child in pairs(u67.Ignore.Tentacles:GetChildren()) do
            child["Cube.001"].Transparency = 1;
            u4 = false;

            if u69[child] then
                u69[child]:disconnect();
            end;
        end;
    end);
    spawn(function() -- Line: 449
        -- upvalues: u73 (ref), u67 (copy)
        wait(0.15);

        while wait(0) and not u73 do
            for _, child in pairs(u67.Ignore.Tentacles:GetChildren()) do
                local v74 = child["Cube.001"].Bone["Bone.001"]["Bone.002"]["Bone.003"]["Bone.004"]["Bone.005"];

                if u73 or not v74 then
                    if u73 then
                        child["Cube.001"].Transparency = 1;
                    end;
                else
                    child["Cube.001"].Transparency = 0;
                    child["Cube.001"].Hitbox.CFrame = v74.TransformedWorldCFrame;
                end;
            end;
        end;
    end);
end;

return u1;