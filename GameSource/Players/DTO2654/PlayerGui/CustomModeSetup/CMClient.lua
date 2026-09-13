-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local CustomModeSetup = game.ReplicatedStorage.Events.CustomModeSetup;
local u1 = {
    forceTeams = false,
    timerLength = 180,
    useTimer = false,
    goldenGun = true,
    goldenKnife = true,
    randomPool = true,
    pools = { {}, {}, {}, {} },
    teams = {
        TRC = {
            canJoin = true,
            maxSize = 16,
            pool = 1,
            speed = 1,
            health = 100,
            regen = 20,
            gravity = 55.52,
            regenenabled = true,
            poolenabled = true,
            gravityenabled = true
        },
        TBC = {
            canJoin = true,
            maxSize = 16,
            pool = 1,
            speed = 1,
            health = 100,
            regen = 20,
            gravity = 55.52,
            regenenabled = true,
            poolenabled = true,
            gravityenabled = true
        },
        TGC = {
            canJoin = false,
            maxSize = 16,
            pool = 1,
            speed = 1,
            health = 100,
            regen = 20,
            gravity = 55.52,
            regenenabled = true,
            poolenabled = true,
            gravityenabled = true
        },
        TYC = {
            canJoin = false,
            maxSize = 16,
            pool = 1,
            speed = 1,
            health = 100,
            regen = 20,
            gravity = 55.52,
            regenenabled = true,
            poolenabled = true,
            gravityenabled = true
        }
    }
};
local u2 = {
    goldenKnife = "GoldKnife",
    goldenGun = "GoldGun",
    useTimer = "Timer",
    randomPool = "Shuffle"
};

local function deepCopy(p3) -- Line: 93
    -- upvalues: deepCopy (copy)
    if type(p3) ~= "table" then
        return p3;
    end;

    local v4 = {};

    for i, v in pairs(p3) do
        v4[i] = deepCopy(v);
    end;

    return v4;
end;

local u5 = deepCopy(u1);
local u6 = "TRC";
local u7 = 1;
local Main = script_Parent.Main;
local TeamRules = Main.TeamRules;
local u8 = Main.WeaponPool.Weapons.ScrollingFrame.entry:clone();

local function updateView() -- Line: 112
    -- upvalues: u2 (copy), Main (copy), u5 (ref), TeamRules (copy), u6 (ref), u7 (ref), u8 (copy), updateView (copy)
    for i, v in pairs(u2) do
        local v9 = Main.GameRules:FindFirstChild(v);
        v9.Selector.ImageColor3 = u5[i] and Color3.fromRGB(0, 206, 0) or Color3.fromRGB(202, 48, 48);
        v9.Selector.TextLabel.Text = u5[i] and "ON" or "OFF";
    end;

    for _, v in pairs({ "TRC", "TBC", "TYC", "TGC" }) do
        local v10 = TeamRules.Teams:FindFirstChild(v);

        if v10 then
            v10.ImageLabel.Visible = not u5.teams[v].canJoin;
            v10.UIStroke.Enabled = u6 == v;
        end;
    end;

    Main.GameRules.TimerSet.Selector.Box.Text = u5.timerLength;
    local v11 = u5.teams[u6];
    TeamRules.TeamSize.Selector.Box.Text = v11.maxSize;
    TeamRules.Pool.Selector.TextLabel.Text = "Pool " .. v11.pool;
    TeamRules.Health.Selector.Box.Text = v11.health;
    TeamRules.Speed.Selector.Box.Text = v11.speed;
    TeamRules.Regen.Selector.Box.Text = v11.regen;
    TeamRules.Pool.Enable.ImageLabel.Visible = v11.poolenabled;
    TeamRules.Regen.Enable.ImageLabel.Visible = v11.regenenabled;
    TeamRules.Gravity.Enable.ImageLabel.Visible = v11.gravityenabled;
    local WeaponPool = Main.WeaponPool;
    WeaponPool.Weapons.PoolSelect.Selector.TextLabel.Text = "Pool " .. u7;

    for _, child in pairs(WeaponPool.Weapons.ScrollingFrame:GetChildren()) do
        if child:IsA("ImageLabel") then
            child:Destroy();
        end;
    end;

    for i, v in pairs(u5.pools[u7] or {}) do
        local v12 = u8:clone();
        v12.Num.TextLabel.Text = i;
        v12.LayoutOrder = i;
        v12.TextLabel.Text = v;
        v12.Delete.MouseButton1Click:connect(function() -- Line: 162
            -- upvalues: u5 (ref), u7 (ref), i (copy), updateView (ref)
            table.remove(u5.pools[u7], i);
            updateView();
        end);
        v12.Selector.up.MouseButton1Click:connect(function() -- Line: 166
            -- upvalues: i (copy), u5 (ref), u7 (ref), updateView (ref)
            if i == 1 then
                return;
            end;

            local table_remove_ret = table.remove(u5.pools[u7], i);
            table.insert(u5.pools[u7], i - 1, table_remove_ret);
            updateView();
        end);
        v12.Selector.down.MouseButton1Click:connect(function() -- Line: 172
            -- upvalues: i (copy), u5 (ref), u7 (ref), updateView (ref)
            if i == #u5.pools[u7] then
                return;
            end;

            local table_remove_ret = table.remove(u5.pools[u7], i);
            table.insert(u5.pools[u7], i + 1, table_remove_ret);
            updateView();
        end);
        v12.Parent = WeaponPool.Weapons.ScrollingFrame;
    end;
