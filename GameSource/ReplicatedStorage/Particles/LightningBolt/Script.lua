-- Decompiled with Potassium's decompiler.

local Value = script.bruh.Value;
local Position = game.Workspace.startpos.Position;
local Position2 = game.Workspace.endpos.Position;
local magnitude = (Position2 - Position).magnitude;
local p = Value.CFrame.p;
local u1 = p;
local lookVector = Value.CFrame.lookVector;
local RunService = game:GetService("RunService");
local Vector3_new_ret = Vector3.new();
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In);

function bn()
    return 1 - math.random() * 2;
end;

function Lerp(p2, p3, p4)
    return p2 + (p3 - p2) * p4;
end;

function SUP()
    -- upvalues: Position (ref), Position2 (ref), magnitude (ref), Value (copy), lookVector (ref), p (ref), u1 (ref), Vector3_new_ret (ref), RunService (copy), TweenService (copy), TweenInfo_new_ret (copy)
    Position = game.Workspace.startpos.Position;
    Position2 = game.Workspace.endpos.Position;
    magnitude = (Position2 - Position).magnitude;
    Value.Trail:Clear();
    Value.Trail2:Clear();
    Value.CFrame = CFrame.new(Position, Position2);
    lookVector = (Position2 - Position).unit;
    p = Value.CFrame.p;
    u1 = p;
    local v5 = tick();
    local v6 = (Position + Position2) / 2;
    Vector3_new_ret = Vector3.new();

    while true do
        repeat
            RunService.Heartbeat:wait();
        until tick() - v5 >= 0.016666666666666666;

        v5 = tick();
        local magnitude2 = (u1 - Position).magnitude;
        local math_clamp_ret = math.clamp((magnitude - magnitude2) / 2.9166666666666665, 0, 1);
        local v7 = magnitude <= 0 and 0 or (1 - (u1 - v6).magnitude * 2 / magnitude) ^ 0.5;
        u1 = u1 + lookVector * 175 * 0.016666666666666666 * math_clamp_ret;
        local v8 = 6 * bn();
        local v9 = 6 * bn();
        local v10 = 6 * bn();
        local v11 = (v8 ^ 2 + v9 ^ 2 + v10 ^ 2) ^ 0.5;
        local v12 = v11 <= 0 and 0 or 6 / v11;
        Vector3_new_ret = v7 * Lerp(Vector3_new_ret, v7 * Vector3.new(v8 * v12, v9 * v12, v10 * v12), 0.25);
        TweenService:Create(Value, TweenInfo_new_ret, {
            CFrame = CFrame.new(u1 + Vector3_new_ret)
        }):Play();

        if magnitude <= magnitude2 then
            wait(1.4);
            coroutine.resume(coroutine.create(function() -- Line: 67
                SUP();
            end));

            return;
        end;
    end;
end;

wait(0.2);
SUP();