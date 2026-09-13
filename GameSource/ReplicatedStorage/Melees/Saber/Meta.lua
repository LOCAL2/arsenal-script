-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");
local u2 = {
    ParticleEmitter = true,
    Beam = true
};
local TweenInfo_new_ret = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In);

local function pos(p3, p4, p5) -- Line: 8
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if p5 then
        TweenService:Create(p3, TweenInfo_new_ret, {
            Position = p4
        }):Play();

        return;
    end;

    p3.Position = p4;
end;

function v1.POST_EQUIP(p6) -- Line: 16
    -- upvalues: u2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    task.wait(0.4);
    local Arms = workspace.CurrentCamera:FindFirstChild("Arms");

    if Arms == nil or Arms ~= p6 then
        return;
    end;

    local lightsaber = p6.Handle.lightsaber;
    local blade = lightsaber.blade;
    local _ = blade.a;
    local b = blade.b;
    local c = blade.c;
    local d = blade.d;
    local blade_small_L = lightsaber.blade_small_L;
    local _ = blade_small_L.a;
    local b2 = blade_small_L.b;
    local c2 = blade_small_L.c;
    local d2 = blade_small_L.d;
    local blade_small_R = lightsaber.blade_small_R;
    local _ = blade_small_R.a;
    local b3 = blade_small_R.b;
    local c3 = blade_small_R.c;
    local d3 = blade_small_R.d;
    local v7 = p6:GetAttribute("Scale") or 1;

    for _, descendant in lightsaber:GetDescendants() do
        if u2[descendant.ClassName] then
            descendant.Enabled = true;
        end;
    end;

    TweenService:Create(b, TweenInfo_new_ret, {
        Position = Vector3.new(0, 1.997, 0) * v7
    }):Play();
    TweenService:Create(c, TweenInfo_new_ret, {
        Position = Vector3.new(0, 1.996, 0) * v7
    }):Play();
    TweenService:Create(d, TweenInfo_new_ret, {
        Position = Vector3.new(0, 2.467, 0) * v7
    }):Play();
    TweenService:Create(b2, TweenInfo_new_ret, {
        Position = Vector3.new(0, -0.099, 0) * v7
    }):Play();
    TweenService:Create(c2, TweenInfo_new_ret, {
        Position = Vector3.new(0, -0.099, 0) * v7
    }):Play();
    TweenService:Create(d2, TweenInfo_new_ret, {
        Position = Vector3.new(0, 0.287, 0) * v7
    }):Play();
    TweenService:Create(b3, TweenInfo_new_ret, {
        Position = Vector3.new(0, -0.099, 0) * v7
    }):Play();
    TweenService:Create(c3, TweenInfo_new_ret, {
        Position = Vector3.new(0, -0.099, 0) * v7
    }):Play();
    TweenService:Create(d3, TweenInfo_new_ret, {
        Position = Vector3.new(0, 0.287, 0) * v7
    }):Play();
end;

return v1;