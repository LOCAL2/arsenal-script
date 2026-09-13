-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;
local LocalPlayer = Players.LocalPlayer;
local u1 = RunService:IsStudio();
local CoOpEvent = ReplicatedStorage:WaitForChild("CoOpEvent");
local u2 = {};
script_Parent.Main.close.MouseButton1Down:Connect(function() -- Line: 20
    -- upvalues: script_Parent (copy)
    script_Parent.Visible = false;
    script.Parent.Parent.Main.Visible = true;
end);
script_Parent.Main.join.MouseButton1Down:Connect(function() -- Line: 25
    -- upvalues: script_Parent (copy)
    script_Parent.Main.Visible = false;
    script_Parent.Join.Visible = true;
end);
script_Parent.Main.create.MouseButton1Down:Connect(function() -- Line: 30
    -- upvalues: CoOpEvent (copy)
    CoOpEvent:FireServer("Create");
end);
script_Parent.Join.close.MouseButton1Down:Connect(function() -- Line: 34
    -- upvalues: script_Parent (copy)
    script_Parent.Join.Visible = false;
    script_Parent.Main.Visible = true;
end);
script_Parent.Main.hub.MouseButton1Down:Connect(function() -- Line: 39
    -- upvalues: TeleportService (copy)
    TeleportService:Teleport(17427651911);
end);
script_Parent.Lobby.close.MouseButton1Down:Connect(function() -- Line: 43
    -- upvalues: CoOpEvent (copy)
    CoOpEvent:FireServer("Leave");
end);

local function updatePlayerCount() -- Line: 49
    -- upvalues: script_Parent (copy)
    local v3 = #script_Parent.Lobby.Frame:GetChildren() - 1;
    script_Parent.Lobby.title.Text = `Current Lobby ({v3}/3)`;
end;

LocalPlayer:GetAttributeChangedSignal("Session"):Connect(function() -- Line: 55
    -- upvalues: updatePlayerCount (copy), u2 (copy), script_Parent (copy), LocalPlayer (copy), CoOpEvent (copy)
    pcall(updatePlayerCount);

    for _, v in u2 do
        v:Disconnect();
    end;

    for _, child in script_Parent.Lobby.Frame:GetChildren() do
        if child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    if script_Parent.Lobby.Frame:FindFirstChild(LocalPlayer.Name) then
        script_Parent.Lobby.Frame[LocalPlayer.Name]:Destroy();
    end;

    local v4 = script.template:Clone();
    v4.Name = LocalPlayer.Name;
    v4.TextLabel.Text = LocalPlayer.DisplayName;
    v4.ImageLabel.Image = `http://www.roblox.com/thumbs/avatar.ashx?x=352&y=352&format=png&username={LocalPlayer.Name}`;
    v4.Parent = script_Parent.Lobby.Frame;

    if LocalPlayer:GetAttribute("Session") == "" then
        script_Parent.Lobby.Visible = false;
        script_Parent.Main.Visible = true;

        return;
    end;

    script_Parent.Join.Visible = false;
    script_Parent.Main.Visible = false;
    script_Parent.Lobby.Visible = true;
    u2.Ready = script_Parent.Lobby.ready.MouseButton1Down:Connect(function() -- Line: 83
        -- upvalues: script_Parent (ref), CoOpEvent (ref)
        if script_Parent.Lobby.ready.Text == "Not Ready" then
            CoOpEvent:FireServer("Ready");

            return;
        end;

        if script_Parent.Lobby.ready.Text == "Ready" then
            CoOpEvent:FireServer("Unready");
        end;
    end);
    u2.Listener = CoOpEvent.OnClientEvent:Connect(function(p5: userdata) -- Line: 91
        -- upvalues: script_Parent (ref), LocalPlayer (ref), updatePlayerCount (ref)
        local v6 = p5.Player and script_Parent.Lobby.Frame:FindFirstChild(p5.Player.Name);

        if p5.Status == "Begin" then
            script_Parent.Lobby.ready.Text = "Teleporting!";
            script_Parent.Lobby.ready.BackgroundColor3 = Color3.fromRGB(170, 170, 255);
        elseif p5.Status == "Join" and not v6 then
            local v7 = script.template:Clone();
            v7.Name = p5.Player.Name;
            v7.TextLabel.Text = p5.Player.DisplayName;
            v7.ImageLabel.Image = `http://www.roblox.com/thumbs/avatar.ashx?x=352&y=352&format=png&username={p5.Player.Name}`;
            v7.Parent = script_Parent.Lobby.Frame;
        elseif p5.Status == "Leave" and v6 then
            v6:Destroy();
        elseif p5.Status == "Ready" and v6 then
            v6.BackgroundColor3 = Color3.fromRGB(85, 255, 127);

            if p5.Player == LocalPlayer then
                script_Parent.Lobby.ready.Text = "Ready";
                script_Parent.Lobby.ready.BackgroundColor3 = Color3.fromRGB(85, 255, 127);
            end;
        elseif p5.Status == "Unready" and v6 then
            v6.BackgroundColor3 = Color3.fromRGB(85, 170, 255);

            if p5.Player == LocalPlayer then
                script_Parent.Lobby.ready.Text = "Not Ready";
                script_Parent.Lobby.ready.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
            end;
        end;

        pcall(updatePlayerCount);
    end);
end);
CoOpEvent.OnClientEvent:Connect(function(u8: userdata) -- Line: 129
    -- upvalues: LocalPlayer (copy), u1 (copy), script_Parent (copy), CoOpEvent (copy)
    if u8.Status ~= "New" or not (LocalPlayer:IsFriendsWith(u8.Player.UserId) or u1) then
        if u8.Status == "Left" and script_Parent.Join.Frame:FindFirstChild(u8.Player.Name) then
            script_Parent.Join.Frame[u8.Player.Name]:Destroy();
        end;

        return;
    end;

    local v9 = script.template:Clone();
    v9.Name = u8.Player.Name;
    v9.TextLabel.Text = u8.Player.DisplayName;
    v9.ImageLabel.Image = `http://www.roblox.com/thumbs/avatar.ashx?x=352&y=352&format=png&username={u8.Player.Name}`;
    v9.Parent = script_Parent.Join.Frame;
    v9.MouseButton1Down:Connect(function() -- Line: 137
        -- upvalues: CoOpEvent (ref), u8 (copy)
        CoOpEvent:FireServer("Join", u8.Player);
    end);
end);
CoOpEvent:FireServer("Request");