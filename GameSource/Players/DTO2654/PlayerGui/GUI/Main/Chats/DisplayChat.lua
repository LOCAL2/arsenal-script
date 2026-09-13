-- Decompiled with Potassium's decompiler.

wait();
game:GetService("MarketplaceService");
wkspc = game.ReplicatedStorage.wkspc;
local LocalPlayer = game.Players.LocalPlayer;

if not game:GetService("Chat"):CanUserChatAsync(LocalPlayer.userId) then
    return;
end;

local _ = script.Parent;
local u1 = 0;
local RunService = game:GetService("RunService");
RunService:IsStudio();
local Teams = require(game.ReplicatedStorage.Modules.Teams);
require(game.ReplicatedStorage.Modules.ModCheck);
local SampleName = script.Parent:WaitForChild("SampleName");
script.Parent:WaitForChild("SampleNotification");
local GetUsername = require(game.ReplicatedStorage.Modules.GetUsername);

function tableContains(p2, p3)
    for _, v in pairs(p2) do
        if v == p3 then
            return true;
        end;
    end;

    return false;
end;

local u4 = { "RainsterYT", "xonae", "JJ_Waike", "ElectrifyThunder", "Hackmud", "Green_Sama", "SNKerdoodle", "Chloramine", "catalyctic", "do_youyolo", "krissypinko" };

