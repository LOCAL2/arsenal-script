-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1: any, p2) -- Line: 3, Name: VM_INIT
        local v3, v4, v5 = p2:ToHSV();
        local Color3_fromHSV_ret = Color3.fromHSV(v3, v4 * 0.55, v5);
        p1.TeamColor1.Color = Color3_fromHSV_ret;
        p1.TeamColor2.Color = Color3_fromHSV_ret;
        p1.TeamColor3.Color = Color3_fromHSV_ret;
        p1.TeamColor4.Color = Color3_fromHSV_ret;
        p1.TeamColor5.Color = Color3_fromHSV_ret;
        p1.core.Color = Color3_fromHSV_ret;
        p1["ice sphere"].Color = Color3_fromHSV_ret;
        local ColorSequence_new_ret = ColorSequence.new(p2);

        for _, child in p1["ice sphere"].Attachment:GetChildren() do
            child.Color = ColorSequence_new_ret;
        end;

        for _, child in p1["ice sphere"].Flash:GetChildren() do
            child.Color = ColorSequence_new_ret;
        end;
    end
};