end;

for _, v in pairs({ "TRC", "TBC", "TYC", "TGC" }) do
    local v13 = script_Parent.Main.TeamRules.Teams:FindFirstChild(v);

    if v13 then
        v13.MouseButton1Click:connect(function() -- Line: 185
            -- upvalues: u6 (ref), v (copy), updateView (copy)
            u6 = v;
            updateView();
        end);
    end;
end;

TeamRules.Teams.Lock.MouseButton1Click:connect(function() -- Line: 192
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].canJoin = not u5.teams[u6].canJoin;
    updateView();
end);
TeamRules.Pool.Enable.MouseButton1Click:connect(function() -- Line: 197
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].poolenabled = not u5.teams[u6].poolenabled;
    updateView();
end);
TeamRules.Gravity.Enable.MouseButton1Click:connect(function() -- Line: 202
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].gravityenabled = not u5.teams[u6].gravityenabled;
    updateView();
end);
TeamRules.Regen.Enable.MouseButton1Click:connect(function() -- Line: 207
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].regenenabled = not u5.teams[u6].regenenabled;
    updateView();
end);
TeamRules.Pool.Selector.Right.MouseButton1Click:connect(function() -- Line: 212
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].pool = math.clamp(u5.teams[u6].pool + 1, 1, 4);
    updateView();
end);
TeamRules.Pool.Selector.Left.MouseButton1Click:connect(function() -- Line: 217
    -- upvalues: u5 (ref), u6 (ref), updateView (copy)
    u5.teams[u6].pool = math.clamp(u5.teams[u6].pool - 1, 1, 4);
    updateView();
end);

for i, v in pairs({
    Health = 100,
    Regen = 20,
    Gravity = 55.52,
    TeamSize = 16,
    Speed = 1
}) do
    local u14 = Main.TeamRules:FindFirstChild(i);
    u14.Selector.Lock.MouseButton1Click:connect(function() -- Line: 234
        -- upvalues: u14 (copy), v (copy)
        u14.Selector.Box.Text = v;
        u14.Selector.Box:ReleaseFocus(true);
    end);
end;

