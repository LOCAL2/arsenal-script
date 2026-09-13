-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local v3, v4, v5 = p2:ToHSV();
        local Color3_fromHSV_ret = Color3.fromHSV(v3, v4 * 0.55, v5);
        p1.Shell.ShellColor.Color = Color3_fromHSV_ret;
        p1["Shell 2"].ShellColor.Color = Color3_fromHSV_ret;
        p1["Shell 3"].ShellColor.Color = Color3_fromHSV_ret;
        p1["Shell 4"].ShellColor.Color = Color3_fromHSV_ret;

        for _, descendant in p1:GetDescendants() do
            if descendant:IsA("BasePart") and (descendant.Name ~= "Sight" and (descendant.Name ~= "Dot" and (descendant.Name ~= "ShellColor" and descendant.Material == Enum.Material.Neon))) then
                descendant.Color = p1.TeamColor.Color;
            end;
        end;
    end
};