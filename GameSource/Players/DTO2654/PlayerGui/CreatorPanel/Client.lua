-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Main = script.Parent.Main;
local LocalPlayer = Players.LocalPlayer;
local CreatorRemotes = ReplicatedStorage:WaitForChild("CreatorRemotes");
local u1 = game.ReplicatedStorage.Functions.Zip:InvokeServer("cmd", "GameTypes");
local u2 = {};
local u3 = nil;
local u4 = nil;
local u5 = nil;
local v6 = { "Chicken", "Ghosts", "HideWep", "LowGrav", "Reward", "Slomo", "SpawnFog" };

for _, child in pairs(script.Maps:GetChildren()) do
    table.insert(u2, child.Name);
end;

LocalPlayer:WaitForChild("DataLoaded", 99999);

if LocalPlayer:FindFirstChild("IsYoutuber") or LocalPlayer:FindFirstChild("IsAdmin") and tostring(LocalPlayer) ~= "TCtully" then
    local function createPlayerlist() -- Line: 34
        -- upvalues: Main (copy), Players (copy), LocalPlayer (copy), u5 (ref)
        for _, child in pairs(Main.Playerlist:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy();
            end;
        end;

        for _, child in pairs(Players:GetChildren()) do
            if child ~= LocalPlayer then
                local u7 = script.User:Clone();
                u7.Name = child.Name;
                u7.Text = child.Name;
                u7.Parent = Main.Playerlist;
                u7.MouseButton1Down:connect(function() -- Line: 48
                    -- upvalues: u5 (ref), Main (ref), child (copy), u7 (copy)
                    if u5 and (u5.Parent and Main.Playerlist:FindFirstChild(u5.Name)) then
                        Main.Playerlist[u5.Name].TextColor3 = Color3.fromRGB(255, 255, 255);
                    end;

                    u5 = child;
                    u7.TextColor3 = Color3.fromRGB(85, 255, 127);
                end);
            end;
        end;

        coroutine.resume(coroutine.create(function() -- Line: 59
            -- upvalues: Main (ref)
            wait(0.1);
            Main.Playerlist.CanvasSize = UDim2.new(0, 0, 0, Main.Playerlist.UIListLayout.AbsoluteContentSize.Y);
        end));
    end;

    for _, v in pairs(v6) do
        if Main:FindFirstChild(v) then
            Main[v].MouseButton1Down:connect(function() -- Line: 68
                -- upvalues: CreatorRemotes (copy), v (copy)
                CreatorRemotes.Power:FireServer(v);
            end);
        end;
    end;

    local function clearList() -- Line: 74
        -- upvalues: Main (copy)
        for _, child in pairs(Main.Votelist:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy();
            end;
        end;
    end;

    local function genList(u8) -- Line: 82
        -- upvalues: clearList (copy), Main (copy), u1 (copy), u2 (copy), u3 (ref), u4 (ref)
        clearList();
        Main.Votelist.Visible = true;
        Main.Votelist.Position = Main[u8].Position + UDim2.new(0, 0, 0.1, 0);

        for _, v in pairs(u8 == "ModeSelect" and u1 or u2) do
            local v9 = script.User:Clone();
            v9.Name = v;
            v9.Text = v;
            v9.Parent = Main.Votelist;
            v9.MouseButton1Down:connect(function() -- Line: 94
                -- upvalues: Main (ref), u8 (copy), u3 (ref), v (copy), u4 (ref)
                if Main.Votelist.Visible then
                    if u8 == "ModeSelect" then
                        u3 = v;
                        Main.ModeSelect.TextLabel.Text = u3;
                    else
                        u4 = v;
                        Main.MapSelect.TextLabel.Text = u4;
                    end;
                end;

                Main.Votelist.Visible = false;
            end);
        end;

        coroutine.resume(coroutine.create(function() -- Line: 109
            -- upvalues: Main (ref)
            wait(0.1);
            Main.Votelist.CanvasSize = UDim2.new(0, 0, 0, Main.Votelist.UIListLayout.AbsoluteContentSize.Y);
        end));
    end;

    Main.MapSelect.MouseButton1Down:connect(function() -- Line: 116
        -- upvalues: genList (copy)
        genList("MapSelect");
    end);
    Main.ModeSelect.MouseButton1Down:connect(function() -- Line: 120
        -- upvalues: genList (copy)
        genList("ModeSelect");
    end);
    Main.MapSelect.DropDown.MouseButton1Down:connect(function() -- Line: 124
        -- upvalues: genList (copy)
        genList("MapSelect");
    end);
    Main.ModeSelect.DropDown.MouseButton1Down:connect(function() -- Line: 128
        -- upvalues: genList (copy)
        genList("ModeSelect");
    end);
    Main.StartVote.MouseButton1Down:connect(function() -- Line: 132
        -- upvalues: CreatorRemotes (copy), u4 (ref), u3 (ref)
        CreatorRemotes.Vote:FireServer(u4, u3);
    end);
    Main.Kick.MouseButton1Down:connect(function() -- Line: 136
        -- upvalues: u5 (ref), CreatorRemotes (copy), Main (copy)
        if u5 and u5.Parent then
            CreatorRemotes.Kick:FireServer(u5, Main.KickReason.TextBox.Text);
        end;
    end);
    Main.Close.MouseButton1Down:connect(function() -- Line: 142
        -- upvalues: Main (copy)
        Main.Visible = false;
    end);
    UserInputService.InputBegan:connect(function(p10) -- Line: 146
        -- upvalues: UserInputService (copy), ReplicatedStorage (copy), Main (copy), createPlayerlist (copy)
        if p10.KeyCode == Enum.KeyCode.P and not (UserInputService:GetFocusedTextBox() or ReplicatedStorage.IsELO.Value) then
            Main.Visible = not Main.Visible;

            if Main.Visible then
                createPlayerlist();
            end;
        end;
    end);
end;

CreatorRemotes.Vote.OnClientEvent:connect(function(p11, p12, p13, p14, p15) -- Line: 157
    -- upvalues: Main (copy), UserInputService (copy), CreatorRemotes (copy)
    Main.Parent.Vote.Visible = true;
    Main.Parent.Vote.Info.Creator.Text = p11 .. " Began A Map/Mode Vote!";
    Main.Parent.Vote.Info.Info.Text = p13 .. " On " .. p12 .. " (" .. p14 .. "/" .. p15 .. ")";
    local u16 = nil;
    local u17 = nil;
    local u18 = nil;
    u18 = UserInputService.InputBegan:connect(function(p19) -- Line: 166
        -- upvalues: CreatorRemotes (ref), Main (ref), u16 (ref), u17 (ref), u18 (ref)
        if p19.KeyCode == Enum.KeyCode.I then
            CreatorRemotes.Decide:FireServer();
        end;

        if p19.KeyCode == Enum.KeyCode.I or p19.KeyCode == Enum.KeyCode.O then
            Main.Parent.Vote.Visible = false;
            u16:disconnect();
            u17:disconnect();
            u18:disconnect();
        end;
    end);
    u16 = Main.Parent.Vote.No.Click.MouseButton1Down:connect(function() -- Line: 180
        -- upvalues: Main (ref), u17 (ref), u18 (ref), u16 (ref)
        Main.Parent.Vote.Visible = false;
        u17:disconnect();
        u18:disconnect();
        u16:disconnect();
    end);
    u17 = Main.Parent.Vote.Yes.Click.MouseButton1Down:connect(function() -- Line: 188
        -- upvalues: Main (ref), CreatorRemotes (ref), u16 (ref), u18 (ref), u17 (ref)
        Main.Parent.Vote.Visible = false;
        CreatorRemotes.Decide:FireServer();
        u16:disconnect();
        u18:disconnect();
        u17:disconnect();
    end);
end);