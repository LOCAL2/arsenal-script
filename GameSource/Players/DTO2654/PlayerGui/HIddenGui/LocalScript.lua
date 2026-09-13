-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

function TweenIn()
    -- upvalues: TweenService (copy)
    TweenService:Create(script.Parent.MyText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(script.Parent.MyText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        TextStrokeTransparency = 0
    }):Play();
    wait(1.5);
end;

function TweenOut()
    -- upvalues: TweenService (copy)
    TweenService:Create(script.Parent.MyText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(script.Parent.MyText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        TextStrokeTransparency = 1
    }):Play();
    wait(1.5);
end;

game.ReplicatedStorage.Events.TCtullysBigStinkyEvent2.OnClientEvent:Connect(function() -- Line: 18
    -- upvalues: TweenService (copy), RunService (copy)
    script.Parent.Enabled = true;
    TweenService:Create(script.Parent.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 0
    }):Play();
    wait(1);

    for _, descendant in pairs(workspace.CurrentCamera:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local u1 = workspace.Map.Cam.CamPos1:Clone();
    u1.Parent = workspace;
    TweenService:Create(u1, TweenInfo.new(20, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        CFrame = workspace.Map.Cam.CamPos2.CFrame
    }):Play();
    RunService:BindToRenderStep("Cutscene", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 33
        -- upvalues: u1 (copy)
        workspace.CurrentCamera.CFrame = u1.CFrame;
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = u1.CFrame;
    end);
    TweenService:Create(script.Parent.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    }):Play();
    script.Parent.MyText.Text = game.Players.LocalPlayer.Name .. "\'s Big Adventure";
    TweenIn();
    local Sound = Instance.new("Sound");
    Sound.PlaybackSpeed = 0.95;
    Sound.Parent = script.Parent;
    Sound.SoundId = "rbxassetid://1844487039";
    Sound:Play();
    wait(3);
    TweenOut();
    script.Parent.MyText.Text = "Developed by a bored person.";
    TweenIn();
    wait(3);
    TweenOut();
    script.Parent.MyText.Text = "E";
    TweenIn();
    wait(5);
    TweenOut();
    wait(5);
    TweenService:Create(script.Parent.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 0
    }):Play();
end);