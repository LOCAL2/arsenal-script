-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    ParticleEmitter = true,
    Beam = true,
    Trail = true
};

function v1.VM_INIT(p3, p4) -- Line: 4
    -- upvalues: u2 (copy)
    local v5, v6, v7 = p4:ToHSV();
    local ColorSequence_new_ret = ColorSequence.new(Color3.fromHSV(v5, v6 * 0.75, v7));

    for _, descendant in p3:GetDescendants() do
        if u2[descendant.ClassName] then
            descendant.Color = ColorSequence_new_ret;
        end;
    end;
end;

return v1;