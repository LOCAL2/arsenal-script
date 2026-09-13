-- Decompiled with Potassium's decompiler.

script.Parent.Visible = workspace:GetAttribute("RobloxEventEnabled") == true;
workspace:GetAttributeChangedSignal("RobloxEventEnabled"):Connect(function() -- Line: 3, Name: update
    script.Parent.Visible = workspace:GetAttribute("RobloxEventEnabled") == true;
end);