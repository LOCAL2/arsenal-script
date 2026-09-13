-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local GuiService = game:GetService("GuiService");
game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;
local LocalPlayer = Players.LocalPlayer;
local UIColorScript = require(ReplicatedStorage.Modules.UIColorScript);
local Sound = require(ReplicatedStorage.Modules.Sound);
local script_UIElements = require(script.UIElements);
local GuiInset = GuiService:GetGuiInset();
local EventStart = ReplicatedStorage.EventStart;
local u1 = {};
local u2 = "Delinquent";
local u3 = {};

repeat
    wait(1);
until LocalPlayer.Character;

local function doRewardUI(p4, u5) -- Line: 27
    -- upvalues: script_Parent (copy), ReplicatedStorage (copy), u2 (ref), doRewardUI (copy), u3 (ref)
    for _, child in pairs(script_Parent.Parent.Menew.Main.Reward.Reward:GetChildren()) do
        if child:IsA("ViewportFrame") or child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    for _, v in pairs(p4) do
        pcall(function() -- Line: 35
            -- upvalues: u5 (copy), ReplicatedStorage (ref), v (copy), script_Parent (ref), u2 (ref), doRewardUI (ref), u3 (ref)
            local v6;

            if u5 == "Skin" then
                v6 = script.Character:Clone();
            else
                v6 = script.Unusual:Clone();
                v6.Image = ReplicatedStorage.ItemData.Images.UnusualIcons[v].Value;
            end;

            v6.Item.Text = v;
            v6.Name = v;
            v6.Parent = script_Parent.Parent.Menew.Main.Reward.Reward;
            local v7 = nil;
            local v8 = nil;

            if u5 == "Skin" then
                v8 = ReplicatedStorage.ChrModels[v]:Clone();
                v8.Parent = v6;
                v7 = Instance.new("Camera");
                v7.CFrame = CFrame.new((Vector3.new()));
                v7.Parent = v6;
            else
                script_Parent.Parent.Menew.Main.Reward.Reward.Sort.CellSize = UDim2.new(0.24, 0, 0, 150);
            end;

            if u5 == "Skin" then
                v8:SetPrimaryPartCFrame(v7.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0));
                v6.CurrentCamera = v7;
            end;

            v6.Click.MouseButton1Down:connect(function() -- Line: 65
                -- upvalues: u5 (ref), u2 (ref), v (ref), script_Parent (ref), doRewardUI (ref), u3 (ref), ReplicatedStorage (ref)
                if u5 ~= "Skin" then
                    script_Parent.Parent.Menew.Main.Reward:Destroy();
                    ReplicatedStorage.Rewards:FireServer(u2, v);

                    return;
                end;

                u2 = v;
                script_Parent.Parent.Menew.Main.Reward.Top.ImageLabel.TextLabel.Text = "1 Free Unusual";
                doRewardUI(u3, "Unusual");
            end);
        end);
    end;

    script_Parent.Parent.Menew.Main.Reward.Reward.CanvasSize = UDim2.new(0, 0, 0, script_Parent.Parent.Menew.Main.Reward.Reward.Sort.AbsoluteContentSize.Y + 5);
end;

ReplicatedStorage.Rewards.OnClientEvent:connect(function(p9, p10) -- Line: 81
    -- upvalues: EventStart (copy), u1 (ref), u3 (ref), doRewardUI (copy), script_Parent (copy)
    if EventStart.Value <= 0 then
        u1 = p9;
        u3 = p10;
        doRewardUI(u1, "Skin");
        script_Parent.Parent.Menew.Main.Reward.Visible = true;
    end;
end);

local function doIntro() -- Line: 90
    -- upvalues: script_Parent (copy)
    script_Parent.DisplayOrder = 10;

    if script_Parent:FindFirstChild("Transition") then
        script_Parent.Transition.BackgroundTransparency = 0;
    end;

    doHalloweenUI();

    if script_Parent:FindFirstChild("Transition") then
        script_Parent.Transition.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    end;

    wait(0.15);
    script_Parent.DisplayOrder = 0;

    if script_Parent:FindFirstChild("Transition") then
        script_Parent.Transition:Destroy();
    end;
end;

