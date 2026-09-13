-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};
local u3 = tick();
local u4 = false;
local u5 = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q,", "r", "s", "t", "u", "v", "w", "x", "y", "z" };

local function calcAverage(p6) -- Line: 38
    local v7 = 0;

    for _, v in pairs(p6) do
        v7 = v7 + v;
    end;

    return v7 / #p6;
end;

local function grabFPS() -- Line: 48
    -- upvalues: u3 (ref), u2 (copy)
    local v8 = 1 / (tick() - u3);
    u3 = tick();
    table.insert(u2, v8);

    if #u2 < 60 then
        return v8;
    end;

    table.remove(u2, 1);
    local v9 = u2;
    local v10 = 0;

    for _, v in pairs(v9) do
        v10 = v10 + v;
    end;

    return v10 / #v9;
end;

RunService.RenderStepped:connect(function() -- Line: 63
    -- upvalues: u1 (copy), u3 (ref), u2 (copy), u4 (ref), LocalPlayer (copy)
    local v11 = gcinfo("count");
    table.insert(u1, v11);
    local v12 = 1 / (tick() - u3);
    u3 = tick();
    table.insert(u2, v12);

    if #u2 >= 60 then
        table.remove(u2, 1);
        local v13 = u2;
        local v14 = 0;

        for _, v in pairs(v13) do
            v14 = v14 + v;
        end;

        v12 = v14 / #v13;
    end;

    if v12 <= #u1 then
        table.remove(u1, 1);
        local v15 = u1;
        local v16 = 0;

        for _, v in pairs(v15) do
            v16 = v16 + v;
        end;

        if v16 / #v15 + 205 <= v11 and not u4 then
            u4 = true;
            LocalPlayer:Kick("\n🤡🤡🤡");
        end;
    end;
end);
(function() -- Line: 17, Name: generateName
    -- upvalues: u5 (copy)
    local v17 = "";

    for i = 1, math.random(11, 27) do
        local v18;

        if math.random(1, 2) == 1 then
            local v19 = u5[math.random(1, #u5)];

            if math.random(1, 2) == 1 then
                v19 = v19:upper();
            end;

            v17 = v17 .. v19;
            v18 = i;
        else
            v17 = v17 .. math.random(0, 9);
            v18 = i;
        end;
    end;

    script.Name = v17;
end)();