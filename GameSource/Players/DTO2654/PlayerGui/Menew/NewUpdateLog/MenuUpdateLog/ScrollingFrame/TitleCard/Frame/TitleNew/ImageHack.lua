-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local DropShadow = script.Parent.DropShadow;

repeat
    wait();
until script_Parent.IsLoaded and DropShadow.IsLoaded;

if script_Parent.AbsoluteSize.Y > 70 then
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.ImageTransparency = 0.99;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Parent = script.Parent;
    ImageLabel.Image = "rbxassetid://" .. 12986041104;

    repeat
        wait();
    until ImageLabel.IsLoaded;

    script_Parent.Image = "rbxassetid://" .. 12986041104;
    ImageLabel.Image = "rbxassetid://" .. 12986041671;

    repeat
        wait();
    until ImageLabel.IsLoaded;

    DropShadow.Image = "rbxassetid://" .. 12986041671;
    ImageLabel:Destroy();
end;