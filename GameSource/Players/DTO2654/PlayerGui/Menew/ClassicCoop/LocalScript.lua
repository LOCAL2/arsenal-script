-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;

local function iterPageItems(u1) -- Line: 5
    return coroutine.wrap(function() -- Line: 6
        -- upvalues: u1 (copy)
        local v2 = 1;

        while true do
            for _, v in ipairs(u1:GetCurrentPage()) do
                coroutine.yield(v, v2);
            end;

            if u1.IsFinished then
                return;
            end;

            u1:AdvanceToNextPageAsync();
            v2 = v2 + 1;
        end;
    end);
end;

local u3 = nil;

local function refresh() -- Line: 23
    -- upvalues: script_Parent (copy), u3 (ref)
    local success, result = pcall(function() -- Line: 24
        return game.Players:GetFriendsAsync(game.Players.LocalPlayer.UserId);
    end);

    if not success then
        return;
    end;

    local Frame = script_Parent:WaitForChild("Join"):WaitForChild("Frame");

    for _, child in Frame:GetChildren() do
        if child:IsA("TextButton") and child.Name ~= "template" then
            child:Destroy();
        end;
    end;

    u3 = tick();

    for i in coroutine.wrap(function() -- Line: 6
        -- upvalues: result (copy)
        local v4 = 1;

        while true do
            for _, v in ipairs(result:GetCurrentPage()) do
                coroutine.yield(v, v4);
            end;

            if result.IsFinished then
                return;
            end;

            result:AdvanceToNextPageAsync();
            v4 = v4 + 1;
        end;
    end) do
        if i.IsOnline and i.PlaceId == game.PlaceId then
            local v5 = Frame.template:Clone();
            v5.Name = i.Username;
            v5.TextLabel.Text = i.Username;
            v5.ImageLabel.Image = game.Players:GetUserThumbnailAsync(i.Id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
            v5.Visible = true;
            v5.Parent = Frame;
            v5.MouseButton1Click:Connect(function() -- Line: 48
                -- upvalues: u3 (ref), i (copy)
                if tick() - u3 <= 0.5 then
                    return;
                end;

                workspace._Coop:FireServer("b", i.Username);
            end);
        end;
    end;
end;

task.spawn(refresh);
task.spawn(function() -- Line: 57
    -- upvalues: refresh (copy)
    while true do
        task.wait(5);
        refresh();
    end;
end);
script_Parent.Main.join.MouseButton1Down:Connect(function() -- Line: 64
    -- upvalues: refresh (copy)
    refresh();
end);

for _, child in script_Parent.Create.Frame:GetChildren() do
    if child:IsA("TextButton") then
        child.MouseButton1Click:Connect(function() -- Line: 70
            workspace._Coop:FireServer("a");
        end);
    end;
end;