Main.WeaponPool.Weapons.PoolSelect.Selector.Right.MouseButton1Click:connect(function() -- Line: 240
    -- upvalues: u7 (ref), updateView (copy)
    u7 = math.clamp(u7 + 1, 1, 4);
    updateView();
end);
Main.WeaponPool.Weapons.PoolSelect.Selector.Left.MouseButton1Click:connect(function() -- Line: 245
    -- upvalues: u7 (ref), updateView (copy)
    u7 = math.clamp(u7 - 1, 1, 4);
    updateView();
end);
TeamRules.TeamSize.Selector.Box.FocusLost:connect(function(p15) -- Line: 250
    -- upvalues: TeamRules (copy), u5 (ref), u6 (ref), updateView (copy)
    local v16 = p15 and tonumber(TeamRules.TeamSize.Selector.Box.Text);

    if v16 then
        u5.teams[u6].maxSize = math.clamp(v16, 1, 16);
    end;

    updateView();
end);
TeamRules.Gravity.Selector.Box.FocusLost:connect(function(p17) -- Line: 261
    -- upvalues: TeamRules (copy), u5 (ref), u6 (ref), updateView (copy)
    local v18 = p17 and tonumber(TeamRules.Gravity.Selector.Box.Text);

    if v18 then
        u5.teams[u6].gravity = math.clamp(v18, 0, 250);
    end;

    updateView();
end);
Main.GameRules.TimerSet.Selector.Box.FocusLost:connect(function(p19) -- Line: 272
    -- upvalues: Main (copy), u5 (ref), updateView (copy)
    local v20 = p19 and tonumber(Main.GameRules.TimerSet.Selector.Box.Text);

    if v20 then
        local math_clamp_ret = math.clamp(v20, 0, 900);
        u5.timerLength = math.ceil(math_clamp_ret);
    end;

    updateView();
end);

for _, v in pairs({ TeamRules.Speed.Selector.Box, TeamRules.Health.Selector.Box, TeamRules.Regen.Selector.Box }) do
    v.FocusLost:connect(function(p21) -- Line: 284
        -- upvalues: v (copy), u5 (ref), u6 (ref), updateView (copy)
        if p21 then
            local v22 = v.Parent.Parent.Name:lower();
            local v23 = tonumber(v.Text);

            if v23 and v23 > 0 and (v22 == "health" and v23 <= 5000 or (v22 == "speed" and v23 <= 5 or v22 == "regen" and v23 <= 5000)) then
                u5.teams[u6]["" .. v22] = v23;
            end;
        end;

        updateView();
    end);
end;

for i, v in pairs(u2) do
    Main.GameRules:FindFirstChild(v).Selector.MouseButton1Click:connect(function() -- Line: 300
        -- upvalues: u5 (ref), i (copy), updateView (copy)
        u5[i] = not u5[i];
        updateView();
    end);
end;

local function addWeapon() -- Line: 306
    -- upvalues: Main (copy), u5 (ref), u7 (ref), updateView (copy)
    local Box = Main.WeaponPool.Weapons.EnterGun.Box;
    local Text = Box.Text;
    Box.Text = "";

    for _, child in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
        if child:FindFirstChild("AdminWeapon") == nil and child.Name:lower() == Text:lower() then
            table.insert(u5.pools[u7], child.Name);
            updateView();

            return;
        end;
    end;

    Box.Text = "Weapon could not be found :(";
    wait(1.5);
    Box.Text = "";
end;

