-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

function Fade(p1)
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if not p1 then
        TweenService:Create(script.Parent, TweenInfo_new_ret, {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(script.Parent.TextLabel, TweenInfo_new_ret, {
            TextTransparency = 1
        }):Play();
        TweenService:Create(script.Parent.TextLabel, TweenInfo_new_ret, {
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(script.Parent.Frame, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        }):Play();

        return;
    end;

    local ImageForKeyCode = game:GetService("UserInputService"):GetImageForKeyCode(Enum.KeyCode.ButtonSelect);
    script.Parent.Image = ImageForKeyCode;
    TweenService:Create(script.Parent, TweenInfo_new_ret, {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(script.Parent.TextLabel, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    TweenService:Create(script.Parent.TextLabel, TweenInfo_new_ret, {
        TextStrokeTransparency = 0
    }):Play();
    TweenService:Create(script.Parent.Frame, TweenInfo_new_ret, {
        BackgroundTransparency = 0
    }):Play();
end;

GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function() -- Line: 26
    -- upvalues: UserInputService (copy), GuiService (copy)
    if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 or UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad2 then
        if GuiService.SelectedObject == nil then
            script.Parent.Visible = true;
            Fade(true);

            return;
        end;

        Fade(false);
    end;
end);
UserInputService.InputBegan:Connect(function(p2, p3) -- Line: 38
    -- upvalues: UserInputService (copy), TweenService (copy)
    if (UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 or UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad2) and script.Parent.Parent.Enabled then
        wait();

        if script.Parent.ImageTransparency == 0 then
            script.Parent.Position = UDim2.new(0.005, 0, 0.9, 0);
            TweenService:Create(script.Parent, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.02, 0, 0.9, 0)
            }):Play();
            script.Parent.Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            TweenService:Create(script.Parent.Frame, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            }):Play();
        end;
    end;
end);