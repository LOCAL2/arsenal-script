-- Decompiled with Potassium's decompiler.

local ImageLabel = script.Parent:WaitForChild("ImageLabel");
local u1 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(), {
    ImageTransparency = 0
});
local u2 = game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(), {
    ImageTransparency = 1
});
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("SecretPresent").OnClientEvent:connect(function(p3) -- Line: 6
    -- upvalues: ImageLabel (copy), u1 (copy), u2 (copy)
    local Image = ImageLabel.Image;

    if p3 then
        ImageLabel.Image = p3;
    end;

    u1:Play();
    wait(3);
    u2:Play();
    wait(1);
    ImageLabel.Image = Image;
end);