-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local NewEventBandwithHogger = ReplicatedStorage.Events.NewEventBandwithHogger;
local Frame = script.Parent.Frame;
local active = script.Parent.active;
require(game.ReplicatedStorage.Modules.Linker);
local TweenInfo_new_ret = TweenInfo.new(0.175, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local TweenInfo_new_ret2 = TweenInfo.new(0.5249999999999999, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
local Scale = Frame.Size.Y.Scale;

function moveup()
    -- upvalues: active (copy)
    for _, child in active:GetChildren() do
        child.Position = UDim2.new(child.Position.X.Scale, 0, child.Position.Y.Scale + 0.101, 0);
    end;
end;

function trnstext(p1)
    for _, child in p1:GetChildren() do
        if child:IsA("TextLabel") then
            child.TextTransparency = 1;
        end;
    end;
end;

NewEventBandwithHogger.OnClientEvent:Connect(function(p2, p3, p4, p5) -- Line: 98
    -- upvalues: Frame (copy), active (copy), Scale (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    local v6 = Frame:Clone();
    local v7 = v6.ContractName:Clone();

    if p2 == "Liftoff! The Final Chapter" then
        local Attribute = game.Players.LocalPlayer:GetAttribute("StoodThere");

        if Attribute and Attribute >= 50 then
            v6.Generic.Text = "Bounty Cheesed 🧀";
        end;
    end;

    if p5 then
        script.O_O:Play();
        v6.Generic.Text = "Item Unlocked!";
    end;

    if p4 then
        v6.Reward.Text = "+" .. p4;
    end;

    v6.ContractName.Text = p2;

    if p3 then
        v7.Text = p3;
    end;

    v7.Name = "desc";
    v7.Parent = v6;
    moveup();
    v6.Visible = true;
    v6.Parent = active;
    trnstext(v6);
    v6.Size = UDim2.new(v6.Size.X.Scale, 0, 0, 0);
    v6:TweenSize(UDim2.new(v6.Size.X.Scale, 0, Scale, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.25, true);
    task.wait(0.25);
    local v8 = TweenService:Create(v6.ContractName, TweenInfo_new_ret, {
        TextTransparency = 0
    });
    local v9 = TweenService:Create(v6.Generic, TweenInfo_new_ret, {
        TextTransparency = 0
    });
    v8:Play();
    v9:Play();
    task.wait(1.75);
    v8:Destroy();
    v9:Destroy();

    if p5 then
        task.wait(1.75);
        local v10 = TweenService:Create(v6.Generic, TweenInfo_new_ret, {
            TextTransparency = 1
        });
        local v11 = TweenService:Create(v6.ContractName, TweenInfo_new_ret, {
            TextTransparency = 1
        });
        local v12 = TweenService:Create(v6, TweenInfo_new_ret2, {
            BackgroundTransparency = 1
        });
        v6.Frame.Visible = false;
        v6.Reward.Visible = false;
        v10:Play();
        v12:Play();
        v11:Play();
        task.wait(1);
        v10:Destroy();
        v12:Destroy();
        v11:Destroy();
        v6:Destroy();

        return;
    end;

    local v13 = TweenService:Create(v6.ContractName, TweenInfo_new_ret, {
        TextTransparency = 1
    });
    local v14 = TweenService:Create(v7, TweenInfo_new_ret, {
        TextTransparency = 0
    });
    v6.ContractName:TweenPosition(UDim2.new(v6.ContractName.Position.X.Scale, 0, v6.ContractName.Position.Y.Scale - 0.1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.175, true);
    v7.Position = UDim2.new(v7.Position.X.Scale, 0, v7.Position.Y.Scale + 0.1, 0);
    v7:TweenPosition(UDim2.new(v7.Position.X.Scale, 0, v7.Position.Y.Scale - 0.1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.175, true);
    v13:Play();
    v14:Play();
    task.wait(2.5);
    v13:Destroy();
    v14:Destroy();
    v6.Generic:TweenPosition(UDim2.new(v6.ContractName.Position.X.Scale, 0, v6.ContractName.Position.Y.Scale - 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.35, true);
    v7:TweenPosition(UDim2.new(v7.Position.X.Scale, 0, v7.Position.Y.Scale - 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.35, true);
    v6.Reward:TweenPosition(UDim2.new(v6.Reward.Position.X.Scale, 0, 0.5, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, 0.35, true);
    v6.Reward.TextTransparency = 0;
    task.wait(2.5);
    v6.Frame:Destroy();
    local v15 = TweenService:Create(v6, TweenInfo_new_ret2, {
        BackgroundTransparency = 1
    });
    local v16 = TweenService:Create(v6.Reward, TweenInfo_new_ret2, {
        TextTransparency = 1
    });
    local v17 = TweenService:Create(v6.Reward.Icon, TweenInfo_new_ret2, {
        BackgroundTransparency = 1
    });
    local v18 = TweenService:Create(v6.Reward.Icon.ActualIcon, TweenInfo_new_ret2, {
        ImageTransparency = 1
    });
    local v19;

    if v6.Reward.Icon:FindFirstChild("DropShadow") then
        v19 = TweenService:Create(v6.Reward.Icon.DropShadow, TweenInfo_new_ret2, {
            ImageTransparency = 1
        });
    else
        v19 = nil;
    end;

    v15:Play();
    v16:Play();
    v17:Play();
    v18:Play();

    if v19 then
        v19:Play();
    end;

    task.wait(0.5249999999999999);
    v6:Destroy();
    v15:Destroy();
    v16:Destroy();
    v17:Destroy();
    v18:Destroy();

    if v19 then
        v19:Destroy();
    end;
end);