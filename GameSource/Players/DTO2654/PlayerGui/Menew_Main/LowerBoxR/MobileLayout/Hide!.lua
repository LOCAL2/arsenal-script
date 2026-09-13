-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
script.Parent.Visible = UserInputService:GetLastInputType() == Enum.UserInputType.Touch;
UserInputService.LastInputTypeChanged:Connect(function() -- Line: 5, Name: update
    -- upvalues: UserInputService (copy)
    script.Parent.Visible = UserInputService:GetLastInputType() == Enum.UserInputType.Touch;
end);