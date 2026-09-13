-- Decompiled with Potassium's decompiler.

local u1 = { { 8474648129, 8474648683, 8474649014, 8474649722, 8474650310, 8474650712, 8474651501, 8474651957 }, { 8474751234, 8474751785, 8474752182, 8474752621, 8474753125, 8474753550, 8474754022, 8474754525, 8474760729, 8474761450, 8474761810, 8474762274, 8474762667, 8474763181, 8474763543, 8474764157, 8474764530, 8474772969, 8474773373, 8474773792, 8474774016 } };

for _, v in pairs(u1) do
    for _, v2 in pairs(v) do
        game.ContentProvider:Preload("rbxassetid://" .. v2);
    end;
end;

local ImageLabel = script.Parent:WaitForChild("ImageLabel");
local Sound = require(game.ReplicatedStorage.Modules.Sound);
local Glitch = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Glitch");
local TweenService = game:GetService("TweenService");
local u2 = {};
local u3 = false;
local u4 = 0;
local u5 = 0;
local u6 = 0;

for i = 48, 57 do
    local string_char_ret = string.char(i);
    table.insert(u2, string_char_ret);
    local _ = i;
end;

for i = 65, 90 do
    local string_char_ret = string.char(i);
    table.insert(u2, string_char_ret);
    local _ = i;
end;

for i = 97, 122 do
    local string_char_ret = string.char(i);
    table.insert(u2, string_char_ret);
    local _ = i;
end;

function random(p7)
    -- upvalues: u2 (copy)
    math.randomseed(os.time());

    return p7 <= 0 and "" or random(p7 - 1) .. u2[math.random(1, #u2)];
end;

Glitch.OnClientEvent:connect(function(p8, p9) -- Line: 69
    -- upvalues: u4 (ref), u5 (ref), u1 (copy), u6 (ref), Sound (copy), TweenService (copy), u3 (ref)
    if p8 == 3 then
        local TextLabel2 = script.Parent.Frame.TextLabel2;
        wait(3);

        for i = 1, 85 do
            TextLabel2.Text = ("Flashing lights, jumpscares and more lay just beyond this area. Proceed with caution."):sub(1, i);
            wait(0.1);
            local _ = i;
        end;

        wait(5);
        u4 = 1;
        u5 = #u1[1];
        u6 = 0;

        for i = 85, 1, -1 do
            TextLabel2.Text = ("Flashing lights, jumpscares and more lay just beyond this area. Proceed with caution."):sub(1, i) .. random(85 - i);
            wait();
            local _ = i;
        end;

        TextLabel2.Text = "";

        return;
    end;

    if p8 == 4 then
        u4 = 2;
        u5 = #u1[2];
        u6 = 0;
        wait(0.3);
        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = p9;

        return;
    end;

    game.Lighting.ColorCorrection.Saturation = -2;
    game.Lighting.Blur.Size = 15;
    Sound.playsound(script.Parent.Parent.Sounds.Glitch);
    u4 = p8;
    u5 = #u1[p8];
    u6 = 0;
    TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.7), {
        Saturation = 0.05
    }):Play();
    TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.7), {
        Size = 1
    }):Play();

    if game.Players.LocalPlayer.NRPBS.Health.Value <= 0 and (game.Players.LocalPlayer.Status.Team.Value ~= "Spectator" and not u3) then
        u3 = true;
        TweenService:Create(script.Parent.Frame, TweenInfo.new(0.4), {
            BackgroundTransparency = 0
        }):Play();
        local TextLabel = script.Parent.Frame.TextLabel;
        wait(3);
        local u10 = "Critical error encountered.\nProcess #" .. game.Players.LocalPlayer.userId .. " rebooting...";

        for i = 1, #u10 do
            TextLabel.Text = u10:sub(1, i);
            wait(0.1);
            local _ = i;
        end;

        if math.random(1, 10) == 1 then
            spawn(function() -- Line: 119
                -- upvalues: u10 (copy), TextLabel (copy)
                while true do
                    local v11 = u10 .. "";

                    for i = 1, math.random(4, #u10) do
                        local math_random_ret = math.random(1, #u10);
                        v11 = v11:sub(1, math_random_ret - 1) .. random(1) .. v11:sub(math_random_ret + 1);
                        local _ = i;
                    end;

                    if math.random(1, 10) == 1 then
                        v11 = "HELP";
                    end;

                    TextLabel.Text = v11;
                    wait(0.05);
                    TextLabel.Text = u10;
                    wait(0.05);
                end;
            end);
        end;

        wait(2);
        local v12 = math.random(1, 100) == 1 and 11810505137 or 286090429;
        game.ReplicatedStorage.Events.RequestTeleport:FireServer(v12);
    end;
end);
local u13 = tick();
game:GetService("RunService").Stepped:connect(function() -- Line: 144
    -- upvalues: u4 (ref), u13 (ref), u6 (ref), u5 (ref), ImageLabel (copy), u1 (copy)
    if u4 <= 0 or tick() - u13 < 0.04 then
        if u4 == 0 then
            ImageLabel.Image = "";
        end;

        return;
    end;

    u13 = tick();
    u6 = u6 + 1;

    if u5 >= u6 then
        ImageLabel.Image = "rbxassetid://" .. u1[u4][u6];

        return;
    end;

    u4 = 0;
    u6 = 0;
    u5 = 0;
    ImageLabel.Image = math.random(1, 9);
end);
local workspace_CurrentCamera = workspace.CurrentCamera;
local RunService = game:GetService("RunService");
local TweenService2 = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
local u14 = { CFrame.new(), CFrame.new(1, 0, 0), CFrame.new(-1, 0, 0) };
TweenService2:Create(script.Music, TweenInfo.new(), {
    Volume = 0.2
});
TweenService2:Create(script.Music, TweenInfo.new(), {
    Volume = 0
});

local function scary() -- Line: 175
    -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy), TweenService2 (copy), RunService (copy), Sound (copy), u14 (copy), UserInputService (copy)
    local Character = LocalPlayer.Character;
    local u15 = tick() - 1.7;
    local v16 = tick();
    local u17 = script.Them:clone();
    local u18 = nil;
    local u19 = false;
    u17.Parent = workspace_CurrentCamera;
    script.Music.Volume = 0;
    script.Music:Play();
    TweenService2:Create(script.Music, TweenInfo.new(), {
        Volume = 0.2
    }):Play();
    u18 = RunService.RenderStepped:connect(function() -- Line: 186
        -- upvalues: u15 (ref), u17 (copy), Character (copy), Sound (ref), u14 (ref), workspace_CurrentCamera (ref), u19 (ref), u18 (ref)
        if tick() - u15 >= 0.4 then
            u15 = tick();
            u17:PivotTo(Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4));

            if math.random(1, 9) == 1 then
                if math.random(1, 2) == 1 then
                    Sound.playsound(script.Parent.Parent.Sounds.Whisper);
                else
                    Sound.playsound(script.Parent.Parent.Sounds.Knock);
                end;
            end;
        end;

        local v20 = false;

        for _, v in pairs(u14) do
            local _, v21 = workspace_CurrentCamera:WorldToScreenPoint((u17.HumanoidRootPart.CFrame * v).p);

            if v21 then
                v20 = true;
                break;
            end;
        end;

        if not workspace:FindFirstChild("death") then
            if v20 then
                u19 = true;
                u18:disconnect();
            end;

            return;
        end;

        u19 = false;
        u18:disconnect();
    end);

    repeat
        RunService.RenderStepped:wait();
    until tick() - v16 >= 12 or u19;

    u18:disconnect();
    TweenService2:Create(script.Music, TweenInfo.new(), {
        Volume = 0
    }):Play();

    if u19 then
        script.Music.Volume = 0;
        UserInputService.MouseDeltaSensitivity = 0;
        script.Scare.TimePosition = 0.6;
        script.Scare:Play();
        game.ReplicatedStorage.Events.KillMe:FireServer();
    else
        u17:Destroy();
    end;
