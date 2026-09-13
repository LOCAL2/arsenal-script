-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local ColorSequence_new_ret = ColorSequence.new(p2);

        for _, child in p1["Inner Blade"].Emit:GetChildren() do
            child.Color = ColorSequence_new_ret;
        end;
    end,

    ANIM_KEYFRAME_REACHED = function(p3, p4) -- Line: 10, Name: ANIM_KEYFRAME_REACHED
        if p3:FindFirstChild("Inner Blade") and p3["Inner Blade"]:FindFirstChild("Emit") then
            local Children = p3["Inner Blade"].Emit:GetChildren();

            for i = 1, #Children do
                local v5;

                if Children[i]:IsA("ParticleEmitter") then
                    Children[i]:Emit(Children[i].Rate);
                    v5 = i;
                else
                    v5 = i;
                end;
            end;

            if p3["Inner Blade"]:FindFirstChild("Main Bolts") and p3["Inner Blade"]:FindFirstChild("Secondary Bolts") then
                p3["Inner Blade"]["Main Bolts"].Enabled = true;
                p3["Inner Blade"]["Secondary Bolts"].Enabled = true;
            end;

            p3["Inner Blade"].Transparency = 0;

            if p3:FindFirstChild("WhiteNeon") then
                p3.WhiteNeon.Transparency = 0.6;
            end;

            if p3:FindFirstChild("BladeOutline") then
                p3.BladeOutline.Transparency = 0;
            end;
        end;
    end
};