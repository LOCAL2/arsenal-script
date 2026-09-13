-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local v3, v4, v5 = p2:ToHSV();
        local Color3_fromHSV_ret = Color3.fromHSV(v3, v4 * 0.55, v5);
        p1.SpeedLoader.Bullet1.Color = Color3_fromHSV_ret;
        p1.SpeedLoader.Bullet2.Color = Color3_fromHSV_ret;
        p1.SpeedLoader.Bullet3.Color = Color3_fromHSV_ret;
        p1.SpeedLoader.Bullet4.Color = Color3_fromHSV_ret;
        p1.SpeedLoader.Bullet5.Color = Color3_fromHSV_ret;
        p1.SpeedLoader.Bullet6.Color = Color3_fromHSV_ret;
    end
};