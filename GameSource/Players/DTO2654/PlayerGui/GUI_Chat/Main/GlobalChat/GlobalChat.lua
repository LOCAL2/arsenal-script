-- Decompiled with Potassium's decompiler.

wait(2);
local LocalPlayer = game.Players.LocalPlayer;

if not game:GetService("Chat"):CanUserChatAsync(LocalPlayer.userId) then
    return;
end;

LocalPlayer:GetMouse();
local script_Parent = script.Parent;
local TeamChat = script.Parent.Parent.TeamChat;
local Chats = script.Parent.Parent.Chats;
local free = script.Parent.Parent:WaitForChild("free");
local RunService = game:GetService("RunService");
local TimesChatted = script.Parent.Parent:WaitForChild("TimesChatted");
local u1 = {};
local UserInputService = game:GetService("UserInputService");

function takeUserInput()
    -- upvalues: free (copy), script_Parent (copy), TeamChat (copy), Chats (copy), RunService (copy), u1 (copy)
    free.Modal = true;
    script.Parent.TextTransparency = 0;
    script.Parent.Text = "";
    script_Parent.Visible = true;
    script_Parent.ActiveOne.Value = true;
    TeamChat.ActiveOne.Value = false;
    Chats.BackgroundTransparency = 0.7;
    Chats.ScrollingEnabled = true;
    Chats.ScrollBarThickness = 5;
    script_Parent:CaptureFocus();
    RunService.RenderStepped:wait();
    script.Parent.Text = "";

    for _, child in pairs(Chats:GetChildren()) do
        if child.Name:sub(1, 4) == "Line" then
            if child.TextTransparency == 1 then
                table.insert(u1, child);
            end;

            child.TextTransparency = 0;
            child.TextStrokeTransparency = child.TextTransparency;
        end;
    end;
end;

function openchat()
    -- upvalues: script_Parent (copy), LocalPlayer (copy)
    if script_Parent.Visible then
        script_Parent:CaptureFocus();

        return;
    end;

    if script_Parent.Visible == false and (script_Parent.Parent.TeamChat.Visible == false and LocalPlayer:WaitForChild("Status"):WaitForChild("CanTalk").Value) then
        takeUserInput();
    end;
end;

script.Parent.Parent.Parent.Mobile.Phone.Chat.MouseButton1Up:connect(function() -- Line: 48
    openchat();
end);
script.Parent.Parent.Parent.Mobile.Tablet.Chat.MouseButton1Up:connect(function() -- Line: 51
    openchat();
end);
UserInputService.InputBegan:connect(function(p2) -- Line: 54
    -- upvalues: UserInputService (copy)
    if script.Parent.ActiveOne.Value == true then
        return;
    end;

    if script.Parent.Parent.TeamChat.ActiveOne.Value == true then
        return;
    end;

    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if (p2.KeyCode == Enum.KeyCode.Y or p2.KeyCode == Enum.KeyCode.Slash) and game.Players.LocalPlayer.PlayerGui.Menew.Enabled == false then
        openchat();
    end;

    if p2.KeyCode == Enum.KeyCode.KeypadPlus then
        if game.Players.LocalPlayer:FindFirstChild("BigBaby") == nil then
            local BoolValue = Instance.new("BoolValue");
            BoolValue.Name = "BigBaby";
            BoolValue.Parent = game.Players.LocalPlayer;

            return;
        end;

        game.Players.LocalPlayer.BigBaby:Destroy();
    end;
end);
script_Parent.FocusLost:connect(function(p3) -- Line: 81
    -- upvalues: script_Parent (copy), TeamChat (copy), free (copy), Chats (copy), u1 (copy), LocalPlayer (copy), TimesChatted (copy)
    if p3 then
        if script_Parent.ActiveOne.Value == true then
            script_Parent.ActiveOne.Value = false;
            TeamChat.ActiveOne.Value = false;
            local v4 = script_Parent.Text == "" and "" or script_Parent.Text;
            free.Modal = false;
            script_Parent.Visible = false;
            Chats.BackgroundTransparency = 1;
            Chats.ScrollingEnabled = false;
            Chats.ScrollBarThickness = 0;
            script_Parent.Text = "";
            script_Parent.Size = UDim2.new(0, 500, 0, 25);

            for _, v in ipairs(u1) do
                if v then
                    v.TextTransparency = 1;
                    v.TextStrokeTransparency = 1;
                end;
            end;

            if #v4 > 400 then
                v4 = v4:sub(1, 400);
            end;

            if v4 ~= "" and LocalPlayer:WaitForChild("Status"):WaitForChild("CanTalk").Value then
                TimesChatted.Value = TimesChatted.Value + 1;
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerChatted"):FireServer("GRRR", v4, false, nil, not LocalPlayer:WaitForChild("Status"):WaitForChild("Alive").Value, true, nil, nil);
            end;
        end;
    elseif script_Parent.ActiveOne.Value == true then
        script_Parent.ActiveOne.Value = false;
        TeamChat.ActiveOne.Value = false;
        free.Modal = false;
        script_Parent.Visible = false;
        Chats.BackgroundTransparency = 1;
        Chats.ScrollingEnabled = false;
        Chats.ScrollBarThickness = 0;
        script_Parent.Text = "";
        script_Parent.Size = UDim2.new(0, 500, 0, 25);

        for _, v in ipairs(u1) do
            if v then
                v.TextTransparency = 1;
                v.TextStrokeTransparency = 1;
            end;
        end;
    end;
end);