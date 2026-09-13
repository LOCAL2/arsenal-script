-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local v3, v4, v5 = p2:ToHSV();
        p1.Chamber.Color = Color3.fromHSV(v3, v4 * 0.55, v5);
        p1:WaitForChild("Mag"):WaitForChild("Ammo"):WaitForChild("Bullet");
        p1.Mag.Ammo.Bullet.Color = p1.Chamber.Color;

        for i = 2, 12 do
            p1.Mag.Ammo["Bullet " .. i].Color = p1.Chamber.Color;
            local _ = i;
        end;
    end
};