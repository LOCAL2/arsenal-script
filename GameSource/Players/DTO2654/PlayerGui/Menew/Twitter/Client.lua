-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local CreateCode = ReplicatedStorage:FindFirstChild("CreateCode");
local script_Parent = script.Parent;

if require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ModCheck")).isDev(LocalPlayer) then
    script_Parent.Create.MouseButton1Down:connect(function() -- Line: 18
        -- upvalues: script_Parent (copy), CreateCode (copy)
        local v1 = CreateCode:InvokeServer(script_Parent.Code.Text, script_Parent.Reward.Text, script_Parent.Time.Text, script_Parent.ItemType.Text, script_Parent.Copies.Text);
        script_Parent.Create.Text = v1;
        task.wait(2);
        script_Parent.Create.Text = "CREATE";
    end);
    script_Parent.Delete.MouseButton1Down:Connect(function() -- Line: 33
        -- upvalues: CreateCode (copy), script_Parent (copy)
        local v2 = CreateCode:InvokeServer(script_Parent.Code.Text, "DELETE");
        script_Parent.Create.Text = v2;
        task.wait(2);
        script_Parent.Create.Text = "CREATE";
    end);
    UserInputService.InputBegan:connect(function(p3) -- Line: 43
        -- upvalues: script_Parent (copy)
        if p3.KeyCode == Enum.KeyCode.Home then
            script_Parent.Visible = not script_Parent.Visible;
        end;
    end);
end;