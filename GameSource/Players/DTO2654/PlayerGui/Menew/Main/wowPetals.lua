-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
game:GetService("UserInputService");
local u1 = 0;
local u2 = false;

function spawnflake()
    -- upvalues: CollectionService (copy), u1 (ref), u2 (ref)
    local v3 = script.ImageLabel:Clone();
    v3.Name = "Flake";
    CollectionService:AddTag(v3, "Snowflake");
    v3.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.04, -16);
    v3.Parent = script.Parent;
    v3:TweenPosition(UDim2.new(v3.Position.X.Scale, 0, 1.01, 0), nil, "Linear", 12.5);
    u1 = u1 + 1;

    if u1 >= 40 and not u2 then
        u2 = true;
        game.ReplicatedStorage.Events.FREEBADGE:FireServer("67kidCyrptoKidRugpulllolol");
    end;
end;

local u4 = 0;
local Size = script.Parent.Holiday.SnowyGuyTheGuy.Size;
local Position = script.Parent.Holiday.SnowyGuyTheGuy.Position;

if script.Parent:FindFirstChild("Holiday") then
    script.Parent.Holiday.SnowyGuy.MouseButton1Click:Connect(function() -- Line: 32
        -- upvalues: u4 (ref), Size (copy), Position (copy)
        u4 = u4 + 48;
        script.Parent.Holiday.SnowyGuyTheGuy.Size = UDim2.new(Size.X.Scale, -3, Size.Y.Scale, -3);
        script.Parent.Holiday.SnowyGuyTheGuy.Position = UDim2.new(Position.X.Scale, 1, Position.Y.Scale, 3);
        wait();
        script.Parent.Holiday.SnowyGuyTheGuy.Size = Size;
        script.Parent.Holiday.SnowyGuyTheGuy.Position = Position;
        script.wow2:Play();
    end);
end;

while task.wait() do
    if script.Parent.Visible then
        u4 = u4 + 1;
    end;

    if u4 >= 32 and script.Parent.Visible then
        while u4 >= 32 do
            spawnflake();
            u4 = u4 - 32;

            if u4 < 32 then
                break;
            end;
        end;
    end;

    for _, v in pairs(CollectionService:GetTagged("Snowflake")) do
        if v:IsA("ImageLabel") then
            v.Rotation = v.Rotation + 2;

            if v.Position.Y.Scale >= 1 then
                v:Destroy();
                u1 = u1 - 1;
            end;
        end;
    end;
end;