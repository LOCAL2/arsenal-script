-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
script_Parent.Parent:WaitForChild("votekickUI");
local Events = ReplicatedStorage:WaitForChild("Events");
local GetUsername = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GetUsername"));
local v1 = { "Flying", "Kill All", "Shooting Through Walls", "Teleporting", "Speed Hacks" };

local function canUse() -- Line: 23
    -- upvalues: LocalPlayer (copy), RunService (copy)
    return LocalPlayer.CareerStatsCache.Level.Value >= 75 and true or (RunService:IsStudio() or (game.GameId == 924779187 and true or game.PrivateServerId ~= ""));
end;

local u2 = 0;
local u3 = nil;
local GUI = script_Parent.Parent:WaitForChild("GUI");

local function togglethatguy() -- Line: 30
    -- upvalues: GUI (copy), script_Parent (copy), LocalPlayer (copy), RunService (copy), u2 (ref), u3 (ref)
    if GUI.TauntUI.Bass.Visible or GUI.TauntUI.Guitar.Visible then
        return;
    end;

    script_Parent.Enabled = (LocalPlayer.CareerStatsCache.Level.Value >= 75 and true or (RunService:IsStudio() or (game.GameId == 924779187 and true or game.PrivateServerId ~= ""))) and not script_Parent.Enabled or false;

    if script_Parent.Enabled then
        u2 = 0;
        u3 = nil;

        for _, child in pairs(script_Parent.Main.ReasonList:GetChildren()) do
            if child:IsA("ImageButton") then
                child.ImageColor3 = Color3.fromRGB(67, 66, 87);
            end;
        end;

        for _, child in pairs(script_Parent.Main.PlayerList:GetChildren()) do
            if child:IsA("ImageButton") then
                child.ImageColor3 = Color3.fromRGB(123, 123, 123);
            end;
        end;
    end;
end;

local function SecondsToClock(p4) -- Line: 49
    local v5 = tonumber(p4);

    if v5 <= 0 then
        return "00:00:00";
    end;

    local string_format_ret = string.format("%02.f", (math.floor(v5 / 3600)));
    local string_format_ret2 = string.format("%02.f", (math.floor(v5 / 60 - string_format_ret * 60)));

    return string_format_ret .. ":" .. string_format_ret2 .. ":" .. string.format("%02.f", (math.floor(v5 - string_format_ret * 3600 - string_format_ret2 * 60)));
end;

if LocalPlayer:FindFirstChild("China") == nil and workspace:FindFirstChild("CanVotekick") ~= nil then
    game:GetService("ContextActionService"):BindAction("VotekickBind", function(p6, p7) -- Line: 67
        -- upvalues: LocalPlayer (copy), UserInputService (copy), togglethatguy (copy)
        if LocalPlayer:FindFirstChild("China") then
            local v8 = game:GetService("UserInputService").TouchEnabled and game:GetService("ContextActionService"):GetButton("VotekickBind");

            if v8 then
                v8.Visible = false;
            end;

            return Enum.ContextActionResult.Pass;
        end;

        if p7 ~= Enum.UserInputState.Begin or UserInputService:GetFocusedTextBox() ~= nil then
            return Enum.ContextActionResult.Pass;
        end;

        togglethatguy();

        return Enum.ContextActionResult.Sink;
    end, true, Enum.KeyCode.Zero);
end;

coroutine.resume(coroutine.create(function() -- Line: 87
    -- upvalues: LocalPlayer (copy), RunService (copy)
    if LocalPlayer:FindFirstChild("China") then
        return;
    end;

    if workspace:FindFirstChild("CanVotekick") ~= nil then
        return;
    end;

    local u9 = game:GetService("UserInputService").TouchEnabled and game:GetService("ContextActionService"):GetButton("VotekickBind");

    if u9 then
        u9.Parent.Position = UDim2.new(0.9, 0, 0, 0);
        u9.Position = UDim2.new(0, -100, 0, 0);
        u9.ActionTitle.Text = "Votekick";
        u9.Visible = LocalPlayer.CareerStatsCache.Level.Value >= 75 and true or (RunService:IsStudio() or (game.GameId == 924779187 and true or game.PrivateServerId ~= ""));

        if not u9.Visible then
            LocalPlayer.CareerStatsCache.Level.Changed:connect(function() -- Line: 98
                -- upvalues: u9 (copy), LocalPlayer (ref), RunService (ref)
                u9.Visible = LocalPlayer.CareerStatsCache.Level.Value >= 75 and true or (RunService:IsStudio() or (game.GameId == 924779187 and true or game.PrivateServerId ~= ""));
            end);
        end;
    end;
end));
LocalPlayer.ChildAdded:connect(function(p10) -- Line: 106
    wait(0.5);
    local v11 = p10.Name == "China" and game:GetService("ContextActionService"):GetButton("VotekickBind");

    if v11 then
        v11.Visible = false;
    end;
end);
local PlayerList = script_Parent.Main.PlayerList;
local u12 = PlayerList.Player:clone();
PlayerList.Player:Destroy();

