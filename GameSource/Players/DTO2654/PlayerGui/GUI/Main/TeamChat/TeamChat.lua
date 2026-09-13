-- Decompiled with Potassium's decompiler.

wait(2);
local LocalPlayer = game.Players.LocalPlayer;

if not game:GetService("Chat"):CanUserChatAsync(LocalPlayer.userId) then
    return;
end;

LocalPlayer:GetMouse();
local script_Parent = script.Parent;
local GlobalChat = script.Parent.Parent.GlobalChat;
local Team = script.Parent.Parent.Team;
local Chats = script.Parent.Parent.Chats;
local free = script.Parent.Parent:WaitForChild("free");
local TimesChatted = script.Parent.Parent:WaitForChild("TimesChatted");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local u1 = {};
UserInputService.InputBegan:connect(function(p2) -- Line: 21
    -- upvalues: UserInputService (copy), script_Parent (copy), LocalPlayer (copy), free (copy), Team (copy), GlobalChat (copy), Chats (copy), RunService (copy), u1 (copy)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if script.Parent.ActiveOne.Value == true then
        return;
    end;

    if script.Parent.Parent.GlobalChat.ActiveOne.Value == true then
        return;
    end;

    if (p2.KeyCode == Enum.KeyCode.U or p2.KeyCode == Enum.KeyCode.Semicolon) and script_Parent.Visible then
        script_Parent:CaptureFocus();
    end;

    if p2.KeyCode ~= Enum.KeyCode.U and p2.KeyCode ~= Enum.KeyCode.Semicolon or not LocalPlayer:WaitForChild("Status"):WaitForChild("CanTalk").Value then
        return;
    end;

    if LocalPlayer.Status.Team.Value == "Spectator" then
        return;
    end;

    free.Modal = true;
    script_Parent.Visible = true;
    Team.Visible = true;
    script_Parent.ActiveOne.Value = true;
    GlobalChat.ActiveOne.Value = false;
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
end);
script_Parent.FocusLost:connect(function(p3) -- Line: 63
    -- upvalues: script_Parent (copy), GlobalChat (copy), free (copy), Team (copy), Chats (copy), u1 (copy), LocalPlayer (copy), TimesChatted (copy)
    if p3 then
        if script_Parent.ActiveOne.Value == true then
            script_Parent.ActiveOne.Value = false;
            GlobalChat.ActiveOne.Value = false;
            local v4 = script_Parent.Text == "" and "" or script_Parent.Text;
            free.Modal = false;
            script_Parent.Visible = false;
            Team.Visible = false;
            Chats.BackgroundTransparency = 1;
            Chats.ScrollingEnabled = false;
            Chats.ScrollBarThickness = 0;
            script_Parent.Text = "";
            script_Parent.Size = UDim2.new(0, 460, 0, 25);

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
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PlayerChatted"):FireServer("GRRR", v4, true, nil, not LocalPlayer:WaitForChild("Status"):WaitForChild("Alive").Value, true, nil, nil);
            end;
        end;
    elseif script_Parent.ActiveOne.Value == true then
        script_Parent.ActiveOne.Value = false;
        GlobalChat.ActiveOne.Value = false;
        free.Modal = false;
        script_Parent.Visible = false;
        Team.Visible = false;
        Chats.BackgroundTransparency = 1;
        Chats.ScrollingEnabled = false;
        Chats.ScrollBarThickness = 0;
        script_Parent.Text = "";
        script_Parent.Size = UDim2.new(0, 460, 0, 25);

        for _, v in ipairs(u1) do
            if v then
                v.TextTransparency = 1;
                v.TextStrokeTransparency = 1;
            end;
        end;
    end;
end);