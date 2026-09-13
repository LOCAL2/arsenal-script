-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
game:GetService("LogService");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local TeleportService = game:GetService("TeleportService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;
local Huntlerts = script_Parent.Huntlerts;
local AbsoluteSize = script_Parent.AbsoluteSize;
local CurrentCamera = Workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;

local function findClosestBorderPoint(p8, p9, p10) -- Line: 29
    -- upvalues: AbsoluteSize (copy)
    local v11 = AbsoluteSize.X - p8;
    local v12 = AbsoluteSize.Y - p9;

    if math.min(v12, AbsoluteSize.Y - v12) < math.min(v11, AbsoluteSize.X - v11) then
        if v12 < AbsoluteSize.Y - v12 then
            return math.clamp(v11, 0, AbsoluteSize.X - p10.X), 0;
        end;

        return math.clamp(v11, 0, AbsoluteSize.X - p10.X), AbsoluteSize.Y - p10.Y;
    end;

    if v11 < AbsoluteSize.X - v11 then
        return 0, math.clamp(v12, 0, AbsoluteSize.Y - p10.Y);
    end;

    return AbsoluteSize.X - p10.X, math.clamp(v12, 0, AbsoluteSize.Y - p10.Y);
end;

local function toCheckpoint() -- Line: 49
    -- upvalues: u5 (ref), LocalPlayer (copy), CurrentCamera (copy)
    if not u5 then
        return;
    end;

    local v13 = u5.CFrame * CFrame.new(0, 0, -20);
    LocalPlayer.Character:PivotTo(u5.CFrame);
    task.wait();
    CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, v13.Position);
end;

local function moveAlert(p14: userdata, p15: vector, p16) -- Line: 59
    -- upvalues: CurrentCamera (copy), findClosestBorderPoint (copy), AbsoluteSize (copy)
    local _ = CurrentCamera.CFrame:inverse() * p16;
    local v17 = p14.AbsoluteSize + Vector2.new(16, 16);
    local v18 = p15.X - v17.X / 2;
    local v19 = p15.Y - v17.Y / 2;

    if p15.Z < 0 then
        v18, v19 = findClosestBorderPoint(v18, v19, v17);
    else
        if v18 < 0 then
            v18 = 0;
        elseif AbsoluteSize.X - v17.X < v18 then
            v18 = AbsoluteSize.X - v17.X;
        end;

        if v19 < 0 then
            v19 = 0;
        elseif AbsoluteSize.Y - v17.Y < v19 then
            v19 = AbsoluteSize.Y - v17.Y;
        end;
    end;

    p14.Position = UDim2.fromOffset(v18, v19);
end;

local u20 = false;
local u21 = 0;

local function Skip() -- Line: 87
    -- upvalues: u21 (ref), u20 (ref), script_Parent (copy)
    if tick() - u21 <= 0.2 then
        return;
    end;

    if u20 then
        return;
    end;

    local Dialogue = script_Parent.Communication.Dialogue;

    if not Dialogue.Visible then
        return;
    end;

    if not Dialogue.Button.Visible then
        return;
    end;

    u21 = tick();
    u20 = true;
end;

local u22 = true;

