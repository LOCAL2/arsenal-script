-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local v3, v4, v5 = p2:ToHSV();
        p1.TeamColor.Sparkles.Color = ColorSequence.new(Color3.fromHSV(v3, v4 * 0.55, v5));
    end
};