function moveOldMessages()
    for _, child in pairs(script.Parent:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:sub(1, 4) == "Line" then
            child.Position = child.Position + UDim2.new(0, 0, 0, -19);
            local string_sub_ret = string.sub(child.Name, 5);
            child.Name = "Line" .. tonumber(string_sub_ret) + 1;

            if child.Name == "Line37" then
                child:Destroy();
            end;
        end;
    end;
end;

function adjustPositions()
    for _, child in pairs(script.Parent:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:sub(1, 4) == "Line" then
            if child.Active then
                local UDim2_new = UDim2.new;
                local Scale = child.Position.X.Scale;
                local Offset = child.Position.X.Offset;
                local Scale2 = child.Position.Y.Scale;
                local v5 = script.Parent.CanvasSize.Y.Offset - 31;
                local v6 = string.sub(child.Name, 5) - 1;
                child.Position = UDim2_new(Scale, Offset, Scale2, v5 - (tonumber(v6) * 19 - 8));
            else
                local UDim2_new = UDim2.new;
                local Scale = child.Position.X.Scale;
                local Offset = child.Position.X.Offset;
                local Scale2 = child.Position.Y.Scale;
                local v7 = script.Parent.CanvasSize.Y.Offset - 31;
                local v8 = string.sub(child.Name, 5) - 1;
                child.Position = UDim2_new(Scale, Offset, Scale2, v7 - tonumber(v8) * 19);
            end;
        end;
    end;
end;

function fade(p9)
    wait(15);

    for i = 0, 1, 0.1 do
        local v10;

        if script.Parent.Parent:WaitForChild("GlobalChat").Visible or script.Parent.Parent:WaitForChild("TeamChat").Visible == true then
            p9.TextTransparency = 0;
            p9.TextStrokeTransparency = p9.TextTransparency;
            v10 = i;

            repeat
                wait();
            until script.Parent.BackgroundTransparency == 1;
        else
            v10 = i;
        end;

        p9.TextTransparency = v10;
        p9.TextStrokeTransparency = p9.TextTransparency;
        wait(0.1);
    end;
end;

function round(p11)
    return math.floor(p11 + 0.5);
end;

local Color3Value = Instance.new("Color3Value");
coroutine.resume(coroutine.create(function() -- Line: 80
    -- upvalues: Color3Value (copy)
    while wait(0.125) do
        Color3Value.Value = Color3.fromHSV(tick() % 10 / 10, 1, 1);
    end;
end));

function createNewMessage(p12, u13, p14, p15, p16, p17, p18)
    -- upvalues: GetUsername (copy), SampleName (copy), u1 (ref), Color3Value (copy)
    if p12 ~= 1337 then
        game.ReplicatedStorage.Updates.e:FireServer("Hey there, stinky exploiters!\nI know you guys have a lot more copy and pasting to do to try and make your scripts work, but let\'s chat real quick.\n\nI know who you are. I know you\'re all young kids just having a bit of fun, maybe there\'s some tough things going at home, and I really do sympathise with you there.\nThe only place you feel you have control is online, where you hurt the fun of other people just to feel a glimpse of that crucial control you\'re lacking in life right now.\n\nWell, it\'s alright. Things get better with time, and one day you\'ll look back on these days and laugh, cringe, maybe even feel guilty at how you acted and the things you did.\n\nAs for now, though? I\'m forever up on you. You spend hours, even days trying to get this stuff to work with the basic knowledge of Lua you have, and I can patch it in minutes.\nI have a decade of experience doing this stuff, whereas that\'s not much more time than you\'ve even been alive for. I get paid to do this, you earn nothing.\n\nBut I want you to know that it\'s never too late to change. You can use your powers for good. Learn to script properly, make a game, maybe make a bit of legitimate cash on the side!\nAnd if that ever happens, you\'ll end up facing people just like you now. Troubled people who have fun ruining the fun of others. And then you\'ll have to try and patch out their efforts too.\n\nBut then you\'ll look back at these times and laugh, then just patch it and move on with your day. It won\'t stick with you, it won\'t make you lose sleep. It\'s just work, and it\'s fun work at that.\n\nThis isn\'t some fancy words just to try and make you stop doing what you\'re doing either. I enjoy this cat and mouse game, and if it isn\'t you at the end of the day it\'ll be some other kids.\nIf you do heed my advice and make a difference in your life, however, then I\'d love to hear about it or even give more advice 1 on 1 if you want. Mention this message and I\'ll know.\n\nIf you choose to ignore this and just carry on writing your scripts, then I look forward to patching them.\n\n");

        return;
    end;

    if typeof(p15) == "BrickColor" then
        p15 = p15.Color;
    end;

    if typeof(p16) == "BrickColor" then
        p16 = p16.Color;
    end;

    local TextLabel = Instance.new("TextLabel", script.Parent);
    TextLabel.ZIndex = 15;
    TextLabel.Name = "Line1";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.ClipsDescendants = false;
    TextLabel.TextScaled = false;
    TextLabel.TextColor3 = p15;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.TextStrokeTransparency = TextLabel.TextTransparency;
    TextLabel.TextWrapped = false;
    TextLabel.Font = "SourceSansBold";
    TextLabel.TextSize = 18;
    TextLabel.TextXAlignment = "Left";
    TextLabel.Size = UDim2.new(590, 0, 36, 0);
    TextLabel.Text = GetUsername.GetNameToShow(u13);
    pcall(function() -- Line: 139
        -- upvalues: u13 (copy), TextLabel (copy)
        local v19 = game.Players:FindFirstChild(u13);
        local v20 = "";

        if v19.HasVerifiedBadge then
            v20 = v20 .. " ";
        end;

        if v19:FindFirstChild("GroupMember") then
            v20 = v20 .. "💪";
        end;

        if v19:FindFirstChild("IsAdmin") then
            v20 = v20 .. "🛠";
        end;

        if v19:FindFirstChild("IsChad") then
            v20 = v20 .. "😎";
        end;

        if v19:FindFirstChild("OldVIP") then
            v20 = v20 .. "💎";
        end;

        if v19:FindFirstChild("VIP") then
            v20 = v20 .. "👑";
        end;

        if v19:FindFirstChild("Romin") then
            v20 = v20 .. "💯";
        end;

        if v19:FindFirstChild("Workshop") then
            v20 = v20 .. "⚙";
        end;

        if v20 ~= "" then
            TextLabel.Text = "[" .. v20 .. "] " .. TextLabel.Text;
        end;
    end);
    SampleName.Text = TextLabel.Text;
    local v21 = SampleName.TextBounds.X + 1;
    TextLabel.Size = UDim2.new(0, v21, 0, 36);
    TextLabel.Position = UDim2.new(p17, 0, 0, 147);
    local TextLabel2 = Instance.new("TextLabel", script.Parent);
    TextLabel2.AutoLocalize = false;
    TextLabel2.ZIndex = 15;
    TextLabel2.Name = "Line1";
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.BorderSizePixel = 0;
    TextLabel2.Active = false;
    TextLabel2.ClipsDescendants = false;
    TextLabel2.TextScaled = false;
    TextLabel2.TextWrapped = false;
    local X = TextLabel.TextBounds.X;

    if p18 then
        X = X + p18.TextBounds.X;
    end;

    TextLabel2.Size = UDim2.new(0, 493 - X, 0, 36);
    TextLabel2.Position = TextLabel.Position + UDim2.new(0, v21, 0, 0);
    TextLabel2.TextColor3 = p16;
    TextLabel2.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel2.TextStrokeTransparency = TextLabel2.TextTransparency;
    TextLabel2.Font = "SourceSans";
    TextLabel2.TextSize = 18;
    TextLabel2.TextXAlignment = "Left";
    TextLabel2.Text = ": " .. p14;

    if TextLabel2.TextBounds.X <= 487 - X and TextLabel2.TextBounds.Y <= 18 then
        u1 = u1 + 1;
    else
        moveOldMessages();

        if not string.find(p14, " ") then
            local math_ceil_ret = math.ceil(#p14 / 3);
            local string_sub_ret = string.sub(p14, 1, math_ceil_ret);
            local v22 = math.ceil(#p14 / 3) + 1;
            TextLabel2.Text = ": " .. string_sub_ret .. "  " .. string.sub(p14, v22);
        end;

        TextLabel2.Size = UDim2.new(0, 493 - X, 0, 36);
        TextLabel2.Position = TextLabel2.Position + UDim2.new(0, 0, 0, 8);
        TextLabel2.TextYAlignment = "Top";
        u1 = u1 + 2;
    end;

    TextLabel2.TextWrapped = true;

    if game.Players:FindFirstChild(u13) and (game.Players:FindFirstChild(u13):FindFirstChild("VIP") or game.Players:FindFirstChild(u13):FindFirstChild("OldVIP")) then
        Color3Value:GetPropertyChangedSignal("Value"):connect(function() -- Line: 217
            -- upvalues: TextLabel2 (copy), Color3Value (ref)
            if TextLabel2 and TextLabel2.Parent then
                TextLabel2.TextColor3 = Color3Value.Value;
                TextLabel2.TextStrokeColor3 = Color3.new(Color3Value.Value.r - 75, Color3Value.Value.g - 75, Color3Value.Value.b - 75);
            end;
        end);
    end;

    if u1 < 36 then
        script.Parent.CanvasSize = UDim2.new(0, 0, 0, round(u1 * 19.77));
    else
        script.Parent.CanvasSize = UDim2.new(0, 0, 0, 693);
    end;

    if u1 > 9 then
        adjustPositions();
        script.Parent.CanvasPosition = Vector2.new(0, script.Parent.CanvasSize.Y.Offset - 178);
    end;
end;

local Preparation = wkspc:WaitForChild("Status"):WaitForChild("Preparation");
local RoundOver = wkspc:WaitForChild("Status"):WaitForChild("RoundOver");
game.ReplicatedStorage.Events.reward.OnClientEvent:connect(function(p23) -- Line: 237
    moveOldMessages();
    createNewMessage(1337, "Server", p23, BrickColor.new("New Yeller").Color, BrickColor.new("New Yeller").Color, 0.01, nil);
end);
game.ReplicatedStorage.Events.PlayerChatted.OnClientEvent:connect(function(p24, p25, p26, p27, p28, p29, p30) -- Line: 241
    -- upvalues: Teams (copy), LocalPlayer (copy), Preparation (copy), RoundOver (copy)
    local v31 = game.Players[p24];
    local White = BrickColor.new("White");
    local v32 = v31 and (v31.NRPBS and v31.NRPBS.Health.Value <= 0) and true or p28;
    local v33;

    if v31 then
        v33 = Teams.colors[v31.Status.Team.Value];
    else
        v33 = v31;
    end;

    if v33 then
        White = v33[2];
    end;

    if wkspc.FFA.Value == true or wkspc.gametype.Value == "Juggernaut" then
        White = v31.DesignColor.Value.Color;
    end;

    local Settings = LocalPlayer:FindFirstChild("Settings");

    if Settings and Settings.VisibleChat.Value == false then
        if p26 == true then
            if v31.Status.Team.Value == LocalPlayer.Status.Team.Value then
                moveOldMessages();
                local TextLabel = Instance.new("TextLabel", script.Parent);
                TextLabel.ZIndex = 15;
                TextLabel.Name = "Line1";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.Size = UDim2.new(0, 590, 0, 36);
                TextLabel.Position = UDim2.new(0.01, 0, 0, 147);
                TextLabel.TextColor3 = script.Parent.TeamValueColor.Value;
                TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
                TextLabel.TextStrokeTransparency = TextLabel.TextTransparency;
                TextLabel.TextWrapped = false;
                TextLabel.Font = "SourceSansBold";
                TextLabel.TextSize = 18;
                TextLabel.TextXAlignment = "Left";
                TextLabel.Text = "(TEAM)";
                TextLabel.Size = UDim2.new(0, TextLabel.TextBounds.X + 1, 0, 36);
                createNewMessage(1337, p24, p25, White, Color3.new(255, 255, 255), 0.108, TextLabel);
            end;
        else
            if v31.Status.Team.Value ~= "Spectator" then
                local _ = v31:WaitForChild("Status"):WaitForChild("Alive").Value;

                if not v32 then
                    moveOldMessages();
                    createNewMessage(1337, p24, p25, White, Color3.new(255, 255, 255), 0.01, nil);

                    return;
                end;

                local _ = game.Players.LocalPlayer;
                moveOldMessages();
                local TextLabel = Instance.new("TextLabel", script.Parent);
                TextLabel.ZIndex = 15;
                TextLabel.Name = "Line1";
                TextLabel.BackgroundTransparency = 1;
                TextLabel.BorderSizePixel = 0;
                TextLabel.Size = UDim2.new(0, 590, 0, 36);
                TextLabel.Position = UDim2.new(0.01, 0, 0, 147);
                TextLabel.TextColor3 = script.Parent.DeadColor.Value;
                TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
                TextLabel.TextStrokeTransparency = TextLabel.TextTransparency;
                TextLabel.TextWrapped = false;
                TextLabel.Font = "SourceSansBold";
                TextLabel.TextSize = 18;
                TextLabel.TextXAlignment = "Left";
                TextLabel.Text = "*DEAD*";
                TextLabel.Size = UDim2.new(0, TextLabel.TextBounds.X + 1, 0, 36);
                createNewMessage(1337, p24, p25, White, Color3.new(255, 255, 255), 0.114, TextLabel);

                return;
            end;

            if v31.Status.Team.Value == "Spectator" then
                local LocalPlayer2 = game.Players.LocalPlayer;

                if v31.Name == LocalPlayer2.Name or (v31.Name == "DevRolve" or (Preparation.Value or (RoundOver.Value or LocalPlayer2.Status.Team.Value == "Spectator"))) then
                    moveOldMessages();
                    local TextLabel = Instance.new("TextLabel", script.Parent);
                    TextLabel.ZIndex = 15;
                    TextLabel.Name = "Line1";
                    TextLabel.BackgroundTransparency = 1;
                    TextLabel.BorderSizePixel = 0;
                    TextLabel.Size = UDim2.new(0, 590, 0, 36);
                    TextLabel.Position = UDim2.new(0.01, 0, 0, 147);
                    TextLabel.TextColor3 = script.Parent.SpectatorColor.Value;
                    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
                    TextLabel.TextStrokeTransparency = TextLabel.TextTransparency;
                    TextLabel.TextWrapped = false;
                    TextLabel.Font = "SourceSansBold";
                    TextLabel.TextSize = 18;
                    TextLabel.TextXAlignment = "Left";
                    TextLabel.Text = "(SPECTATOR)";
                    TextLabel.Size = UDim2.new(0, TextLabel.TextBounds.X + 1, 0, 36);
                    createNewMessage(1337, p24, p25, White, Color3.new(255, 255, 255), 0.189, TextLabel);
                end;
            end;
        end;
    end;
end);

function Chat2(p34, p35, p36)
    -- upvalues: u1 (ref)
    if p34 ~= "" then
        moveOldMessages();
        local TextLabel = Instance.new("TextLabel", script.Parent);
        TextLabel.ZIndex = 15;
        TextLabel.Name = "Line1";
        TextLabel.BackgroundTransparency = 1;
        TextLabel.BorderSizePixel = 0;
        TextLabel.Size = UDim2.new(0, 590, 0, 36);
        TextLabel.Position = UDim2.new(0.01, 0, 0, 147);
        TextLabel.TextColor3 = p35;
        TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
        TextLabel.TextStrokeTransparency = TextLabel.TextTransparency;
        TextLabel.TextWrapped = false;
        TextLabel.Font = "SourceSansBold";
        TextLabel.TextSize = 18;
        TextLabel.TextXAlignment = "Left";
        TextLabel.Text = p34;

        if p36 then
            TextLabel.AutoLocalize = true;
        end;

        u1 = u1 + 1;

        if u1 < 36 then
            script.Parent.CanvasSize = UDim2.new(0, 0, 0, round(u1 * 19.77));
        else
            script.Parent.CanvasSize = UDim2.new(0, 0, 0, 693);
        end;

        if u1 > 9 then
            adjustPositions();
            script.Parent.CanvasPosition = Vector2.new(0, script.Parent.CanvasSize.Y.Offset - 178);
        end;
    end;
end;

wkspc:WaitForChild("Status"):WaitForChild("PlayerEntered").Changed:connect(function(p37) -- Line: 386
    -- upvalues: u4 (copy), GetUsername (copy)
    if p37 ~= "" then
        if p37 == "DevRolve" or (p37 == "Castlers" or tableContains(u4, p37, true)) then
            return;
        end;

        Chat2(GetUsername.GetNameToShow(p37) .. " has joined the server.", Color3.new(0.5058823529411764, 0.7568627450980392, 0.7568627450980392));
    end;
end);
wkspc:WaitForChild("Status"):WaitForChild("PlayerLeft").Changed:connect(function(p38) -- Line: 396
    -- upvalues: u4 (copy), GetUsername (copy)
    if p38 ~= "" and wkspc.ServerShutdown.Value == false then
        if p38 == "DevRolve" or (p38 == "Castlers" or tableContains(u4, p38, true)) then
            return;
        end;

        Chat2(GetUsername.GetNameToShow(p38) .. " has left the server.", Color3.new(0.5058823529411764, 0.7568627450980392, 0.7568627450980392));
    end;
end);
script.Parent.DescendantAdded:connect(function(p39) -- Line: 410
    -- upvalues: RunService (copy)
    if p39:IsA("TextLabel") and not p39.Active then
        RunService.Heartbeat:wait();
        fade(p39);
    end;
end);
game.ReplicatedStorage.Events.SendMsg.OnClientEvent:connect(function(p40, p41) -- Line: 419
    if p41 == nil then
        p41 = Color3.new(1, 1, 1);
    end;

    Chat2(p40, p41);
end);