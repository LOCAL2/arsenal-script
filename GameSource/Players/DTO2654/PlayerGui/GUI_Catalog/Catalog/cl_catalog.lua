-- Decompiled with Potassium's decompiler.

local Children = game.ReplicatedStorage.Weapons:GetChildren();
local KillIcons = game.ReplicatedStorage.KillIcons;
local script_Parent = script.Parent;
local List = script_Parent.List;
local Body = script_Parent.Body;
local Items = Body.Info.Items;
local UIListLayout = List.UIListLayout;

if game.ReplicatedStorage.wkspc.gametype.Value ~= "Shooting Range" then
    repeat
        task.wait(1);
    until game.ReplicatedStorage.wkspc.gametype.Value == "Shooting Range";
end;

if game.ReplicatedStorage.Weapons:GetAttribute("ShootingRangeSet") ~= true then
    repeat
        task.wait(1);
    until game.ReplicatedStorage.Weapons:GetAttribute("ShootingRangeSet") == true;
end;

for i = 1, #Children do
    local v1;

    if Children[i]:GetAttribute("ShootingRangeSafe") == true then
        local u2 = script.ItemTemp:clone();
        u2.Name = Children[i].Name;
        u2.TextLabel.Text = u2.Name;
        u2.Image = KillIcons[u2.Name].Value;
        u2.Parent = List;
        u2.Visible = true;
        u2.MouseButton1Down:connect(function() -- Line: 27
            -- upvalues: u2 (copy)
            updateinfo(game.ReplicatedStorage.Weapons[u2.Name]);
        end);
        v1 = i;
    else
        v1 = i;
    end;
end;

function updatelistl()
    -- upvalues: List (copy), UIListLayout (copy)
    List.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y);
end;

function decimaltime(p3)
    return math.ceil(p3 * 1000) / 1000;
end;

local Children2 = Items:GetChildren();

for i = 1, #Children2 do
    local v4;

    if Children2[i]:IsA("ImageLabel") and Children2[i].Visible == true then
        local Folder = Instance.new("Folder");
        Folder.Name = "AlwaysVisible";
        Folder.Parent = Children2[i];
        v4 = i;
    else
        v4 = i;
    end;
end;

function updateinfo(p5)
    -- upvalues: Body (copy), Items (copy)
    if Body.Main.Title.Text == p5.Name then
        game.ReplicatedStorage.NewEvents.ShootingRange:FireServer({ "equipgun", p5.Name });
        script.Parent.Visible = false;
        script.Parent.Parent.Enabled = false;

        return;
    end;

    Body.Main.Title.Text = p5.Name;
    Body.DamageGraph.cl_graph.sup:Fire(p5);
    local math_min_ret = math.min(p5.Falloff.Value, p5.Rampup.Value);
    local math_max_ret = math.max(p5.Falloff.Value, p5.Rampup.Value);
    local v6 = p5:FindFirstChild("Projectile") and 1 or math.max(1, p5.Bullets.Value);
    local v7 = p5.DMG.Value * math_min_ret;
    local v8 = p5.DMG.Value * math_max_ret * v6;
    local Value = p5.DMG.Value;
    Items.BaseDamage.textlb.Text = math.floor(v7);

    if v8 ~= v7 then
        Items.BaseDamage.textlb.Text = Items.BaseDamage.textlb.Text .. "-" .. math.floor(v8);
    end;

    Items.Equip.textlb.Text = decimaltime(p5.EquipTime.Value);
    Items.FireRate.textlb.Text = decimaltime(p5.FireRate.Value);
    local v9 = 22.400000000000002;

    if p5:FindFirstChild("Speed%") then
        v9 = v9 * ((100 - p5["Speed%"].Value) / 100);
    end;

    Items.Walkspeed.textlb.Text = decimaltime(v9);
    local Children3 = Items:GetChildren();

    for i = 1, #Children3 do
        local v10;

        if Children3[i]:IsA("ImageLabel") and Children3[i]:FindFirstChild("AlwaysVisible") == nil then
            Children3[i].Visible = false;
            v10 = i;
        else
            v10 = i;
        end;
    end;

    if p5:FindFirstChild("FM") == nil and (p5:FindFirstChild("Projectile") == nil and p5:FindFirstChild("Melee") == nil) or p5:FindFirstChild("Projectile") and p5.Projectile:FindFirstChild("Arrow") then
        local v11 = p5:FindFirstChild("Crit") and 3 or 1.25;
        Items.CriticalDamage.textlb.Text = math.floor(Value * v11);

        if Value ~= v8 then
            Items.CriticalDamage.textlb.Text = Items.CriticalDamage.textlb.Text .. "-" .. math.floor(v8 * v11);
        end;

        Items.CriticalDamage.Visible = true;
    end;

    if p5:FindFirstChild("Melee") == nil then
        Items.Ammo.Visible = true;

        if p5:FindFirstChild("Infinite") then
            Items.Ammo.textlb.Text = "inf";
        else
            Items.Ammo.textlb.Text = p5.Ammo.Value;

            if p5.StoredAmmo.Value > 0 then
                Items.Ammo.textlb.Text = Items.Ammo.textlb.Text .. "/" .. p5.StoredAmmo.Value;
            end;
        end;

        if p5:FindFirstChild("PumpAction") then
            Items.MaxReload.textlb.Text = decimaltime(p5.SReload.Value + p5.Bullets.Value * (p5.ReloadTime.Value + p5.AReload.Value));
            Items.MaxReload.Visible = true;
        else
            Items.Reload.textlb.Text = decimaltime(p5.ReloadTime.Value);
            Items.Reload.Visible = true;
        end;

        if p5:FindFirstChild("Projectile") then
            if p5:FindFirstChild("BulletSpeed") == nil then
                Items.ProjectileSpeed.textlb.Text = p5.Speed.Value * 0.07;
                Items.ProjectileSpeed.Visible = true;
            end;

            local Projectile = p5.Projectile;

            if Projectile:FindFirstChild("Rocket") or Projectile:FindFirstChild("Grenade") then
                Items.BlastRadius.textlb.Text = p5.BlastRadius.Value * 0.07;
                Items.BlastRadius.Visible = true;
            end;
        elseif p5:FindFirstChild("FM") == nil then
            local textlb = Items.Spread.textlb;
            local v12 = decimaltime;
            local math_rad_ret = math.rad(p5.Spread.Value / 10);
            textlb.Text = v12(math.tan(math_rad_ret) * 50);
            Items.Spread.Visible = true;

            if p5:FindFirstChild("MaxSpread") then
                local textlb2 = Items.MaxSpread.textlb;
                local v13 = decimaltime;
                local math_rad_ret2 = math.rad(p5.MaxSpread.Value / 10);
                textlb2.Text = v13(math.tan(math_rad_ret2) * 50);
                Items.MaxSpread.Visible = true;
                Items.SpreadRecovery.textlb.Text = decimaltime(p5.SpreadRecovery.Value);
                Items.SpreadRecovery.Visible = true;
            end;
        end;
    end;

    Body.Visible = true;
end;

updatelistl();
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() -- Line: 156
    wait();
    updatelistl();
end);