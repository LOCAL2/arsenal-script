-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local ColorSequence_new_ret = ColorSequence.new(p2);
        local ColorSequence_new_ret2 = ColorSequence.new(Color3.new(p2.r / 2, p2.g / 2, p2.b / 2));
        p1.Particles1.Attachment.AfterSmoke2.Color = ColorSequence_new_ret2;
        p1.Particles1.Attachment.Muzzle1.Color = ColorSequence_new_ret;
        p1.Particles1.Attachment.Specks.Color = ColorSequence_new_ret;
        p1.Particles1.Attachment.Wave.Color = ColorSequence_new_ret;
        p1.Particles2.Attachment.AfterSmoke2.Color = ColorSequence_new_ret2;
        p1.Particles2.Attachment.Muzzle1.Color = ColorSequence_new_ret;
        p1.Particles2.Attachment.Specks.Color = ColorSequence_new_ret;
        p1.Particles2.Attachment.Wave.Color = ColorSequence_new_ret;
        p1.Particles3.Attachment.Beam.Color = ColorSequence_new_ret;
        p1.Particles3.Attachment.Beam.Color = ColorSequence_new_ret;
    end
};