-- Decompiled with Potassium's decompiler.

game.Players.LocalPlayer:WaitForChild("Settings"):WaitForChild("TwentiesFilter");
game.ReplicatedStorage:WaitForChild("wkspc");
local UDim2_new = UDim2.new;
local _ = math.random;
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "FilmGrain";
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 99;
ScreenGui.Parent = PlayerGui;
local ImageLabel = Instance.new("ImageLabel");
ImageLabel.Size = UDim2_new(1, 0, 1, 0);
ImageLabel.BackgroundTransparency = 1;
ImageLabel.ImageTransparency = 0.9;
ImageLabel.ScaleType = Enum.ScaleType.Tile;
ImageLabel.Image = "http://www.roblox.com/asset/?id=28756351";
ImageLabel.Parent = ScreenGui;
local u1 = 0;
game:GetService("RunService").Heartbeat:Connect(function() -- Line: 32
    -- upvalues: u1 (ref), ImageLabel (copy)
    if tick() - u1 < 0.025 then
        return;
    end;

    u1 = tick();

    if game.Players.LocalPlayer and (game.Players.LocalPlayer:FindFirstChild("Settings") and game.Players.LocalPlayer.Settings.TwentiesFilter.Value) then
        local _ = game.ReplicatedStorage.wkspc.FFA.Value == true;
    end;

    ImageLabel.Visible = false;
end);