function doHalloweenUI()
    -- upvalues: script_UIElements (copy), script_Parent (copy), UIColorScript (copy), GuiInset (copy)
    for _, v in pairs(script_UIElements) do
        if v[1]:IsA("TextLabel") or v[1]:IsA("TextButton") then
            v[1].Font = v[2];

            if v[1]:FindFirstChild("Gradient") then
                v[1].Gradient.Enabled = true;
            end;
        end;
    end;

    script_Parent.Parent.Menew.Main.ChallengesLabel.ImageLabel.Icon.Image = "rbxassetid://5866393842";
    script_Parent.Parent.Menew.Main.Contracts.TopBar.OpenShop.Visible = true;
    script_Parent.Parent.Menew.ChangeColor.ImgBox.ExampleLabel.TextLabel.Text = "Operative Orange";
    UIColorScript:ColorMe("Orange");
    script_Parent.Parent.Menew.SharedColorData.CurrentColor.Value = "Orange";
    script_Parent.Parent.UpdateSetting:Fire("MenuColor", "Orange");

    for _, descendant in pairs(script_Parent.Parent:GetDescendants()) do
        if (descendant.Name == "HWOverlay" or descendant.Name == "HWOverlayTop") and descendant:IsA("ImageLabel") then
            descendant.Visible = true;
            descendant.Position = descendant.Position - UDim2.new(0, 0, 0, GuiInset.Y);
            descendant.Size = descendant.Size + UDim2.new(0, 0, 0, GuiInset.Y);
        end;
    end;
end;

local function doHalloweenTime() -- Line: 179
    -- upvalues: script_Parent (copy), doIntro (copy), ReplicatedStorage (copy)
    script_Parent.Backdrop.Countdown.Text = "LOADING";
    doIntro();

    repeat
        wait(0.1);
    until ReplicatedStorage.ChrModels:FindFirstChild("Tetra");

    script_Parent.Backdrop.Visible = false;
    wait(1);
    script_Parent.Parent.UpdateContract:Fire();
end;

function doTaunt(p11, p12, p13)
    local v14 = p13[math.random(1, #p13)];
    v14:Play();
    wait(v14.Length);

    if p11 and p11.Parent then
        doIdle(p11, p12, p13);
    end;
end;

function doIdle(p15, p16, p17)
    p16:Play();
    wait(p16.Length);

    if p15 and p15.Parent then
        doTaunt(p15, p16, p17);
    end;
end;

local function doMaps() -- Line: 236
    -- upvalues: Workspace (copy), Sound (copy), LocalPlayer (copy)
    wait(3);

    if not ((Workspace:FindFirstChild("Map") or Workspace:FindFirstChild("Monastery")) and Workspace.Map:WaitForChild("Geometry"):FindFirstChild("Church")) then
        if Workspace:FindFirstChild("Map") and (Workspace.Map:WaitForChild("Ignore") and (Workspace.Map.Ignore:FindFirstChild("Kraken") and (Workspace.Map.Ignore.Kraken:FindFirstChild("EyeL") and Workspace.Map.Ignore.Kraken:FindFirstChild("EyeR")))) then
            while Workspace.Map and (Workspace.Map.Parent and (wait(0.035) and (Workspace.Map:WaitForChild("Ignore") and (Workspace.Map.Ignore:FindFirstChild("Kraken") and (Workspace.Map.Ignore.Kraken:FindFirstChild("EyeL") and Workspace.Map.Ignore.Kraken:FindFirstChild("EyeR")))))) do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                    Workspace.Map.Ignore.Kraken.EyeL.CFrame = CFrame.new(Workspace.Map.Ignore.Kraken.EyeL.CFrame.p, LocalPlayer.Character.Head.CFrame.p) * CFrame.Angles(3.141592653589793, 0, 0);
                    Workspace.Map.Ignore.Kraken.EyeR.CFrame = CFrame.new(Workspace.Map.Ignore.Kraken.EyeR.CFrame.p, LocalPlayer.Character.Head.CFrame.p) * CFrame.Angles(3.141592653589793, 0, 0);
                end;
            end;
        end;

        return;
    end;

    local v18 = Workspace:FindFirstChild("Monastery") or Workspace:FindFirstChild("Map");

    for _, descendant in pairs(v18:GetDescendants()) do
        if descendant.Name == "CageSkeleton" then
            local AnimationController = descendant:WaitForChild("AnimationController");
            local v19 = { AnimationController:LoadAnimation(script.Skeletons.Taunt1), AnimationController:LoadAnimation(script.Skeletons.Taunt2), AnimationController:LoadAnimation(script.Skeletons.Taunt3) };
            local v20 = AnimationController:LoadAnimation(script.Skeletons.Idle);
            v19[1].KeyframeReached:connect(function(p21) -- Line: 246
                -- upvalues: Sound (ref), descendant (copy)
                if p21 == "Shake" then
                    Sound.playsound(script.Skeletons.Shake, descendant.HumanoidRootPart);
                end;
            end);
            doIdle(descendant, v20, v19);
        end;
    end;
end;