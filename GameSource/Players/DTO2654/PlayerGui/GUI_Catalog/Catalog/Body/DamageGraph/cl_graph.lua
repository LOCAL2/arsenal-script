-- Decompiled with Potassium's decompiler.

local u1 = false;
local Mouse = game.Players.LocalPlayer:GetMouse();
script.Parent.BOutline.MouseButton1Down:connect(function() -- Line: 4
    -- upvalues: u1 (ref)
    u1 = true;
end);
Mouse.Button1Up:connect(function() -- Line: 7
    -- upvalues: u1 (ref)
    u1 = false;
end);
script.Parent.BOutline.MouseButton1Up:connect(function() -- Line: 10
    -- upvalues: u1 (ref)
    u1 = false;
end);
local u2 = nil;
local Points = script.Parent.Graph.Points;

function round(p3)
    local v4 = p3 - math.floor(p3);

    if v4 > 0.5 then
        return math.ceil(p3);
    end;

    if v4 < 0.5 then
        return math.floor(p3);
    end;

    return p3;
end;

local u5 = nil;
local u6 = 0;
local u7 = 0;
local u8 = 0;
game:GetService("RunService").Heartbeat:connect(function() -- Line: 36
    -- upvalues: u1 (ref), Mouse (copy), Points (copy), u6 (ref), u8 (ref), u5 (ref), u7 (ref)
    if script.Parent.Visible then
        if u1 == true and (Mouse.X >= Points.AbsolutePosition.X - 25 and (Mouse.X <= Points.AbsolutePosition.X + Points.AbsoluteSize.X + 25 and (Mouse.Y >= Points.AbsolutePosition.Y - 25 and Mouse.Y <= Points.AbsolutePosition.Y + Points.AbsoluteSize.Y + 25))) then
            u6 = math.clamp((Mouse.X - Points.AbsolutePosition.X) / Points.AbsoluteSize.X, 0, 1);
        end;

        if u6 >= 0 then
            u8 = round(u6 * 400);
        end;

        local v9 = u8;

        if Points:FindFirstChild("Point" .. v9) and Points["Point" .. v9]:FindFirstChild("D") then
            if u5 then
                u5.Size = UDim2.new(0.01, 0, 0.01, 0);
            end;

            u5 = Points["Point" .. v9];
            u5.Size = UDim2.new(0.05, 0, 0.05, 0);
            u7 = Points["Point" .. v9].D.Value;
        end;

        if u5 then
            Points.Parent.Cursor.Position = UDim2.new(u5.Position.X.Scale, 0, u5.Position.Y.Scale, 0);
        end;

        Points.Parent.Cursor.TextLabel.Text = "(" .. v9 .. "," .. u7 .. ")";
    end;
end);
local Dropdown = script.Parent.Tabs.Dropdown;

function updatelist()
    -- upvalues: Dropdown (copy)
    if Dropdown.List.Visible == true then
        Dropdown.Triangle.Rotation = 0;

        return;
    end;

    Dropdown.Triangle.Rotation = 180;
end;

conn8 = Dropdown.CLICKBOX.MouseButton1Down:connect(function() -- Line: 70
    -- upvalues: Dropdown (copy)
    Dropdown.List.Visible = not Dropdown.List.Visible;
    updatelist();
end);

function generategraph()
    -- upvalues: Dropdown (copy), u2 (ref)
    local Text = Dropdown.TextLabel.Text;
    local v10 = u2;
    local Dropdown2 = script.Parent.Tabs.Dropdown;
    Dropdown2.TextLabel.Text = Text;
    local Children = Dropdown2.List.Items:GetChildren();

    for i = 1, #Children do
        local v11;

        if Children[i]:IsA("TextButton") then
            if Children[i].Text == Text then
                Children[i].TextColor3 = Color3.new(1, 1, 1);
                Children[i].SelectedImg.Visible = true;
                v11 = i;
            else
                Children[i].TextColor3 = Color3.new(0, 0, 0);
                Children[i].SelectedImg.Visible = false;
                v11 = i;
            end;
        else
            v11 = i;
        end;
    end;

    local string_lower_ret = string.lower(Text);
    local v12 = false;
    local v13 = false;
    local v14;

    if (u2:FindFirstChild("FM") == nil and (u2:FindFirstChild("Projectile") == nil and u2:FindFirstChild("Melee") == nil) or u2:FindFirstChild("Projectile") and u2.Projectile:FindFirstChild("Arrow")) and string_lower_ret == "critical damage" then
        if v10:FindFirstChild("Crit") then
            v12 = true;
            v14 = 3;
        else
            v13 = true;
            v14 = 1.25;
        end;
    else
        v14 = 1;
    end;

    local Value = v10.DMG.Value;
    local v15 = v10:FindFirstChild("Projectile") and 1 or math.max(v10.Bullets.Value, 1);
    local Points2 = script.Parent.Graph.Points;
    Points2:ClearAllChildren();

    for i = 0, 400, 0.5 do
        local v16 = Value * (game.ReplicatedStorage.Events.DamageEquation:Invoke(v10, i, v13, v12) * v14);
        local v17 = script.Point:clone();
        v17.Parent = Points2;
        v17.Name = "Point" .. i;
        v17.Position = UDim2.new(i / 400, 0, math.clamp(1 - v16 / 100, 0, 1), 0);
        v17.Visible = true;
        local StringValue = Instance.new("StringValue");
        StringValue.Name = "D";
        StringValue.Parent = v17;
        StringValue.Value = math.floor(v16 * 10) / 10;
        local v18;

        if v15 > 1 then
            StringValue.Value = StringValue.Value .. "x" .. v15;
            v18 = i;
        else
            v18 = i;
        end;
    end;
end;

local Children = Dropdown.List.Items:GetChildren();

for i = 1, #Children do
    local v19;

    if Children[i]:IsA("TextButton") then
        Children[i].MouseButton1Down:connect(function() -- Line: 135
            -- upvalues: Dropdown (copy), Children (copy), i (copy)
            Dropdown.List.Visible = false;
            Dropdown.TextLabel.Text = Children[i].Text;
            updatelist();
            generategraph();
        end);
        v19 = i;
    else
        v19 = i;
    end;
end;

script.sup.Event:Connect(function(p20) -- Line: 144
    -- upvalues: u2 (ref)
    u2 = p20;
    generategraph();
end);