Main.WeaponPool.Weapons.Add.MouseButton1Click:connect(addWeapon);
Main.WeaponPool.Weapons.EnterGun.Box.FocusLost:connect(function(p24) -- Line: 326
    -- upvalues: addWeapon (copy)
    if p24 then
        addWeapon();
    end;
end);
script_Parent.Parent:WaitForChild("CMSetup").Event:connect(function() -- Line: 332
    -- upvalues: u6 (ref), u7 (ref), u5 (ref), deepCopy (copy), u1 (copy), updateView (copy), script_Parent (copy), Main (copy)
    u6 = "TRC";
    u7 = 1;
    u5 = deepCopy(u1);
    updateView();
    script_Parent.Enabled = true;
    Main.Save.Visible = false;
    Main.WeaponPool.Visible = true;
end);
Main.Close.MouseButton1Click:connect(function() -- Line: 342
    -- upvalues: script_Parent (copy)
    script_Parent.Enabled = false;
end);
Main.Save.Add.MouseButton1Click:connect(function() -- Line: 346
    -- upvalues: script_Parent (copy), CustomModeSetup (copy), u5 (ref)
    script_Parent.Enabled = false;
    script_Parent.Parent.ToggleVIP:Fire();
    CustomModeSetup:FireServer(0, u5);
    game.ReplicatedStorage.Functions.Zip:InvokeServer("cmd2", "Custom");
end);
Main.WeaponPool.Add.MouseButton1Click:connect(function() -- Line: 353
    -- upvalues: Main (copy)
    Main.Save.Visible = true;
    Main.WeaponPool.Visible = false;
end);
local main = Main.Save.main;
local u25 = 1;
main.PoolSelect.Selector.Right.MouseButton1Click:connect(function() -- Line: 363
    -- upvalues: u25 (ref), main (copy)
    u25 = math.clamp(u25 + 1, 1, 8);
    main.PoolSelect.Selector.TextLabel.Text = "Slot " .. u25;
end);
main.PoolSelect.Selector.Left.MouseButton1Click:connect(function() -- Line: 368
    -- upvalues: u25 (ref), main (copy)
    u25 = math.clamp(u25 - 1, 1, 8);
    main.PoolSelect.Selector.TextLabel.Text = "Slot " .. u25;
end);
Main.Save.Cancel.MouseButton1Click:connect(function() -- Line: 373
    -- upvalues: Main (copy)
    Main.Save.Visible = false;
    Main.WeaponPool.Visible = true;
end);
main.Save.MouseButton1Click:connect(function() -- Line: 378
    -- upvalues: CustomModeSetup (copy), u25 (ref), u5 (ref)
    CustomModeSetup:FireServer(2, u25, u5);
end);
main.Load.MouseButton1Click:connect(function() -- Line: 382
    -- upvalues: CustomModeSetup (copy), u25 (ref)
    CustomModeSetup:FireServer(1, u25);
end);
main.Import.MouseButton1Click:connect(function() -- Line: 386
    -- upvalues: CustomModeSetup (copy), main (copy)
    CustomModeSetup:FireServer(4, main.EnterGun.Box.Text);
end);
main.Export.MouseButton1Click:connect(function() -- Line: 390
    -- upvalues: CustomModeSetup (copy), u5 (ref)
    CustomModeSetup:FireServer(3, u5);
end);
CustomModeSetup.OnClientEvent:connect(function(p26, ...) -- Line: 394
    -- upvalues: u6 (ref), u7 (ref), u5 (ref), deepCopy (copy), updateView (copy), script_Parent (copy), Main (copy), main (copy), u25 (ref)
    local v27 = { ... };

    if p26 ~= 0 then
        if p26 ~= 1 then
            if p26 == 2 then
                local v28 = v27[1] == 0 and main.status or main.status2;
                v28.Text = v27[2];
                wait(2);
                v28.Text = "";
            end;

            return;
        end;

        main.status.Text = "Exported successfully! Copy ID below.";
        main.EnterGun.Box.Text = v27[1];
        wait(4);
        main.status.Text = "";

        return;
    end;

    if v27[1] == nil then
        main.status2.Text = "Slot " .. u25 .. " is empty!";
        wait(2);
        main.status2.Text = "";

        return;
    end;

    u6 = "TRC";
    u7 = 1;
    u5 = deepCopy(v27[1]);
    updateView();
    script_Parent.Enabled = true;
    Main.Save.Visible = false;
    Main.WeaponPool.Visible = true;
end);