end;

local u22 = nil;
workspace.ChildAdded:connect(function(p23) -- Line: 234
    -- upvalues: Sound (copy), u22 (ref)
    wait(2);

    if p23.Name == "silence" and workspace:FindFirstChild("death") == nil then
        pcall(function() -- Line: 237
            workspace:FindFirstChildOfClass("Sound").Volume = 0;
        end);
        u22 = Sound.playsound(script.Parent.Parent.Sounds.Ambience);
    end;
end);
spawn(function() -- Line: 253
    -- upvalues: LocalPlayer (copy), scary (copy)
    while wait(math.random(60, 180)) do
        if game.ReplicatedStorage.wkspc.gametype.Value ~= "cXVlc3Q=" then
            return;
        end;

        if LocalPlayer.Name == "xonae" then
            return;
        end;

        if workspace.Map.Geometry:FindFirstChild("Facility") and (workspace:FindFirstChild("The Gatekeeper", true) == nil and LocalPlayer.NRPBS.Health.Value > 0) then
            scary();
        end;
    end;
end);
workspace.ChildAdded:connect(function(p24) -- Line: 264
    -- upvalues: u22 (ref)
    wait(1);

    if p24.Name == "death" then
        if u22 then
            u22:Stop();
        end;

        pcall(function() -- Line: 270
            workspace:FindFirstChildOfClass("Sound").Volume = 0.35;
        end);
    end;
end);
RunService.RenderStepped:connect(function() -- Line: 276
    -- upvalues: workspace_CurrentCamera (copy)
    if game.ReplicatedStorage.wkspc.gametype.Value ~= "cXVlc3Q=" then
        return;
    end;

    local Ghost = workspace:FindFirstChild("Ghost");

    if Ghost then
        Ghost:PivotTo(CFrame.new(Ghost.PrimaryPart.Position, workspace_CurrentCamera.CFrame.p));
    end;
end);