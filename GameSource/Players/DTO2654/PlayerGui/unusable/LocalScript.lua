-- Decompiled with Potassium's decompiler.

local u1 = 0;
local TextLabel = script.Parent:WaitForChild("TextLabel");
local LocalPlayer = game:GetService("Players").LocalPlayer;
game:GetService("RunService").Stepped:connect(function() -- Line: 4
    -- upvalues: u1 (ref), TextLabel (copy)
    local v2 = tick() - u1;
    TextLabel.TextTransparency = (v2 > 3 and math.min(v2 - 3, 1) or 0) + 0.3;
end);
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("HitDebug").OnClientEvent:connect(function(p3) -- Line: 9
    -- upvalues: LocalPlayer (copy), TextLabel (copy), u1 (ref)
    if LocalPlayer:FindFirstChild("China") then
        return;
    end;

    TextLabel.Text = p3;
    u1 = tick();
end);