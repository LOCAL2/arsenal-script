-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("UserInputService");

function spawnflake()
    -- upvalues: CollectionService (copy)
    local v1 = script.ImageLabel:Clone();
    v1.Name = "Flake";
    CollectionService:AddTag(v1, "Snowflake");
    v1.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.04, -58);
    v1.Parent = script.Parent;
    v1:TweenPosition(UDim2.new(v1.Position.X.Scale, 0, 1.01, 0), nil, "Linear", 12.5);
end;

local u2 = 0;
local Size = script.Parent.Holiday.SnowyGuyTheGuy.Size;
local Position = script.Parent.Holiday.SnowyGuyTheGuy.Position;

if script.Parent:FindFirstChild("Holiday") then
    script.Parent.Holiday.SnowyGuy.MouseButton1Click:Connect(function() -- Line: 20
        -- upvalues: u2 (ref), Size (copy), Position (copy)
        u2 = u2 + 48;
        script.Parent.Holiday.SnowyGuyTheGuy.Size = UDim2.new(Size.X.Scale, -3, Size.Y.Scale, -3);
        script.Parent.Holiday.SnowyGuyTheGuy.Position = UDim2.new(Position.X.Scale, 1, Position.Y.Scale, 3);
        wait();
        script.Parent.Holiday.SnowyGuyTheGuy.Size = Size;
        script.Parent.Holiday.SnowyGuyTheGuy.Position = Position;
        script.wow2:Play();
    end);
end;

while wait() do
    if script.Parent.Visible then
        u2 = u2 + 1;
    end;

    if u2 >= 32 and script.Parent.Visible then
        while u2 >= 32 do
            spawnflake();
            u2 = u2 - 32;

            if u2 < 32 then
                break;
            end;
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("Snowflake")) do
        if v:IsA("ImageLabel") then
            v.Rotation = v.Rotation + 2;

            if v.Position.Y.Scale >= 1 then
                v:Destroy();
            end;
        end;
    end;
end;