-- Decompiled with Potassium's decompiler.

local table_insert = table.insert;
local _ = BrickColor.new;
local _ = Color3.new;
wkspc = game.ReplicatedStorage.wkspc;
local Teams = require(game.ReplicatedStorage.Modules.Teams);
coroutine.resume(coroutine.create(function() -- Line: 8
    wait(5);

    if game.Players.LocalPlayer:FindFirstChild("China") then
        script.n.BG.Dead.Image = "rbxassetid://6744911076";
    end;
end));

function ColorMeUp()
    -- upvalues: Teams (copy)
    if game.Players.LocalPlayer:FindFirstChild("Status") then
        local GUI = game.Players.LocalPlayer.PlayerGui.GUI;
        local v1 = (Teams.colors[game.Players.LocalPlayer.Status.Team.Value] or Teams.colors.TBC)[5];
        GUI.NotificateML.TextStrokeColor3 = v1;
        GUI.NotificateTL.TextStrokeColor3 = v1;
    end;
end;

local CollectionService = game:GetService("CollectionService");

while wait(1) do
    if wkspc.CurrentCurse.Value == "Hidden" or (wkspc.gametype.Value == "cXVlc3Q=" or wkspc.gametype.Value == "TrickOrTreat") then
        script.Parent.Visible = false;
    else
        script.Parent.Visible = true;
    end;

    local u2 = {};
    gamemode = wkspc.gametype.Value;
    local Value = wkspc.TrackStat.Value;
    pcall(function() -- Line: 36
        -- upvalues: u2 (copy), table_insert (copy), Value (copy)
        for _, v in pairs(game.Players:GetPlayers()) do
            if v:FindFirstChild("Status") and (v.Status:FindFirstChild("Level") and (v.Status:FindFirstChild("Team") and v.Status.Team.Value ~= "Spectator")) and (wkspc.BR.Value == true and v.DesignColor.Value == game.Players.LocalPlayer.DesignColor.Value or wkspc.BR.Value == false) then
                if #u2 == 0 then
                    table_insert(u2, v);
                else
                    local v3 = v;

                    for i = 1, #u2 do
                        if wkspc.BF.Value == true then
                            if v3.ScoreFolder.BDamage.Value >= u2[i].ScoreFolder.BDamage.Value then
                                table_insert(u2, i, v3);
                                break;
                            end;
                        elseif Value == "Level" then
                            if v3.Status.Level.Value >= u2[i].Status.Level.Value then
                                table_insert(u2, i, v3);
                                break;
                            end;
                        elseif v3.ScoreFolder[Value].Value >= u2[i].ScoreFolder[Value].Value then
                            table_insert(u2, i, v3);
                            break;
                        end;

                        local v4;

                        if i == #u2 then
                            table_insert(u2, v3);
                            v4 = i;
                        else
                            v4 = i;
                        end;
                    end;
                end;
            end;
        end;
    end);
    script.Parent.Parent.NotificateTL.Visible = false;
    script.Parent.Parent.NotificateML.Visible = false;

    if game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("TeamLeader") then
        script.Parent.Parent.NotificateTL.Visible = true;
        ColorMeUp();
        local LocalPlayer = game.Players.LocalPlayer;
        local Color = LocalPlayer.TeamColor.Color;

        if wkspc.FFA.Value == true or wkspc.gametype.Value == "Juggernaut" then
            Color = LocalPlayer.DesignColor.Value.Color;
        end;

        script.Parent.Parent.Uberd.ImageColor3 = Color;
        script.Parent.Parent.Uberd.Visible = LocalPlayer.Settings.TeamLeaderDisplay.Value;
    else
        script.Parent.Parent.Uberd.Visible = false;
    end;

    if game.Players.LocalPlayer and (u2[1] and (u2[1].Name == game.Players.LocalPlayer.Name and game.Players.LocalPlayer:FindFirstChild("TeamLeader"))) then
        script.Parent.Parent.NotificateTL.Visible = false;
        script.Parent.Parent.NotificateML.Visible = true;
        ColorMeUp();
    end;

    for i = 1, 10 do
        local v5;

        if script.Parent:FindFirstChild(i) then
            script.Parent[i]:Destroy();
            v5 = i;
        else
            v5 = i;
        end;
    end;

    local v6 = 0;

    for i = 1, #u2 do
        local v7;

        if i <= 10 then
            local v8 = script.n:clone();
            v8.Parent = script.Parent;
            v8.Name = i;
            v8.Position = UDim2.new(0.5, v8.AbsoluteSize.X * (i - 1), 0, 0);

            if i > 1 then
                v6 = v6 + v8.AbsoluteSize.X / 2;
            end;

            local v9 = Teams.colors[u2[i].Status.Team.Value];

            if v9 then
                v8.BackgroundColor3 = game.Players.LocalPlayer == u2[i] and v9[7] or v9[6];
                local v10 = Teams.rgb[u2[i].Status.Team.Value];

                if v10 and CollectionService:HasTag(v8, "RGB") == false then
                    CollectionService:AddTag(v8, "RGB");
                elseif not v10 and CollectionService:HasTag(v8, "RGB") then
                    CollectionService:RemoveTag(v8, "RGB");
                end;
            end;

            if wkspc.FFA.Value == true or wkspc.gametype.Value == "Juggernaut" then
                v8.BackgroundColor3 = u2[i].DesignColor.Value.Color;

                if game.Players.LocalPlayer and u2[i].Name == game.Players.LocalPlayer.Name then
                    v8.BackgroundColor3 = Color3.new(1, 1, 1);
                end;
            end;

            v8.Visible = true;
            v8.BG.Level.Text = u2[i].Status.Level.Value;

            if Value ~= "Level" then
                v8.BG.Level.Text = u2[i].ScoreFolder[Value].Value;
            end;

            if wkspc.BF.Value == true then
                v8.BG.Level.Text = math.floor(u2[i].ScoreFolder.BDamage.Value);
            end;

            local UserId = u2[i].UserId;
            local v11 = game.Players.LocalPlayer:FindFirstChild("Settings") and (game.Players.LocalPlayer.Settings:FindFirstChild("MaskUsernames") and game.Players.LocalPlayer.Settings.MaskUsernames.Value) and 1 or (UserId < 1 and 1 or UserId);
            v8.BG.Player.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=352&y=352&userId=" .. v11;
            v8.ImageColor3 = v8.BackgroundColor3;
            local R = v8.ImageColor3.R;
            local G = v8.ImageColor3.G;
            local B = v8.ImageColor3.B;
            v8.BG.ImageColor3 = Color3.new(R * 0.6, G * 0.6, B * 0.6);
            v8.BG.Player.BackgroundColor3 = Color3.new(R * 0.5, G * 0.5, B * 0.5);

            if u2[i]:FindFirstChild("IsBernard") then
                v8.BG.Bernie.Visible = true;
            end;

            if u2[i]:FindFirstChild("TeamLeader") then
                v8.BG.Leader.Visible = true;
            end;

            if u2[i]:FindFirstChild("NRPBS") and u2[i].NRPBS.Health.Value <= 0 then
                v8.BG.Dead.Visible = true;
                v7 = i;
            else
                v7 = i;
            end;
        else
            v7 = i;
        end;
    end;

    script.Parent.Position = UDim2.new(0, -v6, 0.04, 0);
    game:GetService("GuiService"):IsTenFootInterface();
end;