local function handlePlayer(u13) -- Line: 122
    -- upvalues: LocalPlayer (copy), RunService (copy), u12 (copy), GetUsername (copy), PlayerList (copy), u3 (ref), script_Parent (copy)
    if LocalPlayer:FindFirstChild("China") then
        return;
    end;

    if u13 == LocalPlayer and not RunService:IsStudio() then
        return;
    end;

    local u14 = u12:clone();
    u14.Name = u13.Name;
    u14.PlayerName.Text = GetUsername.GetNameToShow(u13.Name);
    u14.Parent = PlayerList;
    u14.MouseButton1Click:connect(function() -- Line: 129
        -- upvalues: u3 (ref), u13 (copy), script_Parent (ref), u14 (copy)
        u3 = u13;

        for _, child in pairs(script_Parent.Main.PlayerList:GetChildren()) do
            if child:IsA("ImageButton") then
                child.ImageColor3 = child == u14 and Color3.fromRGB(161, 161, 161) or Color3.fromRGB(123, 123, 123);
            end;
        end;
    end);
end;

Players.PlayerRemoving:connect(function(p15) -- Line: 139
    -- upvalues: PlayerList (copy)
    local v16 = PlayerList:FindFirstChild(p15.Name);

    if v16 then
        v16:Destroy();
    end;
end);

for _, v in pairs(Players:GetPlayers()) do
    handlePlayer(v);
end;

Players.PlayerAdded:connect(handlePlayer);
local ReasonList = script_Parent.Main.ReasonList;
local v17 = ReasonList.Reason:clone();
ReasonList.Reason:Destroy();

for i, v in pairs(v1) do
    local u18 = v17:clone();
    u18.Name = i;
    u18.TextLabel.Text = v;
    u18.Parent = ReasonList;
    u18.MouseButton1Click:connect(function() -- Line: 163
        -- upvalues: u2 (ref), i (copy), script_Parent (copy), u18 (copy)
        u2 = i;

        for _, child in pairs(script_Parent.Main.ReasonList:GetChildren()) do
            if child:IsA("ImageButton") then
                child.ImageColor3 = child == u18 and Color3.fromRGB(111, 110, 145) or Color3.fromRGB(67, 66, 87);
            end;
        end;
    end);
end;

local u19 = false;
script_Parent.Main.Votekick.MouseButton1Click:connect(function() -- Line: 176
    -- upvalues: LocalPlayer (copy), u19 (ref), u3 (ref), Players (copy), u2 (ref), Events (copy), script_Parent (copy)
    if LocalPlayer:FindFirstChild("China") then
        return;
    end;

    if u19 then
        return;
    end;

    if not u3 or (not u3:IsDescendantOf(Players) or u2 == 0) then
        return;
    end;

    u19 = true;
    local _, v20 = Events.Votekick:InvokeServer(u3, u2);
    local notice2 = script_Parent.Main.Top.notice2;
    notice2.Visible = true;
    notice2.Text = v20;
    delay(2, function() -- Line: 187
        -- upvalues: u19 (ref), notice2 (copy)
        u19 = false;
        notice2.Visible = false;
    end);
end);
script_Parent.Main.Close.MouseButton1Click:connect(function() -- Line: 193
    -- upvalues: script_Parent (copy)
    script_Parent.Enabled = false;
end);
delay(3, function() -- Line: 197
    -- upvalues: RunService (copy), LocalPlayer (copy), script_Parent (copy), SecondsToClock (copy)
    RunService.Heartbeat:connect(function() -- Line: 198
        -- upvalues: LocalPlayer (ref), script_Parent (ref), SecondsToClock (ref)
        local v21 = os.time() - LocalPlayer.Data.VotekickTime.Value;
        local v22;

        if v21 < 0 then
            v22 = not script_Parent.Main.Top.notice2.Visible;
        else
            v22 = false;
        end;

        script_Parent.Main.Top.notice.Visible = v22;

        if script_Parent.Main.Top.notice.Visible then
            script_Parent.Main.Top.notice.Text = "Your recent votekick failed\nYou\'ll be able to votekick again in " .. SecondsToClock((math.abs(v21)));
        end;
    end);
end);