local function Speak(u23: userdata, u24: userdata, p25: number) -- Line: 98
    -- upvalues: u22 (ref), script_Parent (copy), u20 (ref)
    local v26 = false;

    if u22 then
        if LastInput == "Controller" then
            script_Parent.Communication.Dialogue.Button.Text = "(A)";
            v26 = true;
        elseif LastInput == "Mobile" then
            script_Parent.Communication.Dialogue.Button.Text = "(CLICK)";
            v26 = true;
        else
            script_Parent.Communication.Dialogue.Button.Text = "[E]";
            v26 = true;
        end;
    else
        script_Parent.Communication.Dialogue.Button.Visible = false;
    end;

    if u20 then
        u20 = false;
    end;

    u24.Speak.Text = "";
    u24.Topbar.Speaker.Text = u23.Name;
    u24.Speaker.Icon.Image = u23.Icon;
    u24.Visible = true;
    local AmbientReverb = game.SoundService.AmbientReverb;

    if u23.Audio then
        script.Voice.SoundId = `rbxassetid://{u23.Audio}`;
        script.Voice:Play();
        script.Earpiece_TurnOn:Play();
        script.Earpiece_StaticLoop:Play();
        game.SoundService.AmbientReverb = Enum.ReverbType.NoReverb;
    end;

    if not u23.Plot then
        u23.Plot = { 16738154301 };
    end;

    local u27 = script_Parent.Communication["Plot Images"];
    local u28 = 1;
    local u29 = #u23.Plot;
    u27.Image.Image = "http://www.roblox.com/asset/?id=" .. u23.Plot[1];
    local v30 = u27.Next.MouseButton1Down:Connect(function() -- Line: 138
        -- upvalues: u28 (ref), u29 (copy), u27 (copy), u23 (copy)
        u28 = u28 + 1;

        if u29 < u28 then
            u28 = 1;
        end;

        u27.Image.Image = "http://www.roblox.com/asset/?id=" .. u23.Plot[u28];
    end);
    local v31 = u27.Back.MouseButton1Down:Connect(function() -- Line: 148
        -- upvalues: u28 (ref), u23 (copy), u27 (copy)
        u28 = u28 - 1;

        if u28 < 1 then
            u28 = #u23.Plot;
        end;

        u27.Image.Image = "http://www.roblox.com/asset/?id=" .. u23.Plot[u28];
    end);

    local function calcSize() -- Line: 158
        -- upvalues: u24 (copy)
        local math_sqrt_ret = math.sqrt(u24.Speak.AbsoluteSize.Y);
        u24.Speak.TextSize = math.floor(math_sqrt_ret + math_sqrt_ret / 1.35);
    end;

    local math_sqrt_ret = math.sqrt(u24.Speak.AbsoluteSize.Y);
    u24.Speak.TextSize = math.floor(math_sqrt_ret + math_sqrt_ret / 1.35);
    u24.Speak.Text = u23.Dialogue;
    local v32 = u23.Dialogue:len();

    for i = 1, v32 do
        u24.Speak.MaxVisibleGraphemes = i;
        local math_sqrt_ret2 = math.sqrt(u24.Speak.AbsoluteSize.Y);
        u24.Speak.TextSize = math.floor(math_sqrt_ret2 + math_sqrt_ret2 / 1.35);

        if u20 then
            script.Voice:Stop();
            u20 = false;
            u24.Speak.MaxVisibleGraphemes = v32;
            break;
        end;

        task.wait(0.035);
        local _ = i;
    end;

    if u23.Audio then
        repeat
            task.wait();
        until not script.Voice.Playing;

        script.Earpiece_TurnOff:Play();
        script.Earpiece_StaticLoop:Stop();

        if game.SoundService.AmbientReverb == Enum.ReverbType.NoReverb or game.SoundService.AmbientReverb == AmbientReverb then
            game.SoundService.AmbientReverb = AmbientReverb;
        end;

        local v33 = tick();

        repeat
            task.wait();
        until u20 or not v26 and tick() - v33 >= 2;
    else
        task.wait(p25 or 4);
    end;

    if u20 then
        u20 = false;
    end;

    v31:Disconnect();
    v30:Disconnect();
    u24.Visible = false;
end;

