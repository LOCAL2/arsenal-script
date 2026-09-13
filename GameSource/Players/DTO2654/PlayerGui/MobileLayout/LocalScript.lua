-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local Children = script.Parent.Tablet:GetChildren();
local u1 = {};
local u2 = {};

local function update(p3, p4) -- Line: 23
    -- upvalues: u1 (copy), Children (copy), u2 (copy)
    local v5 = p3.Position - u1[p4];
    Children[p4].Position = UDim2.new(u2[p4].X.Scale, u2[p4].X.Offset + v5.X, u2[p4].Y.Scale, u2[p4].Y.Offset + v5.Y);
end;

local u6 = {};
local u7 = nil;
local u8 = { 0.04, 0.07, 0.1 };
local u9 = { 0.1, 0.125, 0.15 };
local u10 = { 0.2, 0.25, 0.3 };
local u11 = nil;
local u12 = {};

for i = 1, #Children do
    Children[i].MouseButton1Down:Connect(function() -- Line: 31
        -- upvalues: u7 (ref)
        u7 = tick();
    end);
    Children[i].MouseButton1Up:connect(function() -- Line: 34
        -- upvalues: u7 (ref), Children (copy), i (copy), u8 (copy), u9 (copy), u10 (copy)
        if u7 and tick() - u7 <= 0.2 then
            local v13;

            if Children[i]:FindFirstChild("XX") then
                v13 = u8;
            elseif Children[i]:FindFirstChild("YY") then
                v13 = u9;
            else
                v13 = u10;
            end;

            Children[i].Zoom.Value = Children[i].Zoom.Value >= 3 and 1 or Children[i].Zoom.Value + 1;
            Children[i].Size = UDim2.new(v13[Children[i].Zoom.Value], 0, v13[Children[i].Zoom.Value], 0);
        end;
    end);
    Children[i].InputBegan:Connect(function(u14) -- Line: 48
        -- upvalues: u11 (ref), u12 (copy), i (copy), u1 (copy), u2 (copy), Children (copy)
        if u11 == nil and (u14.UserInputType == Enum.UserInputType.MouseButton1 or u14.UserInputType == Enum.UserInputType.Touch) then
            u12[i] = true;
            u1[i] = u14.Position;
            u2[i] = Children[i].Position;
            u11 = Children[i];
            u14.Changed:Connect(function() -- Line: 54
                -- upvalues: u14 (copy), u12 (ref), i (ref), u11 (ref)
                if u14.UserInputState == Enum.UserInputState.End then
                    u12[i] = false;
                    u11 = nil;
                end;
            end);
        end;
    end);
    Children[i].InputChanged:Connect(function(p15) -- Line: 62
        -- upvalues: u6 (copy), i (copy)
        if p15.UserInputType == Enum.UserInputType.MouseMovement or p15.UserInputType == Enum.UserInputType.Touch then
            u6[i] = p15;
        end;
    end);
    local _ = i;
end;

UserInputService.InputChanged:Connect(function(p16) -- Line: 72
    -- upvalues: Children (copy), u6 (copy), u12 (copy), u1 (copy), u2 (copy)
    for i = 1, #Children do
        local v17;

        if p16 == u6[i] and u12[i] == true then
            local v18 = p16.Position - u1[i];
            Children[i].Position = UDim2.new(u2[i].X.Scale, u2[i].X.Offset + v18.X, u2[i].Y.Scale, u2[i].Y.Offset + v18.Y);
            v17 = i;
        else
            v17 = i;
        end;
    end;
end);
script.Parent.Finished.Activated:Connect(function() -- Line: 80
    if script.Parent.Done.Visible == true then
        script.Parent.Done.Visible = false;
        script.Parent.Finished.ImageLabel.TextLabel.Text = "Options";

        return;
    end;

    script.Parent.Done.Visible = true;
    script.Parent.Finished.ImageLabel.TextLabel.Text = "Close Menu";
end);
script.Parent.Done.Save.Activated:Connect(function() -- Line: 90
    script.Parent.Done.Visible = false;
    script.Parent.Save.Visible = true;
    local v19 = {};

    for _, child in pairs(script.Parent.Tablet:GetChildren()) do
        v19[child.Name] = { child.Zoom.Value, child.Position.X.Offset, child.Position.Y.Offset };
    end;

    game.ReplicatedStorage.Functions.SaveLayout:InvokeServer(v19);
    script.Parent.Save.Visible = false;
    script.Parent.Enabled = false;
    script.Parent.Parent.Menew.Enabled = true;
    script.Parent.Parent.Menew_Main.Enabled = true;
end);
script.Parent.Done.Cancel.Activated:Connect(function() -- Line: 110
    script.Parent.Enabled = false;
    script.Parent.Done.Visible = false;
    script.Parent.Parent.Menew.Enabled = true;
end);
script.Parent.Done.Reset.Activated:Connect(function() -- Line: 117
    for _, child in pairs(script.Parent.Default:GetChildren()) do
        script.Parent.Tablet[tostring(child)].Size = child.Size;
        script.Parent.Tablet[tostring(child)].Position = child.Position;
        script.Parent.Tablet[tostring(child)].Zoom.Value = child.Zoom.Value;
    end;
end);