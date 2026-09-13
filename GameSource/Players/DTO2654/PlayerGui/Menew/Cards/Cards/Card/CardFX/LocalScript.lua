-- Decompiled with Potassium's decompiler.

local v1 = game:GetService("TweenService"):Create(script.Parent.UIGradient, TweenInfo.new(2.5), {
    Offset = Vector2.new(-1.5, 0)
});
game:GetService("TweenService"):Create(script.Parent.Frame, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 999999, true), {
    Position = UDim2.new(0, 0, -1.5, 0)
}):Play();

while true do
    if script.Parent.Parent.Parent.Parent.Visible then
        v1:Play();
        task.wait(4);
        script.Parent.UIGradient.Offset = Vector2.new(1, 0);
        v1:Cancel();
    end;

    task.wait();
end;