local function Init(p34: userdata) -- Line: 197
    -- upvalues: u7 (ref), Huntlerts (copy), u4 (copy), u2 (copy), RunService (copy), CurrentCamera (copy), moveAlert (copy), LocalPlayer (copy), u5 (ref), u3 (copy), ReplicatedStorage (copy), u1 (copy), Speak (copy), script_Parent (copy), TweenService (copy), toCheckpoint (copy), Workspace (copy), u6 (ref)
    if u7 then
        u7:Disconnect();
    end;

    local Enemies = p34:WaitForChild("Enemies");

    for _, child in Enemies:GetChildren() do
        if child:IsA("Model") and child:GetAttribute("Stealth") then
            local v35 = script.Alarm:Clone();
            v35.Visible = false;
            v35.Parent = Huntlerts;
            u4[child] = v35;
        elseif child:IsA("BasePart") then
            child.Transparency = 1;

            for _, child2 in child:GetChildren() do
                if child2:IsA("BasePart") then
                    child2.Transparency = 1;
                end;
            end;
        end;
    end;

    Enemies.ChildAdded:Connect(function(p36: userdata) -- Line: 225
        -- upvalues: Huntlerts (ref), u4 (ref)
        task.wait(1);

        if not (p36:IsA("Model") and p36:GetAttribute("Stealth")) then
            if p36:IsA("BasePart") then
                p36.Transparency = 1;

                for _, child in p36:GetChildren() do
                    if child:IsA("BasePart") then
                        child.Transparency = 1;
                    end;
                end;
            end;

            return;
        end;

        local v37 = script.Alarm:Clone();
        v37.Visible = false;
        v37.Parent = Huntlerts;
        u4[p36] = v37;
    end);
    Enemies.ChildRemoved:Connect(function(p38: userdata) -- Line: 245
        -- upvalues: u4 (ref)
        if u4[p38] then
            u4[p38]:Destroy();
        end;
    end);

    for _, child in p34:WaitForChild("Cover"):GetChildren() do
        child.Transparency = 1;
    end;

    for _, child in p34:WaitForChild("Alerts"):GetChildren() do
        child.Transparency = 1;
    end;

    u2.Loop = RunService.RenderStepped:Connect(function() -- Line: 257
        -- upvalues: Enemies (copy), u4 (ref), CurrentCamera (ref), moveAlert (ref)
        for _, child in Enemies:GetChildren() do
            if child:FindFirstChild("Alert") and u4[child] then
                local v39, v40 = CurrentCamera:WorldToViewportPoint(child.HumanoidRootPart.CFrame.Position);
                u4[child].TextColor3 = child.Alert.Alarm.TextColor3;
                u4[child].Visible = child.Alert.Enabled and not v40;

                if u4[child].Visible then
                    moveAlert(u4[child], v39, child.HumanoidRootPart.CFrame);
                end;
            end;
        end;
    end);

    for _, child in p34:WaitForChild("Checkpoints"):GetChildren() do
        child.Transparency = 1;
        u2[child] = child.Touched:Connect(function(p41: userdata) -- Line: 275
            -- upvalues: LocalPlayer (ref), u5 (ref), child (copy), u3 (ref), ReplicatedStorage (ref)
            if p41:IsDescendantOf(LocalPlayer.Character) and (u5 ~= child and not table.find(u3, child)) then
                table.insert(u3, child);
                u5 = child;
                ReplicatedStorage.Remotes.ResetCheckpoint:FireServer(u5, LastInput == "Mobile");

                if u5:FindFirstChild("Last") then
                    ReplicatedStorage.Remotes.ResetCheckpointLast:FireServer(u5.Last.Value);
                end;
            end;
        end);
    end;

    for _, child in p34:WaitForChild("Speak"):GetChildren() do
        child.Transparency = 1;
        u2[child] = child.Touched:Connect(function(p42: userdata) -- Line: 292
            -- upvalues: LocalPlayer (ref), u1 (ref), child (copy), Speak (ref), script_Parent (ref)
            if p42:IsDescendantOf(LocalPlayer.Character) and not table.find(u1, child) then
                table.insert(u1, child);
                Speak(require(child.Info), script_Parent.Communication.Dialogue);
            end;
        end);
    end;

    for _, child in p34:WaitForChild("Heal"):GetChildren() do
        child.Transparency = 1;
    end;

    for _, child in p34:WaitForChild("Sitters"):GetChildren() do
        child.Transparency = 1;

        if child.Name == "Sit" then
            child.Touched:Connect(function(p43: userdata) -- Line: 310
                if p43.Parent:FindFirstChild("Humanoid") and not p43.Parent.Humanoid.Sit then
                    p43.Parent.Humanoid.Sit = true;
                    p43.Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
                end;
            end);
        elseif child.Name == "Unsit" then
            local u44 = false;
            child.Touched:Connect(function(p45: userdata) -- Line: 318
                -- upvalues: u44 (ref)
                if p45.Parent:FindFirstChild("Humanoid") and not u44 then
                    u44 = true;
                    task.wait(0.1);
                    p45.Parent.Humanoid.Sit = false;
                    p45.Parent.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
                    p45.Parent.Humanoid.Jump = true;
                    u44 = false;
                end;
            end);
        end;
    end;

    u2.Died = LocalPlayer.ChildAdded:Connect(function(p46: userdata) -- Line: 332
        -- upvalues: TweenService (ref), script_Parent (ref), ReplicatedStorage (ref), Speak (ref)
        if p46.Name == "DiedRecently" then
            TweenService:Create(script_Parent.Fade, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            }):Play();
            local v47 = ReplicatedStorage.Events.GetInventory:InvokeServer({ "GetData" });
            local v48 = v47 and (v47.Loadout and v47.Loadout.Skin) or "Delinquent";
            local v49 = v48:find("_");

            if v49 then
                v48:sub(0, v49 - 1);
            end;

            local v50 = { { "How could you fail?", 16736453788 }, { "I should have hired someone else...", 16736453694 }, { "I thought you were smarter than this.", 16736453605 }, { "You were a waste of time.", 16736453004 } };
            local v51 = v50[math.random(1, #v50)];
            Speak({
                Name = "Agent",
                Icon = "rbxassetid://16728989443",
                Audio = v51[2],
                Dialogue = v51[1]
            }, script_Parent.Communication.Dialogue, 3);
        end;
    end);
    local u52 = true;
    u2.Respawn = LocalPlayer.ChildRemoved:Connect(function(p53: userdata) -- Line: 366
        -- upvalues: u5 (ref), u1 (ref), Huntlerts (ref), ReplicatedStorage (ref), u52 (ref), toCheckpoint (ref), TweenService (ref), script_Parent (ref)
        if p53.Name == "DiedRecently" then
            if u5 then
                task.wait(0.1);
                table.clear(u1);
                Huntlerts:ClearAllChildren();
                ReplicatedStorage.Remotes.ResetCheckpoint:FireServer(u5, LastInput == "Mobile", not u52);

                if u5.Name ~= "First" then
                    task.wait(1.25);
                end;

                toCheckpoint();
            end;

            u52 = false;
            TweenService:Create(script_Parent.Fade, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
        end;
    end);
    u2.Remover = p34.AncestryChanged:Connect(function(p54: userdata) -- Line: 389
        -- upvalues: Workspace (ref), u1 (ref), u3 (ref), Huntlerts (ref), u2 (ref)
        if p54 ~= Workspace then
            table.clear(u1);
            table.clear(u3);
            Huntlerts:ClearAllChildren();

            for _, v in u2 do
                v:Disconnect();
            end;
        end;
    end);

    for _, child in p34:WaitForChild("Collect"):GetChildren() do
        if child:FindFirstChild("Prompt") then
            u2[child] = child.Prompt.Triggered:Connect(function(p55: userdata) -- Line: 403
                -- upvalues: LocalPlayer (ref), u6 (ref)
                if p55 == LocalPlayer and u6 then
                    u6:Play();
                end;
            end);
        end;
    end;

    if p34:FindFirstChild("Checkpoints") and p34.Checkpoints:FindFirstChild("First") then
        table.insert(u3, p34.Checkpoints.First);
        u5 = p34.Checkpoints.First;
        ReplicatedStorage.Remotes.ResetCheckpoint:FireServer(u5, LastInput == "Mobile");
        toCheckpoint();
    end;

    for _, descendant in p34:WaitForChild("Geometry"):GetDescendants() do
        if descendant:IsA("VideoFrame") then
            descendant:Play();
        end;
    end;
end;

local function AdjustInput(p56) -- Line: 426
    local Name = p56.Name;

    if Name:find("Mouse") or Name:find("Keyboard") then
        LastInput = "Mouse";

        return;
    end;

    if Name:find("Touch") or (Name:find("Accelerometer") or Name:find("Gyro")) then
        LastInput = "Mobile";

        return;
    end;

    if Name:find("Gamepad") then
        LastInput = "Controller";
    end;
end;

local function playGame() -- Line: 438
    -- upvalues: TweenService (copy), script_Parent (copy), UserInputService (copy), ReplicatedStorage (copy)
    TweenService:Create(script_Parent.Minigame.UIStroke.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, (1 / 0)), {
        Rotation = 365
    }):Play();
    script.Hack:Play();
    script_Parent.Minigame.Visible = true;
    task.defer(function() -- Line: 447
        -- upvalues: script_Parent (ref), TweenService (ref)
        local Grid = script_Parent.Minigame.Grid;
        local Grid2 = script_Parent.Minigame.Grid2;
        local v57 = TweenService:Create(Grid.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1.5, 0)
        });
        local v58 = TweenService:Create(Grid2.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1.5, 0)
        });

        while script_Parent.Minigame.Visible and task.wait() do
            v57:Play();
            task.wait(2.75);
            Grid.UIGradient.Offset = Vector2.new(1.5, 0);
            v58:Play();
            task.wait(2.75);
            Grid2.UIGradient.Offset = Vector2.new(1.5, 0);
        end;

        v57:Cancel();
        v57:Destroy();
        v58:Cancel();
        v58:Destroy();
    end);
    local u59 = 0;
    local Children = script.Beeps:GetChildren();

    local function createPrompter() -- Line: 482
        -- upvalues: u59 (ref), script_Parent (ref), Children (copy), UserInputService (ref)
        if u59 >= 8 then
            return;
        end;

        local AbsoluteSize2 = script_Parent.Minigame.Field.AbsoluteSize;
        local u60 = script.Click:Clone();
        local v61 = u60.AbsoluteSize.X + 3;
        local v62 = AbsoluteSize2.X - v61 * 2;
        u60.Position = UDim2.fromOffset(math.random(v61, v62), math.random(v61, v62));
        u60.Parent = script_Parent.Minigame.Field;
        u60.Fill:TweenSize(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 3.25, true);
        local u63 = nil;

        local function activate() -- Line: 498
            -- upvalues: u59 (ref), u60 (copy), script_Parent (ref), Children (ref), u63 (ref)
            if u59 >= 8 then
                u60:Destroy();

                return;
            end;

            u59 = u59 + 1;
            local math_floor_ret = math.floor(u59 / 8 * 100);
            script_Parent.Minigame.Field.Progress.Text = `Hack Progress: {math_floor_ret}%`;
            Children[math.random(1, #Children)]:Play();
            u60:Destroy();

            if u63 then
                u63:Disconnect();
            end;
        end;

        u60.Fill.MouseButton1Down:Connect(function() -- Line: 512
            -- upvalues: activate (copy)
            activate();
        end);
        local v64 = {
            Enum.KeyCode.ButtonA,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.ButtonX,
            Enum.KeyCode.ButtonY
        };
        local u65 = v64[math.random(1, #v64)];
        u63 = UserInputService.InputBegan:Connect(function(p66: userdata) -- Line: 518
            -- upvalues: u65 (copy), activate (copy)
            if p66.KeyCode == u65 then
                activate();
            end;
        end);

        if LastInput == "Controller" then
            u60.Fill.Gamepad.Image = UserInputService:GetImageForKeyCode(u65);
            u60.Fill.BackgroundColor3 = Color3.fromRGB(0, 85, 0);
            u60.Fill.Gamepad.Visible = true;
        end;

        task.delay(3.25, function() -- Line: 530
            -- upvalues: u60 (copy)
            if u60 then
                u60:Destroy();
            end;
        end);
    end;

    UserInputService.MouseIconEnabled = true;

    while u59 < 8 and task.wait(math.random(0, 2500) / 1000) do
        createPrompter();
    end;

    UserInputService.MouseIconEnabled = false;
    script_Parent.Minigame.Visible = false;
    script.Hack:Stop();
    script.HackDone:Play();
    ReplicatedStorage.Hack:FireServer();
end;

local function doGrids() -- Line: 548
    -- upvalues: script_Parent (copy), TweenService (copy)
    task.defer(function() -- Line: 549
        -- upvalues: script_Parent (ref), TweenService (ref)
        local Grid = script_Parent.Communication.Grid;
        local Grid2 = script_Parent.Communication.Grid2;
        local v67 = TweenService:Create(Grid.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });
        local v68 = TweenService:Create(Grid2.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });

        while Grid.Visible and task.wait() do
            v67:Play();
            task.wait(2.75);
            Grid.UIGradient.Offset = Vector2.new(1, 0);
            v68:Play();
            task.wait(2.75);
            Grid2.UIGradient.Offset = Vector2.new(1, 0);
        end;

        v67:Cancel();
        v67:Destroy();
        v68:Cancel();
        v68:Destroy();
    end);
end;

local function ToHMSMS(p69) -- Line: 581
    local string_format = string.format;
    local v70 = (p69 - math.floor(p69)) * 100;
    local math_round_ret = math.round(v70);

    return string_format("%02i:%02i:%02i:%02i", p69 / 3600, p69 / 60 % 60, p69 % 60, (math.clamp(math_round_ret, 0, 99)));
end;

local function playCredits() -- Line: 585
    -- upvalues: TweenService (copy), script_Parent (copy), ReplicatedStorage (copy), Speak (copy), TeleportService (copy)
    script.Credit:Play();
    TweenService:Create(script_Parent.Communication, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play();
    task.wait(1);
    script_Parent.Communication.Grid2.Visible = true;
    script_Parent.Communication.Grid.Visible = true;
    task.defer(function() -- Line: 549
        -- upvalues: script_Parent (ref), TweenService (ref)
        local Grid = script_Parent.Communication.Grid;
        local Grid2 = script_Parent.Communication.Grid2;
        local v71 = TweenService:Create(Grid.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });
        local v72 = TweenService:Create(Grid2.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });

        while Grid.Visible and task.wait() do
            v71:Play();
            task.wait(2.75);
            Grid.UIGradient.Offset = Vector2.new(1, 0);
            v72:Play();
            task.wait(2.75);
            Grid2.UIGradient.Offset = Vector2.new(1, 0);
        end;

        v71:Cancel();
        v71:Destroy();
        v72:Cancel();
        v72:Destroy();
    end);
    local v73 = ReplicatedStorage.Events.GetInventory:InvokeServer({ "GetData" });
    local v74 = v73 and (v73.Loadout and v73.Loadout.Skin) or "Delinquent";
    local v75 = v74:find("_");

    if v75 then
        v74 = v74:sub(0, v75 - 1);
    end;

    Speak({
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = "*scrambled sounds*"
    }, script_Parent.Communication.Dialogue, 3);
    Speak({
        Name = "???",
        Icon = "rbxassetid://16747403053",
        Dialogue = "That is interesting, very interesting... I don\'t think I\'ve seen you before."
    }, script_Parent.Communication.Dialogue, 3);
    Speak({
        Name = "???",
        Icon = "rbxassetid://16747403053",
        Dialogue = `{v74}? No... Seems you've decided to put a wrench in my plans, and for why? Is it because you fear the unknown? Or do you fear to learn of it?`
    }, script_Parent.Communication.Dialogue, 3);
    Speak({
        Name = "???",
        Icon = "rbxassetid://16747403053",
        Dialogue = "Either way I will have to keep my eye on you from now on, I can assure you... this will not be the last time we speak. Perhaps next time I\'ll have the chance to explain this all to you."
    }, script_Parent.Communication.Dialogue, 3);
    Speak({
        Name = "???",
        Icon = "rbxassetid://16747403053",
        Dialogue = "However, you\'ve caused quite the scene and drawn unwanted attention to my operation. Seems I\'ll be returning to hiding... until next time, my little pawn."
    }, script_Parent.Communication.Dialogue, 3);
    script_Parent.Communication.Rewards.Visible = true;
    task.wait(6);
    local v76 = ReplicatedStorage.Hunt.End.Value - ReplicatedStorage.Hunt.Start.Value;
    local Time = script_Parent.Communication.Credits.Bonus.Time;
    local string_format = string.format;
    local v77 = (v76 - math.floor(v76)) * 100;
    local math_round_ret = math.round(v77);
    Time.Text = string_format("%02i:%02i:%02i:%02i", v76 / 3600, v76 / 60 % 60, v76 % 60, (math.clamp(math_round_ret, 0, 99)));
    script_Parent.Communication.Credits.Bonus.Kills.Text = "Kills: " .. ReplicatedStorage.Hunt.Kills.Value;
    script_Parent.Communication.Credits.Bonus.Deaths.Text = "Deaths: " .. ReplicatedStorage.Hunt.Deaths.Value;
    script_Parent.Communication.Rewards.Visible = false;
    script_Parent.Communication.Credits.Visible = true;
    script_Parent.Communication.Credits:TweenPosition(UDim2.fromScale(0.5, -2), "Out", "Linear", 18, true);
    task.wait(20);
    TeleportService:Teleport(286090429);
end;

local function playIntro() -- Line: 657
    -- upvalues: script_Parent (copy), TweenService (copy), ReplicatedStorage (copy), Speak (copy), Workspace (copy), u22 (ref)
    script_Parent.Communication.Visible = true;
    task.defer(function() -- Line: 549
        -- upvalues: script_Parent (ref), TweenService (ref)
        local Grid = script_Parent.Communication.Grid;
        local Grid2 = script_Parent.Communication.Grid2;
        local v78 = TweenService:Create(Grid.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });
        local v79 = TweenService:Create(Grid2.UIGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Offset = Vector2.new(-1, 0)
        });

        while Grid.Visible and task.wait() do
            v78:Play();
            task.wait(2.75);
            Grid.UIGradient.Offset = Vector2.new(1, 0);
            v79:Play();
            task.wait(2.75);
            Grid2.UIGradient.Offset = Vector2.new(1, 0);
        end;

        v78:Cancel();
        v78:Destroy();
        v79:Cancel();
        v79:Destroy();
    end);
    local v80 = ReplicatedStorage.Events.GetInventory:InvokeServer({ "GetData" });
    local v81 = v80 and (v80.Loadout and v80.Loadout.Skin) or "Delinquent";
    local v82 = v81:find("_");

    if v82 then
        v81 = v81:sub(0, v82 - 1);
    end;

    Speak({
        Audio = 16736451530,
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = `Hello {v81}, this is the Agent. I'm sure you knew... I've contacted you concerning a recent discovery, one of which I would investigate myself. However, I'm needed else where. Though this does not mean I will not be assisting you remotely. Consider me, a guide of sorts...`
    }, script_Parent.Communication.Dialogue, 4);
    Speak({
        Audio = 16736452419,
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = "As of late various shipments of technology boasting promising computing power have been being delivered to this unmarked location, one yours truly had brought to the attention of The Mechanic and Scientist. Seems the two of them are worried that these deliveries may be related to something rather malicious.",
        Plot = { 16743179598, 16743179198, 16743178837 }
    }, script_Parent.Communication.Dialogue, 5);
    Speak({
        Audio = 16736451306,
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = "These mysterious figures have been guarding these shipments, not much is known about them but upon observation they\'re well armed and well trained. It\'s advised you avoid them at all costs..."
    }, script_Parent.Communication.Dialogue, 3);
    Speak({
        Audio = 16736451972,
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = "Intel I have gathered whilst undercover has lead to the discovery of an internal server room, your objective is to reach this server room and upload a piece of malware. The Mechanic says this malware will disable the bases security systems allowing you to pass through any door without need for elaborate keycards. How you will get there is undetermined, so I hope you know how to improvise.",
        Plot = { 16743178470, 16743178020, 16743177572 }
    }, script_Parent.Communication.Dialogue, 5);
    Speak({
        Audio = 16736451159,
        Name = "Agent",
        Icon = "rbxassetid://16728989443",
        Dialogue = "I hope you retained all that, I will not be repeating it... Good luck."
    }, script_Parent.Communication.Dialogue, 3);
    game:GetService("GuiService").SelectedObject = nil;

    repeat
        task.wait();
    until Workspace:FindFirstChild("Map");

    u22 = false;
    script_Parent.Communication["Plot Images"].Visible = false;
    script_Parent.Communication.Pages.Visible = false;
    script_Parent.Communication.Grid2.Visible = false;
    script_Parent.Communication.Grid.Visible = false;
    script_Parent.Communication.Transparency = 1;
