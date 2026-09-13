-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage"):WaitForChild("Modules");
game:GetService("ReplicatedStorage").Modules:WaitForChild("UIColorScript");
local UIColorScript = require(game:GetService("ReplicatedStorage").Modules.UIColorScript);

function updatecolor(p1)
    -- upvalues: UIColorScript (copy)
    UIColorScript:ColorMe(script.Parent.Parent.SharedColorData.CurrentColor.Value);
    UIColorScript:TextStroke(script.Parent.Parent.SharedColorData.TextStroke.Value, p1, script.Parent.Parent.SharedColorData.CurrentColor.Value);
end;

updatecolor(true);
local u2 = false;

for _, child in pairs(script.Parent.ImgBox.ScrollingFrame:GetChildren()) do
    if child:IsA("ImageButton") then
        child.MouseButton1Click:Connect(function() -- Line: 15
            -- upvalues: child (copy), UIColorScript (copy), u2 (ref)
            script.Parent.ImgBox.ExampleLabel.TextLabel.Text = child.ToolTip.Value;
            UIColorScript:ColorMe(child.ColorName.Value);
            script.Parent.Parent.SharedColorData.CurrentColor.Value = child.ColorName.Value;
            script.Parent.Parent.Parent.UpdateSetting:Fire("MenuColor", child.ColorName.Value);

            if u2 == false then
                u2 = true;
                game.ReplicatedStorage.Events.FREEBADGE:FireServer("gimmielol");
            end;
        end);
    end;
end;

script.Parent.ImgBox.StrokeBox.MouseButton1Click:Connect(function() -- Line: 28
    -- upvalues: UIColorScript (copy)
    if script.Parent.Parent.SharedColorData.TextStroke.Value == false then
        script.Parent.Parent.SharedColorData.TextStroke.Value = true;
        UIColorScript:TextStroke(true, nil, script.Parent.Parent.SharedColorData.CurrentColor.Value);
        script.Parent.ImgBox.StrokeBox.TextLabel.Visible = true;
        script.Parent.Parent.Parent.UpdateSetting:Fire("MenuStroke", true);

        return;
    end;

    script.Parent.Parent.SharedColorData.TextStroke.Value = false;
    UIColorScript:TextStroke(false);
    script.Parent.ImgBox.StrokeBox.TextLabel.Visible = false;
    script.Parent.Parent.Parent.UpdateSetting:Fire("MenuStroke", false);
end);
game.Players.LocalPlayer:WaitForChild("Settings");
game.Players.LocalPlayer.Settings:WaitForChild("MenuColor");
game.Players.LocalPlayer.Settings:WaitForChild("MenuStroke");
script.Parent.Parent.SharedColorData.CurrentColor.Value = game.Players.LocalPlayer.Settings.MenuColor.Value;
script.Parent.Parent.SharedColorData.TextStroke.Value = game.Players.LocalPlayer.Settings.MenuStroke.Value;

if script.Parent.Parent.SharedColorData.TextStroke.Value then
    script.Parent.ImgBox.StrokeBox.TextLabel.Visible = true;
end;

updatecolor();