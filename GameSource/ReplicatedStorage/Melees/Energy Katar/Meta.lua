-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local ColorSequence_new_ret = ColorSequence.new(p2);
        local v3, v4, v5 = p2:ToHSV();

        for _, child in p1["Inner Blade"].Emit:GetChildren() do
            child.Color = ColorSequence_new_ret;
        end;

        p1["Inner Blade"]["Main Bolts"].Color = ColorSequence_new_ret;
        p1["Inner Blade"]["Secondary Bolts"].Color = ColorSequence_new_ret;
        p1.Trail.Color = ColorSequence.new(Color3.fromHSV(v3, v4 * 0.6, v5));
    end,

    ANIM_KEYFRAME_REACHED = function(p6, p7) -- Line: 15, Name: ANIM_KEYFRAME_REACHED
        if p6:FindFirstChild("Inner Blade") and p6["Inner Blade"]:FindFirstChild("Emit") then
            local Children = p6["Inner Blade"].Emit:GetChildren();

            for i = 1, #Children do
                local v8;

                if Children[i]:IsA("ParticleEmitter") then
                    Children[i]:Emit(Children[i].Rate);
                    v8 = i;
                else
                    v8 = i;
                end;
            end;

            if p6["Inner Blade"]:FindFirstChild("Main Bolts") and p6["Inner Blade"]:FindFirstChild("Secondary Bolts") then
                p6["Inner Blade"]["Main Bolts"].Enabled = true;
                p6["Inner Blade"]["Secondary Bolts"].Enabled = true;
            end;

            p6["Inner Blade"].Transparency = 0;

            if p6:FindFirstChild("WhiteNeon") then
                p6.WhiteNeon.Transparency = 0.6;
            end;

            if p6:FindFirstChild("BladeOutline") then
                p6.BladeOutline.Transparency = 0;
            end;
        end;
    end
};