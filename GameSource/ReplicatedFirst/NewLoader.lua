-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("ScriptContext");
game:GetService("ContentProvider");
game:GetService("TeleportService");

repeat
    wait();
until #game.ReplicatedStorage:WaitForChild("Weapons"):GetChildren() >= 20;

workspace:WaitForChild("Sounds");
game.ReplicatedStorage:WaitForChild("wkspc"):WaitForChild("Status");
workspace:WaitForChild("SpectatorBox");
workspace:WaitForChild("KillFeed");
replicated = game.ReplicatedStorage;
replicated:WaitForChild("Weapons");
game.Players.LocalPlayer:WaitForChild("PlayerGui", 2100000000);
game.Players.LocalPlayer.PlayerGui:WaitForChild("Menew", 2100000000);
game.Players.LocalPlayer:WaitForChild("Initial", 2100000000);
game.Players.LocalPlayer.PlayerGui.Menew.Enabled = true;
game.Players.LocalPlayer.PlayerGui:WaitForChild("Menew_Main", 2100000000).Enabled = true;
local IntValue = Instance.new("IntValue");
IntValue.Name = "FillMeIn!";
IntValue.Parent = game.Players.LocalPlayer;