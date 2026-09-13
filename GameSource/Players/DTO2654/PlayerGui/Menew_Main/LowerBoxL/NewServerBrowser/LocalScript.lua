-- Decompiled with Potassium's decompiler.

local function update() -- Line: 1
    if game.Players.LocalPlayer.Name == "xonae" then
        script.Parent.Visible = true;

        return;
    end;

    script.Parent.Visible = workspace:GetAttribute("ServerBrowserVisible") == true;
end;

if game.Players.LocalPlayer.Name == "xonae" then
    script.Parent.Visible = true;
else
    script.Parent.Visible = workspace:GetAttribute("ServerBrowserVisible") == true;
end;

workspace:GetAttributeChangedSignal("ServerBrowserVisible"):Connect(update);