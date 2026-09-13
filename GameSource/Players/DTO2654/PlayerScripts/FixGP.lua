-- Decompiled with Potassium's decompiler.

uis = game:GetService("UserInputService");
haptic = game:GetService("HapticService");
game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("GPfix");
game.ReplicatedStorage.Events.GPfix.OnClientEvent:Connect(function() -- Line: 6
    wait(0.5);
    haptic:SetMotor(uis:GetLastInputType(), Enum.VibrationMotor.Large, 0);
    haptic:SetMotor(uis:GetLastInputType(), Enum.VibrationMotor.Small, 0);
end);