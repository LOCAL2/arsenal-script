-- Decompiled with Potassium's decompiler.

wait(2);

if game.PlaceId ~= 2583768547 then
    return;
end;

if require(game.ReplicatedStorage.Modules.ModCheck).isDev(game.Players.LocalPlayer) then
    script.Parent.Visible = true;
    script.Parent.MouseButton1Click:Connect(function() -- Line: 9
        workspace._Coop:FireServer("a");
    end);
end;

script.Parent.TextBox.FocusLost:Connect(function(p1) -- Line: 14
    if p1 then
        workspace._Coop:FireServer("b", script.Parent.TextBox.Text);
    end;
end);