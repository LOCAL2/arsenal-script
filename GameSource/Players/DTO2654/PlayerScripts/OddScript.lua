-- Decompiled with Potassium's decompiler.

game.Players.LocalPlayer:WaitForChild("NRPBS");
game.Players.LocalPlayer.NRPBS.ChildAdded:Connect(function(p1) -- Line: 3
    if p1.Name == "OW3" then
        p1.Value = tick();
    end;
end);

function fixmylife(p2)
    if script:FindFirstChild((tostring(p2))) ~= nil then
        return false;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = tostring(p2);
    Folder.Parent = script;

    return true;
end;

local LocalPlayer = game.Players.LocalPlayer;

while wait(5) do
    if LocalPlayer:FindFirstChild("BadgeTracker") then
        if LocalPlayer.BadgeTracker:FindFirstChild("KF_SoapSliding") and (LocalPlayer.BadgeTracker.KF_SoapSliding.Value >= 1000 and fixmylife(2124991789)) then
            game.ReplicatedStorage.Events.MoreFreeBadgesEnjoy:FireServer(2124991789);
        end;

        if LocalPlayer.BadgeTracker:FindFirstChild("KF_RocketAltitude") and (LocalPlayer.BadgeTracker.KF_RocketAltitude.Value >= 1000 and fixmylife(2124991803)) then
            game.ReplicatedStorage.Events.MoreFreeBadgesEnjoy:FireServer(2124991803);
        end;

        if LocalPlayer.BadgeTracker:FindFirstChild("AnnouncerComments") and (LocalPlayer.BadgeTracker.AnnouncerComments.Value >= 50 and fixmylife(111958650)) then
            game.ReplicatedStorage.Events.MoreFreeBadgesEnjoy:FireServer(111958650);
        end;
    end;
end;