end;

ReplicatedStorage.Hack.OnClientEvent:Connect(function() -- Line: 719
    -- upvalues: playGame (copy)
    playGame();
end);
ReplicatedStorage.Credits.OnClientEvent:Connect(function() -- Line: 723
    -- upvalues: playCredits (copy)
    playCredits();
end);
CurrentCamera.ChildAdded:Connect(function(p83: userdata) -- Line: 727
    -- upvalues: u6 (ref)
    task.wait(1);

    if p83:IsA("Model") and (p83.Name == "Arms" and p83:FindFirstChild("Guy")) then
        u6 = p83.Guy:LoadAnimation(script.Interact);
        u6.Priority = Enum.AnimationPriority.Action4;
    end;
end);
AdjustInput(UserInputService:GetLastInputType());
UserInputService.LastInputTypeChanged:Connect(function(p84) -- Line: 737
    -- upvalues: AdjustInput (copy)
    AdjustInput(p84);
end);

if game.PlaceId == 391595633 then
    script_Parent.Communication["Plot Images"].Visible = true;
    task.defer(playIntro);
else
    script_Parent.Minigame.Visible = false;
    script_Parent.Communication["Plot Images"].Visible = false;
end;

if Workspace:FindFirstChild("Map") and ReplicatedStorage.wkspc.Status.MapName.Value == "The Hunt" then
    Init(Workspace.Map);
end;

u7 = Workspace.ChildAdded:Connect(function(p85: userdata) -- Line: 753
    -- upvalues: ReplicatedStorage (copy), Init (copy)
    task.wait(3);

    if p85.Name == "Map" and ReplicatedStorage.wkspc.Status.MapName.Value == "The Hunt" then
        Init(p85);
    end;
end);
UserInputService.InputBegan:Connect(function(p86) -- Line: 761
    -- upvalues: UserInputService (copy), u21 (ref), u20 (ref), script_Parent (copy)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if p86.KeyCode == Enum.KeyCode.E or p86.KeyCode == Enum.KeyCode.ButtonA then
        if tick() - u21 <= 0.2 then
            return;
        end;

        if u20 then
            return;
        end;

        local Dialogue = script_Parent.Communication.Dialogue;

        if not Dialogue.Visible then
            return;
        end;

        if not Dialogue.Button.Visible then
            return;
        end;

        u21 = tick();
        u20 = true;
    end;
end);
script_Parent.Communication.Dialogue.Button.MouseButton1Down:Connect(Skip);